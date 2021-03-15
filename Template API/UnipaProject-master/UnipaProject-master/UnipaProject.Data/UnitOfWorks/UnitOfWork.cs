using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Repositories;
using UnipaProject.Core.UnitOfWorks;
using UnipaProject.Data.Repositories;

namespace UnipaProject.Data.UnitOfWorks
{
    public class UnitOfWork : IUnitOfWork 
    {
        private readonly AppDbContext _context;
        private ProductRepository productRepository;
        private CategoryRepository categoryRepository;
        public IProductRepository Products => productRepository= productRepository ?? new ProductRepository(_context);

        public ICategoryRepository Categories => categoryRepository= categoryRepository?? new CategoryRepository(_context);


        public UnitOfWork(AppDbContext appDbContext)
        {
            _context = appDbContext;
        }
        public void Commit()
        {

            _context.SaveChanges();
        }

        public async Task CommitAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
