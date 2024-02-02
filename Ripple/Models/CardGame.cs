using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class CardGame
{
    public uint CardGameId { get; set; }

    public string Name { get; set; } = null!;

    public string Picture { get; set; } = null!;

    public uint NumPlayers { get; set; }

    public string Rules { get; set; } = null!;

    public virtual ICollection<Lobby> Lobby { get; } = new List<Lobby>();
}
