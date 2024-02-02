using System;
using System.Collections.Generic;

namespace FamilyGameNight.Models;

public partial class Card
{
    public uint CardId { get; set; }

    public uint FaceValue { get; set; }

    public string Suit { get; set; } = null!;

    public virtual ICollection<DiscardPile> DiscardPile { get; } = new List<DiscardPile>();

    public virtual ICollection<DrawPile> DrawPile { get; } = new List<DrawPile>();

    public virtual ICollection<PlayerHand> PlayerHand { get; } = new List<PlayerHand>();
}
