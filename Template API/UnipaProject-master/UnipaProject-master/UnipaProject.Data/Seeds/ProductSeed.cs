using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;
using UnipaProject.Core.Models;

namespace UnipaProject.Data.Seeds
{
    public class ProductSeed : IEntityTypeConfiguration<Product>
    {
        private readonly int[] _ids;
        public ProductSeed(int[] ids)
        {
            _ids = ids;
        }

        public void Configure(EntityTypeBuilder<Product> builder)
        {
            builder.HasData(
                new Product { Id = 1, Name = "Kursun kalem", Price = 12.10m, Stock = 100, CategoryId = _ids[0] },
                new Product { Id = 2, Name = "Dolma kalem", Price = 42.10m, Stock = 200, CategoryId = _ids[0] },
                new Product { Id = 3, Name = " Defter", Price = 52.10m, Stock = 300, CategoryId = _ids[1] }

                );
        }
    }
}
