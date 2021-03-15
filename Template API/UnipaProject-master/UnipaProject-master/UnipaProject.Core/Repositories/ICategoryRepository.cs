using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Models;

namespace UnipaProject.Core.Repositories
{
     public interface ICategoryRepository : IRepository<Category>
    {
        Task<Category> GetWithProductsByIdAsync(int CategoryId);
    }
}
