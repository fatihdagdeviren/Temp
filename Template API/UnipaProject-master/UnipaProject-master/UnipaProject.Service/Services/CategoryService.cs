using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Models;
using UnipaProject.Core.Repositories;
using UnipaProject.Core.Services;
using UnipaProject.Core.UnitOfWorks;
using UnipaProject.Service.Services;

namespace UnipaProject.Service
{
    public class CategoryService : Service<Category>, ICategoryService
    {
        public CategoryService(IUnitOfWork unitOfWork, IRepository<Category> repository) : base(unitOfWork, repository)
        {

        }
        public async Task<Category> GetWithProductsByIdAsync(int CategoryId)
        {
            return await _unitOfWork.Categories.GetWithProductsByIdAsync(CategoryId);
        }
    }
}
