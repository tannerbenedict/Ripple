using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FamilyGameNight.Migrations
{
    /// <inheritdoc />
    public partial class CardIDAutoIncrement : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("SET FOREIGN_KEY_CHECKS = 0;");
            migrationBuilder.AlterColumn<uint>(
                name: "CardID",
                table: "Card",
                type: "int(10) unsigned",
                nullable: false,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);
            migrationBuilder.Sql("SET FOREIGN_KEY_CHECKS = 1;");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("SET FOREIGN_KEY_CHECKS = 0;");

            migrationBuilder.AlterColumn<uint>(
                name: "CardID",
                table: "Card",
                type: "int(10) unsigned",
                nullable: false,
                oldClrType: typeof(uint),
                oldType: "int(10) unsigned")
                .OldAnnotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);
            migrationBuilder.Sql("SET FOREIGN_KEY_CHECKS = 1;");

        }
    }
}
