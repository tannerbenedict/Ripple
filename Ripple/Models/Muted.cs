using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Muted
{
    public uint MutedBy { get; set; }

    public uint PlayerMuted { get; set; }

    public bool MutedToEveryone { get; set; }

    public virtual User MutedByNavigation { get; set; } = null!;

    public virtual User PlayerMutedNavigation { get; set; } = null!;
}
