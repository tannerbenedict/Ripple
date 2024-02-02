using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class DeleteStatisticsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "User_ibfk_1",
                table: "User");

            migrationBuilder.DropTable(
                name: "Statistics");

            migrationBuilder.DropIndex(
                name: "Statistics",
                table: "User");

            migrationBuilder.DropColumn(
                name: "Statistics",
                table: "User");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<uint>(
                name: "Statistics",
                table: "User",
                type: "int(10) unsigned",
                nullable: false,
                defaultValue: 0u);

            migrationBuilder.CreateTable(
                name: "Statistics",
                columns: table => new
                {
                    StatisticsID = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    CoinsEarned = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    GamesPlayed = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    GamesWon = table.Column<uint>(type: "int(10) unsigned", nullable: false),
                    HeartsGamesWon = table.Column<uint>(type: "int unsigned", nullable: false),
                    HoursPlayed = table.Column<uint>(type: "int(10) unsigned", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.StatisticsID);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_general_ci");

            migrationBuilder.CreateIndex(
                name: "Statistics",
                table: "User",
                column: "Statistics");

            migrationBuilder.AddForeignKey(
                name: "User_ibfk_1",
                table: "User",
                column: "Statistics",
                principalTable: "Statistics",
                principalColumn: "StatisticsID");
        }
    }
}
