using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class MatchGroupToPlayerHand : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte>(
                name: "MatchGroup",
                table: "PlayerHand",
                type: "tinyint(3) unsigned",
                nullable: false,
                defaultValue: (byte)0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MatchGroup",
                table: "PlayerHand");
        }
    }
}
