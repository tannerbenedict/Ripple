using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class DiscardPile
{
    public uint DiscardPileId { get; set; }

    public uint Lobby { get; set; }

    public uint Card { get; set; }

    public virtual Card CardNavigation { get; set; } = null!;

    public virtual Lobby LobbyNavigation { get; set; } = null!;
}
