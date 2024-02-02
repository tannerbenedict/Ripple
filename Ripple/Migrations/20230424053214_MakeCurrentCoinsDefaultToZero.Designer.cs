﻿// <auto-generated />
using System;
using FamilyGameNight.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace FamilyGameNight.Migrations
{
    [DbContext(typeof(FamilyGameNightContext))]
    [Migration("20230424053214_MakeCurrentCoinsDefaultToZero")]
    partial class MakeCurrentCoinsDefaultToZero
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .UseCollation("utf8mb4_general_ci")
                .HasAnnotation("ProductVersion", "7.0.4")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            MySqlModelBuilderExtensions.HasCharSet(modelBuilder, "utf8mb4");

            modelBuilder.Entity("FamilyGameNight.Models.Card", b =>
                {
                    b.Property<uint>("CardId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("CardID");

                    b.Property<uint>("FaceValue")
                        .HasColumnType("int(10) unsigned");

                    b.Property<string>("Suit")
                        .IsRequired()
                        .HasMaxLength(1)
                        .HasColumnType("char(1)")
                        .IsFixedLength();

                    b.HasKey("CardId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "FaceValue", "Suit" }, "FaceValue")
                        .IsUnique();

                    b.ToTable("Card");
                });

            modelBuilder.Entity("FamilyGameNight.Models.CardGame", b =>
                {
                    b.Property<uint>("CardGameId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("CardGameID");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(9)
                        .HasColumnType("varchar(9)");

                    b.Property<uint>("NumPlayers")
                        .HasColumnType("int(10) unsigned");

                    b.Property<string>("Picture")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("Rules")
                        .IsRequired()
                        .HasMaxLength(10000)
                        .HasColumnType("varchar(10000)");

                    b.HasKey("CardGameId")
                        .HasName("PRIMARY");

                    b.ToTable("CardGame");
                });

            modelBuilder.Entity("FamilyGameNight.Models.DiscardPile", b =>
                {
                    b.Property<uint>("DiscardPileId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("DiscardPileID");

                    b.Property<uint>("Card")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("Lobby")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("DiscardPileId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "Card" }, "Card");

                    b.HasIndex(new[] { "Lobby" }, "Lobby");

                    b.ToTable("DiscardPile");
                });

            modelBuilder.Entity("FamilyGameNight.Models.DrawPile", b =>
                {
                    b.Property<uint>("DrawPileId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("DrawPileID");

                    b.Property<uint>("Card")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("Lobby")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("DrawPileId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "Card" }, "Card")
                        .HasDatabaseName("Card1");

                    b.HasIndex(new[] { "Lobby" }, "Lobby")
                        .HasDatabaseName("Lobby1");

                    b.ToTable("DrawPile");
                });

            modelBuilder.Entity("FamilyGameNight.Models.GinRummy", b =>
                {
                    b.Property<uint>("LobbyId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("LobbyID");

                    b.Property<bool>("FirstTurn")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("Player1Matches")
                        .HasMaxLength(40)
                        .HasColumnType("varchar(40)");

                    b.Property<string>("Player2Matches")
                        .HasMaxLength(40)
                        .HasColumnType("varchar(40)");

                    b.HasKey("LobbyId")
                        .HasName("PRIMARY");

                    b.ToTable("GinRummy");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Lobby", b =>
                {
                    b.Property<uint>("LobbyId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("LobbyID");

                    b.Property<uint>("CardGame")
                        .HasColumnType("int(10) unsigned");

                    b.Property<bool>("GameOver")
                        .HasColumnType("tinyint(1)");

                    b.Property<uint>("Host")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("PlayerTurn")
                        .HasColumnType("int(10) unsigned");

                    b.Property<string>("TextChat")
                        .IsRequired()
                        .HasMaxLength(10000)
                        .HasColumnType("varchar(10000)");

                    b.HasKey("LobbyId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "CardGame" }, "CardGame");

                    b.HasIndex(new[] { "Host" }, "Host");

                    b.HasIndex(new[] { "PlayerTurn" }, "PlayerTurn");

                    b.ToTable("Lobby");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Muted", b =>
                {
                    b.Property<uint>("MutedBy")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("PlayerMuted")
                        .HasColumnType("int(10) unsigned");

                    b.Property<bool>("MutedToEveryone")
                        .HasColumnType("tinyint(1)");

                    b.HasKey("MutedBy", "PlayerMuted")
                        .HasName("PRIMARY")
                        .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                    b.HasIndex(new[] { "PlayerMuted" }, "PlayerMuted");

                    b.ToTable("Muted");
                });

            modelBuilder.Entity("FamilyGameNight.Models.PlayerHand", b =>
                {
                    b.Property<uint>("PlayerHandId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("PlayerHandID");

                    b.Property<uint>("Card")
                        .HasColumnType("int(10) unsigned");

                    b.Property<byte>("MatchGroup")
                        .HasColumnType("tinyint(3) unsigned");

                    b.Property<uint>("User")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("PlayerHandId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "Card" }, "Card")
                        .HasDatabaseName("Card2");

                    b.HasIndex(new[] { "User" }, "User");

                    b.ToTable("PlayerHand");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Players", b =>
                {
                    b.Property<uint>("UserId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("UserID");

                    b.Property<uint>("Lobby")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint?>("PositionPlaced")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("Score")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint?>("TablePosition")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("UserId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "Lobby" }, "Lobby")
                        .HasDatabaseName("Lobby2");

                    b.ToTable("Players");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Settings", b =>
                {
                    b.Property<uint>("SettingsId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("SettingsID");

                    b.Property<uint>("GameVolume")
                        .HasColumnType("int(10) unsigned");

                    b.Property<bool>("Notifications")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("VoiceChat")
                        .HasColumnType("tinyint(1)");

                    b.Property<uint>("VoiceChatVolume")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("SettingsId")
                        .HasName("PRIMARY");

                    b.ToTable("Settings");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Shop", b =>
                {
                    b.Property<uint>("ItemId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("ItemID");

                    b.Property<uint>("Coins")
                        .HasColumnType("int(10) unsigned");

                    b.Property<string>("Image")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(25)
                        .HasColumnType("varchar(25)");

                    b.Property<string>("Type")
                        .IsRequired()
                        .HasMaxLength(10)
                        .HasColumnType("varchar(10)");

                    b.HasKey("ItemId")
                        .HasName("PRIMARY");

                    b.ToTable("Shop");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Statistics", b =>
                {
                    b.Property<uint>("StatisticsId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("StatisticsID");

                    b.Property<uint>("CoinsEarned")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("GamesPlayed")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("GamesWon")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("HeartsGamesWon")
                        .HasColumnType("int unsigned");

                    b.Property<uint>("HoursPlayed")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("StatisticsId")
                        .HasName("PRIMARY");

                    b.ToTable("Statistics");
                });

            modelBuilder.Entity("FamilyGameNight.Models.User", b =>
                {
                    b.Property<uint>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("UserID");

                    b.Property<uint>("CurrentCoins")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int(10) unsigned")
                        .HasDefaultValue(0u);

                    b.Property<string>("FirebaseId")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("varchar(100)")
                        .HasColumnName("FirebaseID");

                    b.Property<uint>("Settings")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("Statistics")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("UserId")
                        .HasName("PRIMARY");

                    b.HasIndex(new[] { "Settings" }, "Settings");

                    b.HasIndex(new[] { "Statistics" }, "Statistics");

                    b.ToTable("User");
                });

            modelBuilder.Entity("FriendRequest", b =>
                {
                    b.Property<uint>("FromUser")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("ToUser")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("FromUser", "ToUser")
                        .HasName("PRIMARY")
                        .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                    b.HasIndex(new[] { "ToUser" }, "ToUser");

                    b.ToTable("FriendRequest");
                });

            modelBuilder.Entity("Friends", b =>
                {
                    b.Property<uint>("Friend1")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("Friend2")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("Friend1", "Friend2")
                        .HasName("PRIMARY")
                        .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                    b.HasIndex(new[] { "Friend2" }, "Friend2");

                    b.ToTable("Friends");
                });

            modelBuilder.Entity("GameInvite", b =>
                {
                    b.Property<uint>("FromUser")
                        .HasColumnType("int(10) unsigned");

                    b.Property<uint>("ToUser")
                        .HasColumnType("int(10) unsigned");

                    b.HasKey("FromUser", "ToUser")
                        .HasName("PRIMARY")
                        .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                    b.HasIndex(new[] { "ToUser" }, "ToUser")
                        .HasDatabaseName("ToUser1");

                    b.ToTable("GameInvite");
                });

            modelBuilder.Entity("Purchased", b =>
                {
                    b.Property<uint>("UserId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("UserID");

                    b.Property<uint>("ItemId")
                        .HasColumnType("int(10) unsigned")
                        .HasColumnName("ItemID");

                    b.HasKey("UserId", "ItemId")
                        .HasName("PRIMARY")
                        .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                    b.HasIndex(new[] { "ItemId" }, "ItemID");

                    b.ToTable("Purchased");
                });

            modelBuilder.Entity("FamilyGameNight.Models.DiscardPile", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Card", "CardNavigation")
                        .WithMany("DiscardPile")
                        .HasForeignKey("Card")
                        .IsRequired()
                        .HasConstraintName("DiscardPile_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.Lobby", "LobbyNavigation")
                        .WithMany("DiscardPile")
                        .HasForeignKey("Lobby")
                        .IsRequired()
                        .HasConstraintName("DiscardPile_ibfk_1");

                    b.Navigation("CardNavigation");

                    b.Navigation("LobbyNavigation");
                });

            modelBuilder.Entity("FamilyGameNight.Models.DrawPile", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Card", "CardNavigation")
                        .WithMany("DrawPile")
                        .HasForeignKey("Card")
                        .IsRequired()
                        .HasConstraintName("DrawPile_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.Lobby", "LobbyNavigation")
                        .WithMany("DrawPile")
                        .HasForeignKey("Lobby")
                        .IsRequired()
                        .HasConstraintName("DrawPile_ibfk_1");

                    b.Navigation("CardNavigation");

                    b.Navigation("LobbyNavigation");
                });

            modelBuilder.Entity("FamilyGameNight.Models.GinRummy", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Lobby", "Lobby")
                        .WithOne("GinRummy")
                        .HasForeignKey("FamilyGameNight.Models.GinRummy", "LobbyId")
                        .IsRequired()
                        .HasConstraintName("GinRummy_ibfk_1");

                    b.Navigation("Lobby");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Lobby", b =>
                {
                    b.HasOne("FamilyGameNight.Models.CardGame", "CardGameNavigation")
                        .WithMany("Lobby")
                        .HasForeignKey("CardGame")
                        .IsRequired()
                        .HasConstraintName("Lobby_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.User", "HostNavigation")
                        .WithMany("LobbyHostNavigation")
                        .HasForeignKey("Host")
                        .IsRequired()
                        .HasConstraintName("Lobby_ibfk_3");

                    b.HasOne("FamilyGameNight.Models.User", "PlayerTurnNavigation")
                        .WithMany("LobbyPlayerTurnNavigation")
                        .HasForeignKey("PlayerTurn")
                        .IsRequired()
                        .HasConstraintName("Lobby_ibfk_1");

                    b.Navigation("CardGameNavigation");

                    b.Navigation("HostNavigation");

                    b.Navigation("PlayerTurnNavigation");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Muted", b =>
                {
                    b.HasOne("FamilyGameNight.Models.User", "MutedByNavigation")
                        .WithMany("MutedMutedByNavigation")
                        .HasForeignKey("MutedBy")
                        .IsRequired()
                        .HasConstraintName("Muted_ibfk_1");

                    b.HasOne("FamilyGameNight.Models.User", "PlayerMutedNavigation")
                        .WithMany("MutedPlayerMutedNavigation")
                        .HasForeignKey("PlayerMuted")
                        .IsRequired()
                        .HasConstraintName("Muted_ibfk_2");

                    b.Navigation("MutedByNavigation");

                    b.Navigation("PlayerMutedNavigation");
                });

            modelBuilder.Entity("FamilyGameNight.Models.PlayerHand", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Card", "CardNavigation")
                        .WithMany("PlayerHand")
                        .HasForeignKey("Card")
                        .IsRequired()
                        .HasConstraintName("PlayerHand_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.User", "UserNavigation")
                        .WithMany("PlayerHand")
                        .HasForeignKey("User")
                        .IsRequired()
                        .HasConstraintName("PlayerHand_ibfk_1");

                    b.Navigation("CardNavigation");

                    b.Navigation("UserNavigation");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Players", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Lobby", "LobbyNavigation")
                        .WithMany("Players")
                        .HasForeignKey("Lobby")
                        .IsRequired()
                        .HasConstraintName("Players_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.User", "User")
                        .WithOne("Players")
                        .HasForeignKey("FamilyGameNight.Models.Players", "UserId")
                        .IsRequired()
                        .HasConstraintName("Players_ibfk_1");

                    b.Navigation("LobbyNavigation");

                    b.Navigation("User");
                });

            modelBuilder.Entity("FamilyGameNight.Models.User", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Settings", "SettingsNavigation")
                        .WithMany("User")
                        .HasForeignKey("Settings")
                        .IsRequired()
                        .HasConstraintName("User_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.Statistics", "StatisticsNavigation")
                        .WithMany("User")
                        .HasForeignKey("Statistics")
                        .IsRequired()
                        .HasConstraintName("User_ibfk_1");

                    b.Navigation("SettingsNavigation");

                    b.Navigation("StatisticsNavigation");
                });

            modelBuilder.Entity("FriendRequest", b =>
                {
                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("FromUser")
                        .IsRequired()
                        .HasConstraintName("FriendRequest_ibfk_1");

                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("ToUser")
                        .IsRequired()
                        .HasConstraintName("FriendRequest_ibfk_2");
                });

            modelBuilder.Entity("Friends", b =>
                {
                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("Friend1")
                        .IsRequired()
                        .HasConstraintName("Friends_ibfk_1");

                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("Friend2")
                        .IsRequired()
                        .HasConstraintName("Friends_ibfk_2");
                });

            modelBuilder.Entity("GameInvite", b =>
                {
                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("FromUser")
                        .IsRequired()
                        .HasConstraintName("GameInvite_ibfk_1");

                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("ToUser")
                        .IsRequired()
                        .HasConstraintName("GameInvite_ibfk_2");
                });

            modelBuilder.Entity("Purchased", b =>
                {
                    b.HasOne("FamilyGameNight.Models.Shop", null)
                        .WithMany()
                        .HasForeignKey("ItemId")
                        .IsRequired()
                        .HasConstraintName("Purchased_ibfk_2");

                    b.HasOne("FamilyGameNight.Models.User", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .IsRequired()
                        .HasConstraintName("Purchased_ibfk_1");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Card", b =>
                {
                    b.Navigation("DiscardPile");

                    b.Navigation("DrawPile");

                    b.Navigation("PlayerHand");
                });

            modelBuilder.Entity("FamilyGameNight.Models.CardGame", b =>
                {
                    b.Navigation("Lobby");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Lobby", b =>
                {
                    b.Navigation("DiscardPile");

                    b.Navigation("DrawPile");

                    b.Navigation("GinRummy");

                    b.Navigation("Players");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Settings", b =>
                {
                    b.Navigation("User");
                });

            modelBuilder.Entity("FamilyGameNight.Models.Statistics", b =>
                {
                    b.Navigation("User");
                });

            modelBuilder.Entity("FamilyGameNight.Models.User", b =>
                {
                    b.Navigation("LobbyHostNavigation");

                    b.Navigation("LobbyPlayerTurnNavigation");

                    b.Navigation("MutedMutedByNavigation");

                    b.Navigation("MutedPlayerMutedNavigation");

                    b.Navigation("PlayerHand");

                    b.Navigation("Players");
                });
#pragma warning restore 612, 618
        }
    }
}
