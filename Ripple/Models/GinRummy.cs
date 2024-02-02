using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class GinRummy
{
    public uint LobbyId { get; set; }

    public bool FirstTurn { get; set; }

    public string? Player1Matches { get; set; }

    public string? Player2Matches { get; set; }

    public virtual Lobby Lobby { get; set; } = null!;
}
