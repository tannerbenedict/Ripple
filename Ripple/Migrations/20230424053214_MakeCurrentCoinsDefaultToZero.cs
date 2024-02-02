using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class MakeCurrentCoinsDefaultToZero : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<uint>(
                name: "CurrentCoins",
                table: "User",
                type: "int(10) unsigned",
                nullable: false,
                defaultValue: 0u,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<uint>(
                name: "CurrentCoins",
                table: "User",
                type: "int(10) unsigned",
                nullable: false,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned",
                oldDefaultValue: 0u);
        }
    }
}
