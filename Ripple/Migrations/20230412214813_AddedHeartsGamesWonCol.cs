using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class AddedHeartsGamesWonCol : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<uint>(
                name: "HeartsGamesWon",
                table: "Statistics",
                type: "int unsigned",
                nullable: false,
                defaultValue: 0u);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "HeartsGamesWon",
                table: "Statistics");
        }
    }
}
