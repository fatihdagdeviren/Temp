using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Models;

namespace UnipaProject.Core.Services
{
   public interface ICategoryService : IService<Category>
    {
        Task<Category> GetWithProductsByIdAsync(int CategoryId);
    }
}
