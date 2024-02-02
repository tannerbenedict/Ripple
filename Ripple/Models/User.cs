using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace FamilyGameNight.Models;

[Index(nameof(User.FirebaseId), IsUnique = true, Name = "UserFirebaseIdUniqueConstraint")]
public partial class User
{
    public uint UserId { get; set; }

    [MaxLength(100)]
    public string FirebaseId { get; set; } = null!;

    [DefaultValue(0)]
    public uint CurrentCoins { get; set; }

    public uint Settings { get; set; }

    public virtual ICollection<Lobby> LobbyHostNavigation { get; } = new List<Lobby>();

    public virtual ICollection<Lobby> LobbyPlayerTurnNavigation { get; } = new List<Lobby>();

    public virtual ICollection<Muted> MutedMutedByNavigation { get; } = new List<Muted>();

    public virtual ICollection<Muted> MutedPlayerMutedNavigation { get; } = new List<Muted>();

    public virtual ICollection<PlayerHand> PlayerHand { get; } = new List<PlayerHand>();

    public virtual ICollection<Players> Players { get; set; }

    public virtual Settings SettingsNavigation { get; set; } = null!;

    public virtual ICollection<User> Friend1 { get; } = new List<User>();

    public virtual ICollection<User> Friend2 { get; } = new List<User>();

    public virtual ICollection<User> FromUser { get; } = new List<User>();

    public virtual ICollection<User> FromUserNavigation { get; } = new List<User>();

    public virtual ICollection<Shop> Item { get; } = new List<Shop>();

    public virtual ICollection<User> ToUser { get; } = new List<User>();

    public virtual ICollection<User> ToUserNavigation { get; } = new List<User>();
}
