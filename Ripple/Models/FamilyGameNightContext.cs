using Microsoft.EntityFrameworkCore;

namespace FamilyGameNight.Models;

public partial class FamilyGameNightContext : DbContext
{
    private readonly IConfiguration _config;

    public FamilyGameNightContext(IConfiguration config)
    {
        _config = config;
    }

    public FamilyGameNightContext(DbContextOptions<FamilyGameNightContext> options, IConfiguration config)
        : base(options)
    {
        _config = config;
    }

    public FamilyGameNightContext(DbContextOptions<FamilyGameNightContext> options) : base(options)
    {
    }

    public virtual DbSet<Card> Card { get; set; }

    public virtual DbSet<CardGame> CardGame { get; set; }

    public virtual DbSet<DiscardPile> DiscardPile { get; set; }

    public virtual DbSet<DrawPile> DrawPile { get; set; }

    public virtual DbSet<GinRummy> GinRummy { get; set; }

    public virtual DbSet<Lobby> Lobby { get; set; }

    public virtual DbSet<Muted> Muted { get; set; }

    public virtual DbSet<PlayerHand> PlayerHand { get; set; }

    public virtual DbSet<Players> Players { get; set; }

    public virtual DbSet<Settings> Settings { get; set; }

    public virtual DbSet<Shop> Shop { get; set; }

    public virtual DbSet<User> User { get; set; }

    public async Task InitializeCards()
    {
        //this.Database.Migrate();

        // Look for any cards
        if (this.Card.Any())
        {
            return;   // DB has been seeded
        }

        var suits = new string[] { "C", "D", "H", "S" };

        for (int i = 0; i < suits.Length; i++) 
        { 
            for (uint value = 1; value <= 13; value++)
            {
                var card = new Card();
                card.FaceValue = value;
                card.Suit = suits[i];
                this.Card.Add(card);
            }
        }
      
        await this.SaveChangesAsync();
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseMySql(_config["FGN:FGNConnectionString"],
                Microsoft.EntityFrameworkCore.ServerVersion.Parse("10.11.2-mariadb"));
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_general_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Card>(entity =>
        {
            entity.HasKey(e => e.CardId).HasName("PRIMARY");

            entity.HasIndex(e => new { e.FaceValue, e.Suit }, "FaceValue").IsUnique();

            entity.Property(e => e.CardId)
                .ValueGeneratedOnAdd()
                .HasColumnType("int(10) unsigned")
                .HasColumnName("CardID");
            entity.Property(e => e.FaceValue).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Suit)
                .HasMaxLength(1)
                .IsFixedLength();
        });

        modelBuilder.Entity<CardGame>(entity =>
        {
            entity.HasKey(e => e.CardGameId).HasName("PRIMARY");

            entity.Property(e => e.CardGameId)
                .ValueGeneratedNever()
                .HasColumnType("int(10) unsigned")
                .HasColumnName("CardGameID");
            entity.Property(e => e.Name).HasMaxLength(9);
            entity.Property(e => e.NumPlayers).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Picture).HasMaxLength(256);
            entity.Property(e => e.Rules).HasMaxLength(10000);
        });

        modelBuilder.Entity<DiscardPile>(entity =>
        {
            entity.HasKey(e => e.DiscardPileId).HasName("PRIMARY");

            entity.HasIndex(e => e.Card, "Card");

            entity.HasIndex(e => e.Lobby, "Lobby");

            entity.Property(e => e.DiscardPileId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("DiscardPileID");
            entity.Property(e => e.Card).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Lobby).HasColumnType("int(10) unsigned");

            entity.HasOne(d => d.CardNavigation).WithMany(p => p.DiscardPile)
                .HasForeignKey(d => d.Card)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("DiscardPile_ibfk_2");

            entity.HasOne(d => d.LobbyNavigation).WithMany(p => p.DiscardPile)
                .HasForeignKey(d => d.Lobby)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("DiscardPile_ibfk_1");
        });

        modelBuilder.Entity<DrawPile>(entity =>
        {
            entity.HasKey(e => e.DrawPileId).HasName("PRIMARY");

            entity.HasIndex(e => e.Card, "Card");

            entity.HasIndex(e => e.Lobby, "Lobby");

            entity.Property(e => e.DrawPileId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("DrawPileID");
            entity.Property(e => e.Card).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Lobby).HasColumnType("int(10) unsigned");

            entity.HasOne(d => d.CardNavigation).WithMany(p => p.DrawPile)
                .HasForeignKey(d => d.Card)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("DrawPile_ibfk_2");

            entity.HasOne(d => d.LobbyNavigation).WithMany(p => p.DrawPile)
                .HasForeignKey(d => d.Lobby)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("DrawPile_ibfk_1");
        });

        modelBuilder.Entity<GinRummy>(entity =>
        {
            entity.HasKey(e => e.LobbyId).HasName("PRIMARY");

            entity.Property(e => e.LobbyId)
                .ValueGeneratedNever()
                .HasColumnType("int(10) unsigned")
                .HasColumnName("LobbyID");
            entity.Property(e => e.Player1Matches).HasMaxLength(40);
            entity.Property(e => e.Player2Matches).HasMaxLength(40);

            entity.HasOne(d => d.Lobby).WithOne(p => p.GinRummy)
                .HasForeignKey<GinRummy>(d => d.LobbyId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("GinRummy_ibfk_1");
        });

        modelBuilder.Entity<Lobby>(entity =>
        {
            entity.HasKey(e => e.LobbyId).HasName("PRIMARY");

            entity.HasIndex(e => e.CardGame, "CardGame");

            entity.HasIndex(e => e.Host, "Host");

            entity.HasIndex(e => e.PlayerTurn, "PlayerTurn");

            entity.Property(e => e.LobbyId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("LobbyID");
            entity.Property(e => e.CardGame).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Host).HasColumnType("int(10) unsigned");
            entity.Property(e => e.PlayerTurn).HasColumnType("int(10) unsigned");
            entity.Property(e => e.TextChat).HasMaxLength(10000);

            entity.HasOne(d => d.CardGameNavigation).WithMany(p => p.Lobby)
                .HasForeignKey(d => d.CardGame)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Lobby_ibfk_2");

            entity.HasOne(d => d.HostNavigation).WithMany(p => p.LobbyHostNavigation)
                .HasForeignKey(d => d.Host)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Lobby_ibfk_3");

            entity.HasOne(d => d.PlayerTurnNavigation).WithMany(p => p.LobbyPlayerTurnNavigation)
                .HasForeignKey(d => d.PlayerTurn)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Lobby_ibfk_1");
        });

        modelBuilder.Entity<Muted>(entity =>
        {
            entity.HasKey(e => new { e.MutedBy, e.PlayerMuted })
                .HasName("PRIMARY")
                .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

            entity.HasIndex(e => e.PlayerMuted, "PlayerMuted");

            entity.Property(e => e.MutedBy).HasColumnType("int(10) unsigned");
            entity.Property(e => e.PlayerMuted).HasColumnType("int(10) unsigned");

            entity.HasOne(d => d.MutedByNavigation).WithMany(p => p.MutedMutedByNavigation)
                .HasForeignKey(d => d.MutedBy)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Muted_ibfk_1");

            entity.HasOne(d => d.PlayerMutedNavigation).WithMany(p => p.MutedPlayerMutedNavigation)
                .HasForeignKey(d => d.PlayerMuted)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Muted_ibfk_2");
        });

        modelBuilder.Entity<PlayerHand>(entity =>
        {
            entity.HasKey(e => e.PlayerHandId).HasName("PRIMARY");

            entity.HasIndex(e => e.Card, "Card");

            entity.HasIndex(e => e.User, "User");

            entity.Property(e => e.PlayerHandId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("PlayerHandID");
            entity.Property(e => e.Card).HasColumnType("int(10) unsigned");
            entity.Property(e => e.User).HasColumnType("int(10) unsigned");

            entity.Property(e => e.MatchGroup).HasColumnType("tinyint(3) unsigned");

            entity.HasOne(d => d.CardNavigation).WithMany(p => p.PlayerHand)
                .HasForeignKey(d => d.Card)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PlayerHand_ibfk_2");

            entity.HasOne(d => d.UserNavigation).WithMany(p => p.PlayerHand)
                .HasForeignKey(d => d.User)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PlayerHand_ibfk_1");
        });

        modelBuilder.Entity<Players>(entity =>
        {
            entity.HasKey(e => e.PlayerId).HasName("PRIMARY");

            entity.HasIndex(e => e.Lobby, "Lobby");

            entity.HasIndex(e => e.UserId, "UserID");

            entity.HasIndex(e => new { e.UserId, e.Lobby }, "UserID_Lobby").IsUnique();

            entity.Property(e => e.UserId).HasColumnType("int(10) unsigned").HasColumnName("UserID");
            entity.Property(e => e.Lobby).HasColumnType("int(10) unsigned");
            entity.Property(e => e.PositionPlaced).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Score).HasColumnType("int(10) unsigned");
            entity.Property(e => e.TablePosition).HasColumnType("int(10) unsigned");

            entity.HasOne(d => d.LobbyNavigation).WithMany(p => p.Players)
                .HasForeignKey(d => d.Lobby)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Players_ibfk_2");

            entity.HasOne(d => d.User).WithMany(p => p.Players)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Players_ibfk_1");
        });

        modelBuilder.Entity<Settings>(entity =>
        {
            entity.HasKey(e => e.SettingsId).HasName("PRIMARY");

            entity.Property(e => e.SettingsId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("SettingsID");
            entity.Property(e => e.GameVolume).HasColumnType("int(10) unsigned");
            entity.Property(e => e.VoiceChatVolume).HasColumnType("int(10) unsigned");
        });

        modelBuilder.Entity<Shop>(entity =>
        {
            entity.HasKey(e => e.ItemId).HasName("PRIMARY");

            entity.Property(e => e.ItemId)
                .ValueGeneratedNever()
                .HasColumnType("int(10) unsigned")
                .HasColumnName("ItemID");
            entity.Property(e => e.Coins).HasColumnType("int(10) unsigned");
            entity.Property(e => e.Image).HasMaxLength(256);
            entity.Property(e => e.Name).HasMaxLength(25);
            entity.Property(e => e.Type).HasMaxLength(10);
        });


        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PRIMARY");

            entity.HasIndex(e => e.Settings, "Settings");

            entity.Property(e => e.UserId)
                .HasColumnType("int(10) unsigned")
                .HasColumnName("UserID");
            entity.Property(e => e.CurrentCoins).HasColumnType("int(10) unsigned").HasDefaultValue(0);
            entity.Property(e => e.FirebaseId)
                .HasMaxLength(100)
                .HasColumnName("FirebaseID");
            entity.Property(e => e.Settings).HasColumnType("int(10) unsigned");

            entity.HasOne(d => d.SettingsNavigation).WithMany(p => p.User)
                .HasForeignKey(d => d.Settings)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("User_ibfk_2");

            entity.HasMany(d => d.Friend1).WithMany(p => p.Friend2)
                .UsingEntity<Dictionary<string, object>>(
                    "Friends",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("Friend1")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Friends_ibfk_1"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("Friend2")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Friends_ibfk_2"),
                    j =>
                    {
                        j.HasKey("Friend1", "Friend2")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "Friend2" }, "Friend2");
                        j.IndexerProperty<uint>("Friend1").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("Friend2").HasColumnType("int(10) unsigned");
                    });

            entity.HasMany(d => d.Friend2).WithMany(p => p.Friend1)
                .UsingEntity<Dictionary<string, object>>(
                    "Friends",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("Friend2")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Friends_ibfk_2"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("Friend1")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Friends_ibfk_1"),
                    j =>
                    {
                        j.HasKey("Friend1", "Friend2")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "Friend2" }, "Friend2");
                        j.IndexerProperty<uint>("Friend1").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("Friend2").HasColumnType("int(10) unsigned");
                    });

            entity.HasMany(d => d.FromUser).WithMany(p => p.ToUser)
                .UsingEntity<Dictionary<string, object>>(
                    "FriendRequest",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("FromUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FriendRequest_ibfk_1"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("ToUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FriendRequest_ibfk_2"),
                    j =>
                    {
                        j.HasKey("FromUser", "ToUser")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "ToUser" }, "ToUser");
                        j.IndexerProperty<uint>("FromUser").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("ToUser").HasColumnType("int(10) unsigned");
                    });

            entity.HasMany(d => d.FromUserNavigation).WithMany(p => p.ToUserNavigation)
                .UsingEntity<Dictionary<string, object>>(
                    "GameInvite",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("FromUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("GameInvite_ibfk_1"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("ToUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("GameInvite_ibfk_2"),
                    j =>
                    {
                        j.HasKey("FromUser", "ToUser")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "ToUser" }, "ToUser");
                        j.IndexerProperty<uint>("FromUser").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("ToUser").HasColumnType("int(10) unsigned");
                    });

            entity.HasMany(d => d.Item).WithMany(p => p.User)
                .UsingEntity<Dictionary<string, object>>(
                    "Purchased",
                    r => r.HasOne<Shop>().WithMany()
                        .HasForeignKey("ItemId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Purchased_ibfk_2"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("Purchased_ibfk_1"),
                    j =>
                    {
                        j.HasKey("UserId", "ItemId")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "ItemId" }, "ItemID");
                        j.IndexerProperty<uint>("UserId")
                            .HasColumnType("int(10) unsigned")
                            .HasColumnName("UserID");
                        j.IndexerProperty<uint>("ItemId")
                            .HasColumnType("int(10) unsigned")
                            .HasColumnName("ItemID");
                    });

            entity.HasMany(d => d.ToUser).WithMany(p => p.FromUser)
                .UsingEntity<Dictionary<string, object>>(
                    "FriendRequest",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("ToUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FriendRequest_ibfk_2"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("FromUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FriendRequest_ibfk_1"),
                    j =>
                    {
                        j.HasKey("FromUser", "ToUser")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "ToUser" }, "ToUser");
                        j.IndexerProperty<uint>("FromUser").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("ToUser").HasColumnType("int(10) unsigned");
                    });

            entity.HasMany(d => d.ToUserNavigation).WithMany(p => p.FromUserNavigation)
                .UsingEntity<Dictionary<string, object>>(
                    "GameInvite",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("ToUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("GameInvite_ibfk_2"),
                    l => l.HasOne<User>().WithMany()
                        .HasForeignKey("FromUser")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("GameInvite_ibfk_1"),
                    j =>
                    {
                        j.HasKey("FromUser", "ToUser")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.HasIndex(new[] { "ToUser" }, "ToUser");
                        j.IndexerProperty<uint>("FromUser").HasColumnType("int(10) unsigned");
                        j.IndexerProperty<uint>("ToUser").HasColumnType("int(10) unsigned");
                    });
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}