using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class AddFirebaseIdIndex : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "UserFirebaseIdUniqueConstraint",
                table: "User",
                column: "FirebaseID",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "UserFirebaseIdUniqueConstraint",
                table: "User");
        }
    }
}
