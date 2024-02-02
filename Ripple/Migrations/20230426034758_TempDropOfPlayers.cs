using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class TempDropOfPlayers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Players");

            migrationBuilder.AlterColumn<uint>(
                name: "CardID",
                table: "Card",
                type: "int(10) unsigned",
                nullable: false,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<uint>(
                name: "CardID",
                table: "Card",
                type: "int(10) unsigned",
                nullable: false,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned")
                .OldAnnotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.CreateTable(
                name: "Players",
                columns: table => new
                {
                    UserID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Lobby = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    PositionPlaced = table.Column<uint>(type: "int(10) unsigned", nullable: true),
                    Score = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    TablePosition = table.Column<uint>(type: "int(10) unsigned", nullable: true)
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
                name: "Lobby2",
                table: "Players",
                column: "Lobby");
        }
    }
}
