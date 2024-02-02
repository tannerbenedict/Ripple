using FamilyGameNight.Models.SignalR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;

namespace FamilyGameNight.Hubs;

[Authorize]
public class ChatHub : Hub
{
    private readonly ILogger<ChatHub> _logger;
    public ChatHub(ILogger<ChatHub> logger)
    {
        _logger = logger;
    }
    public async void JoinGroup(String lobbyCode) {
        if(!Context.Items.TryGetValue(Context.ConnectionId, out var lobbyCodes) || lobbyCodes == null) {
            lobbyCodes = new HashSet<String>();
            Context.Items.Add(Context.ConnectionId, lobbyCodes);
        }

        HashSet<String> lobbyCodesSet = (HashSet<String>)lobbyCodes;

        if(lobbyCodesSet.Contains(lobbyCode)) {
            _logger.Log(LogLevel.Warning, "Client tried to join lobby they were already a part of!");
            return;
        }

        lobbyCodesSet.Add(lobbyCode);
        await Groups.AddToGroupAsync(Context.ConnectionId, lobbyCode);
    }

    public async void SendMessage(ChatMessage msg, String lobbyCode)
    {
        await Clients.Group(lobbyCode).SendAsync("ReceiveMessage", msg);
    }

    public override async Task OnDisconnectedAsync(Exception? exception)
    {
        if(Context.Items.TryGetValue(Context.ConnectionId, out var lobbyCodes) && lobbyCodes != null) {
            HashSet<String> lobbyCodesSet = (HashSet<String>)lobbyCodes;
            foreach(String lobbyCode in lobbyCodesSet) {
                await Groups.RemoveFromGroupAsync(Context.ConnectionId, lobbyCode);
            }
        } else {
            _logger.Log(LogLevel.Warning, "Client disconnected without joining any lobbies!");
        }

        await base.OnDisconnectedAsync(exception);
    }
}