using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Models;
using UnipaProject.Core.Repositories;

namespace UnipaProject.Data.Repositories
{
   public class ProductRepository : Repository<Product>, IProductRepository
    {
      private AppDbContext _appDbContext { get => _context as AppDbContext; }
        public ProductRepository(AppDbContext context) : base(context)
        {
        }

        public async Task<Product> GetWithCategoryByIdAsync(int productid)
        {
            return await _appDbContext.Products.Include(x => x.Category).SingleOrDefaultAsync(x => x.Id == productid);
        }
    }
}
