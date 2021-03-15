using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;
using UnipaProject.Core.Models;

namespace UnipaProject.Data.Seeds
{
    public class CategorySeed : IEntityTypeConfiguration<CategorySeed>
    {
        private int _id;

        public CategorySeed(int id)
        {
            _id = id;
        }
        public void Configure(EntityTypeBuilder<CategorySeed> builder)
        {
            builder.HasData(
                new Category { Id = _id, Name = "Kalemler" }
                //new Category { Id = _ids[1], Name = "Defterler" }
                );
        }
    }
}
