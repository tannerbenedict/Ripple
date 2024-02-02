using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class PlayerTableRestructure : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Players",
                columns: table => new
                {
                    PlayerId = table.Column<uint>(type: "int unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    UserID = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Lobby = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    Score = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    TablePosition = table.Column<uint>(type: "int(10) unsigned", nullable: true),
                    PositionPlaced = table.Column<uint>(type: "int(10) unsigned", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.PlayerId);
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
                name: "IX_Players_UserID",
                table: "Players",
                column: "UserID",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "Lobby2",
                table: "Players",
                column: "Lobby");

            migrationBuilder.CreateIndex(
                name: "UserID",
                table: "Players",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "UserID_Lobby",
                table: "Players",
                columns: new[] { "UserID", "Lobby" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Players");
        }
    }
}
