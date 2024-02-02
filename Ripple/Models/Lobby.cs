using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Lobby
{
    public uint LobbyId { get; set; }

    public uint PlayerTurn { get; set; }

    public bool GameOver { get; set; }

    public string TextChat { get; set; } = null!;

    public uint CardGame { get; set; }

    public uint Host { get; set; }

    public virtual CardGame CardGameNavigation { get; set; } = null!;

    public virtual ICollection<DiscardPile> DiscardPile { get; } = new List<DiscardPile>();

    public virtual ICollection<DrawPile> DrawPile { get; } = new List<DrawPile>();

    public virtual GinRummy? GinRummy { get; set; }

    public virtual User HostNavigation { get; set; } = null!;

    public virtual User PlayerTurnNavigation { get; set; } = null!;

    public virtual ICollection<Players> Players { get; } = new List<Players>();
}
