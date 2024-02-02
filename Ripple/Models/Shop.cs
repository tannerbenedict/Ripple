using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Shop
{
    public uint ItemId { get; set; }

    public string Name { get; set; } = null!;

    public string Type { get; set; } = null!;

    public string Image { get; set; } = null!;

    public uint Coins { get; set; }

    public virtual ICollection<User> User { get; } = new List<User>();
}
