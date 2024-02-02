using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Card",
                columns: table => new
                {
                    CardID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    FaceValue = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Suit = table.Column<string>(type: "char(1)", fixedLength: true, maxLength: 1, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.CardID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "CardGame",
                columns: table => new
                {
                    CardGameID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Name = table.Column<string>(type: "varchar(9)", maxLength: 9, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Picture = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    NumPlayers = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Rules = table.Column<string>(type: "varchar(10000)", maxLength: 10000, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.CardGameID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Settings",
                columns: table => new
                {
                    SettingsID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Notifications = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    VoiceChat = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    VoiceChatVolume = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    GameVolume = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.SettingsID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Shop",
                columns: table => new
                {
                    ItemID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Name = table.Column<string>(type: "varchar(25)", maxLength: 25, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Type = table.Column<string>(type: "varchar(10)", maxLength: 10, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Image = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Coins = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.ItemID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Statistics",
                columns: table => new
                {
                    StatisticsID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    HoursPlayed = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    GamesPlayed = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    CoinsEarned = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.StatisticsID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    UserID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    FirebaseID = table.Column<string>(type: "varchar(28)", maxLength: 28, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    CurrentCoins = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Avatar = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Statistics = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Settings = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.UserID);
                    table.ForeignKey(
                        name: "User_ibfk_1",
                        column: x => x.Statistics,
                        principalTable: "Statistics",
                        principalColumn: "StatisticsID");
                    table.ForeignKey(
                        name: "User_ibfk_2",
                        column: x => x.Settings,
                        principalTable: "Settings",
                        principalColumn: "SettingsID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "FriendRequest",
                columns: table => new
                {
                    FromUser = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    ToUser = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => new { x.FromUser, x.ToUser })
                        .Annotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                    table.ForeignKey(
                        name: "FriendRequest_ibfk_1",
                        column: x => x.FromUser,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "FriendRequest_ibfk_2",
                        column: x => x.ToUser,
                        principalTable: "User",
                        principalColumn: "UserID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Friends",
                columns: table => new
                {
                    Friend1 = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Friend2 = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => new { x.Friend1, x.Friend2 })
                        .Annotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                    table.ForeignKey(
                        name: "Friends_ibfk_1",
                        column: x => x.Friend1,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "Friends_ibfk_2",
                        column: x => x.Friend2,
                        principalTable: "User",
                        principalColumn: "UserID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "GameInvite",
                columns: table => new
                {
                    FromUser = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    ToUser = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => new { x.FromUser, x.ToUser })
                        .Annotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                    table.ForeignKey(
                        name: "GameInvite_ibfk_1",
                        column: x => x.FromUser,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "GameInvite_ibfk_2",
                        column: x => x.ToUser,
                        principalTable: "User",
                        principalColumn: "UserID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Lobby",
                columns: table => new
                {
                    LobbyID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    PlayerTurn = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    GameOver = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    TextChat = table.Column<string>(type: "varchar(10000)", maxLength: 10000, nullable: false, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    CardGame = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Host = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.LobbyID);
                    table.ForeignKey(
                        name: "Lobby_ibfk_1",
                        column: x => x.PlayerTurn,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "Lobby_ibfk_2",
                        column: x => x.CardGame,
                        principalTable: "CardGame",
                        principalColumn: "CardGameID");
                    table.ForeignKey(
                        name: "Lobby_ibfk_3",
                        column: x => x.Host,
                        principalTable: "User",
                        principalColumn: "UserID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Muted",
                columns: table => new
                {
                    MutedBy = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    PlayerMuted = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    MutedToEveryone = table.Column<bool>(type: "tinyint(1)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => new { x.MutedBy, x.PlayerMuted })
                        .Annotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                    table.ForeignKey(
                        name: "Muted_ibfk_1",
                        column: x => x.MutedBy,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "Muted_ibfk_2",
                        column: x => x.PlayerMuted,
                        principalTable: "User",
                        principalColumn: "UserID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "PlayerHand",
                columns: table => new
                {
                    PlayerHandID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    User = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Card = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.PlayerHandID);
                    table.ForeignKey(
                        name: "PlayerHand_ibfk_1",
                        column: x => x.User,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "PlayerHand_ibfk_2",
                        column: x => x.Card,
                        principalTable: "Card",
                        principalColumn: "CardID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Purchased",
                columns: table => new
                {
                    UserID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    ItemID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => new { x.UserID, x.ItemID })
                        .Annotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                    table.ForeignKey(
                        name: "Purchased_ibfk_1",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "Purchased_ibfk_2",
                        column: x => x.ItemID,
                        principalTable: "Shop",
                        principalColumn: "ItemID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "DiscardPile",
                columns: table => new
                {
                    DiscardPileID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Lobby = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Card = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.DiscardPileID);
                    table.ForeignKey(
                        name: "DiscardPile_ibfk_1",
                        column: x => x.Lobby,
                        principalTable: "Lobby",
                        principalColumn: "LobbyID");
                    table.ForeignKey(
                        name: "DiscardPile_ibfk_2",
                        column: x => x.Card,
                        principalTable: "Card",
                        principalColumn: "CardID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "DrawPile",
                columns: table => new
                {
                    DrawPileID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Lobby = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Card = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.DrawPileID);
                    table.ForeignKey(
                        name: "DrawPile_ibfk_1",
                        column: x => x.Lobby,
                        principalTable: "Lobby",
                        principalColumn: "LobbyID");
                    table.ForeignKey(
                        name: "DrawPile_ibfk_2",
                        column: x => x.Card,
                        principalTable: "Card",
                        principalColumn: "CardID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "GinRummy",
                columns: table => new
                {
                    LobbyID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    FirstTurn = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    Player1Matches = table.Column<string>(type: "varchar(40)", maxLength: 40, nullable: true, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Player2Matches = table.Column<string>(type: "varchar(40)", maxLength: 40, nullable: true, collation: "utf8mb4_general_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.LobbyID);
                    table.ForeignKey(
                        name: "GinRummy_ibfk_1",
                        column: x => x.LobbyID,
                        principalTable: "Lobby",
                        principalColumn: "LobbyID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateTable(
                name: "Players",
                columns: table => new
                {
                    UserID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Lobby = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Score = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    TablePosition = table.Column<uint>(type: "int(10) unsigned", nullable: true),
                    PositionPlaced = table.Column<uint>(type: "int(10) unsigned", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.UserID);
                    table.ForeignKey(
                        name: "Players_ibfk_1",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "Players_ibfk_2",
                        column: x => x.Lobby,
                        principalTable: "Lobby",
                        principalColumn: "LobbyID");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateIndex(
                name: "FaceValue",
                table: "Card",
                columns: new[] { "FaceValue", "Suit" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "Card",
                table: "DiscardPile",
                column: "Card");

            migrationBuilder.CreateIndex(
                name: "Lobby",
                table: "DiscardPile",
                column: "Lobby");

            migrationBuilder.CreateIndex(
                name: "Card1",
                table: "DrawPile",
                column: "Card");

            migrationBuilder.CreateIndex(
                name: "Lobby1",
                table: "DrawPile",
                column: "Lobby");

            migrationBuilder.CreateIndex(
                name: "ToUser",
                table: "FriendRequest",
                column: "ToUser");

            migrationBuilder.CreateIndex(
                name: "Friend2",
                table: "Friends",
                column: "Friend2");

            migrationBuilder.CreateIndex(
                name: "ToUser1",
                table: "GameInvite",
                column: "ToUser");

            migrationBuilder.CreateIndex(
                name: "CardGame",
                table: "Lobby",
                column: "CardGame");

            migrationBuilder.CreateIndex(
                name: "Host",
                table: "Lobby",
                column: "Host");

            migrationBuilder.CreateIndex(
                name: "PlayerTurn",
                table: "Lobby",
                column: "PlayerTurn");

            migrationBuilder.CreateIndex(
                name: "PlayerMuted",
                table: "Muted",
                column: "PlayerMuted");

            migrationBuilder.CreateIndex(
                name: "Card2",
                table: "PlayerHand",
                column: "Card");

            migrationBuilder.CreateIndex(
                name: "User",
                table: "PlayerHand",
                column: "User");

            migrationBuilder.CreateIndex(
                name: "Lobby2",
                table: "Players",
                column: "Lobby");

            migrationBuilder.CreateIndex(
                name: "ItemID",
                table: "Purchased",
                column: "ItemID");

            migrationBuilder.CreateIndex(
                name: "Settings",
                table: "User",
                column: "Settings");

            migrationBuilder.CreateIndex(
                name: "Statistics",
                table: "User",
                column: "Statistics");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DiscardPile");

            migrationBuilder.DropTable(
                name: "DrawPile");

            migrationBuilder.DropTable(
                name: "FriendRequest");

            migrationBuilder.DropTable(
                name: "Friends");

            migrationBuilder.DropTable(
                name: "GameInvite");

            migrationBuilder.DropTable(
                name: "GinRummy");

            migrationBuilder.DropTable(
                name: "Muted");

            migrationBuilder.DropTable(
                name: "PlayerHand");

            migrationBuilder.DropTable(
                name: "Players");

            migrationBuilder.DropTable(
                name: "Purchased");

            migrationBuilder.DropTable(
                name: "Card");

            migrationBuilder.DropTable(
                name: "Lobby");

            migrationBuilder.DropTable(
                name: "Shop");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "CardGame");

            migrationBuilder.DropTable(
                name: "Statistics");

            migrationBuilder.DropTable(
                name: "Settings");
        }
    }
}
