namespace RandomWikiNS.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class safetyFirst : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.WikiPages", "url", c => c.String());
            AddColumn("dbo.WikiPages", "title", c => c.String());
            AddColumn("dbo.WikiPages", "Discriminator", c => c.String(nullable: false, maxLength: 128));
        }
        
        public override void Down()
        {
            DropColumn("dbo.WikiPages", "Discriminator");
            DropColumn("dbo.WikiPages", "title");
            DropColumn("dbo.WikiPages", "url");
        }
    }
}
