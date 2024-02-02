using FamilyGameNight.Hubs;
using FamilyGameNight.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

var AllowFlutterFrontEnd = "AllowFlutterFrontEnd";
var FLUTTER_WEB_URL = Environment.GetEnvironmentVariable("FLUTTER_WEB_URL") ?? "http://localhost:5000";

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddDbContext<FamilyGameNightContext>(options =>
    options.UseMySql(builder.Configuration["FGN:FGNConnectionString"],
        ServerVersion.AutoDetect(builder.Configuration["FGN:FGNConnectionString"])));

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        var appId = builder.Configuration["FirebaseProjectId"];
        Console.WriteLine(appId);
        options.Audience = appId;
        options.Authority = $"https://securetoken.google.com/{appId}";
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = options.Authority,
            RequireSignedTokens = builder.Environment.IsProduction(),
        };

        options.Events = new JwtBearerEvents
        {
            OnMessageReceived = context =>
            {
                var accessToken = context.Request.Query["access_token"];

                // If the request is for our hub...
                var path = context.HttpContext.Request.Path;
                if (!string.IsNullOrEmpty(accessToken) &&
                    (path.StartsWithSegments("/chatHub")))
                {
                    // Read the token out of the query string
                    context.Token = accessToken;
                }
                return Task.CompletedTask;
            }
        };
    });

builder.Services.AddSignalR().AddMessagePackProtocol();
builder.Services.AddLogging(options =>
{
    options.AddConsole();
    options.AddDebug();
});
builder.Services.AddCors(options =>
{
    //options.AddPolicy(name: AllowFlutterFrontEnd,
    //    policy =>
    //    {
    //        policy.WithOrigins(FLUTTER_WEB_URL);
    //        policy.WithHeaders("*");
    //    });
    options.AddPolicy(name: AllowFlutterFrontEnd,
    policy =>
    {
        policy.AllowAnyOrigin()
        .AllowAnyHeader()
        .AllowAnyMethod();
    });
});
var app = builder.Build();

// seed database if needed
using (var scope = app.Services.CreateScope())
{
    var DB = scope.ServiceProvider.GetRequiredService<FamilyGameNightContext>();
    await DB.InitializeCards();
}

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
});

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseDefaultFiles();
app.UseStaticFiles();

app.UseRouting();
app.UseCors(AllowFlutterFrontEnd);
app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.MapHub<ChatHub>("/chatHub");
app.Run();