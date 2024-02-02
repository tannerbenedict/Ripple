using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Players
{
    public uint PlayerId { get; set; }
    public uint UserId { get; set; }

    public uint Lobby { get; set; }

    public uint Score { get; set; }

    public uint? TablePosition { get; set; }

    public uint? PositionPlaced { get; set; }

    public virtual Lobby LobbyNavigation { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
