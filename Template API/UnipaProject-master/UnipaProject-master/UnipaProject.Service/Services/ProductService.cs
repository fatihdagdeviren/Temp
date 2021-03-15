using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using UnipaProject.Core.Models;
using UnipaProject.Core.Repositories;
using UnipaProject.Core.Services;
using UnipaProject.Core.UnitOfWorks;

namespace UnipaProject.Service.Services
{
    public class ProductService : Service<Product>, IProductService
    {
        public ProductService(IUnitOfWork unitOfWork, IRepository<Product> repository) : base (unitOfWork , repository)
        {

        }
        public async Task<Product> GetWithCategoryByIdAsync(int productid)
        {
           return await  _unitOfWork.Products.GetWithCategoryByIdAsync(productid);
        }
    }
}
