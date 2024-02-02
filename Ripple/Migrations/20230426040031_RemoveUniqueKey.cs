using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class RemoveUniqueKey : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Players_UserID",
                table: "Players");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Players_UserID",
                table: "Players",
                column: "UserID",
                unique: true);
        }
    }
}
