﻿using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using Core.Entities;

namespace Core.DataAccess
{
    //T:class,IEntity,new() => referans tipi olan, IEntity'den tureyen ve new() lenebilen hersey.
    public interface IEntityRepository<T> where T:class,IEntity,new()
    {
        T Get(Expression<Func<T, bool>> filter);
        IList<T> GetList(Expression<Func<T, bool>> filter = null);
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
    }
}
