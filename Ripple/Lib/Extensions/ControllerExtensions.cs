using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;

namespace FamilyGameNight.Lib.Extensions;

public static class ControllerExtensions
{
    public static string? GetFirebaseId(this Controller controller)
    {
        return controller.User.FindFirstValue(ClaimTypes.NameIdentifier);
    }
}