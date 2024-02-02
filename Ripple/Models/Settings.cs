using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Settings
{
    public uint SettingsId { get; set; }

    public bool Notifications { get; set; }

    public bool VoiceChat { get; set; }

    public uint VoiceChatVolume { get; set; }

    public uint GameVolume { get; set; }

    public virtual ICollection<User> User { get; } = new List<User>();
}
