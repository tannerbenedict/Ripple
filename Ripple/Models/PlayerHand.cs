using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class PlayerHand
{
    public uint PlayerHandId { get; set; }

    public uint User { get; set; }

    public uint Card { get; set; }
    public byte MatchGroup {get; set; }

    public virtual Card CardNavigation { get; set; } = null!;

    public virtual User UserNavigation { get; set; } = null!;
}
