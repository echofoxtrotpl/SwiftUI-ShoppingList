using ShoppingListAPI.Entities;

namespace ShoppingListAPI.Services;

public class ProductService
{
    private readonly ShoppingListDbContext _dbContext;

    public ProductService(ShoppingListDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public IEnumerable<Product> GetAllProducts()
    {
        return _dbContext.Products.ToList();
    }
    
    public Product GetProductById(string id)
    {
        return _dbContext.Products.Find(id);
    }

    public void AddProduct(Product product)
    {
        _dbContext.Products.Add(product);
        _dbContext.SaveChanges();
    }

    public void DeleteProduct(string id)
    {
        var toDelete = _dbContext.Products.Find(id);
        if (toDelete is null) return;
        _dbContext.Products.Remove(toDelete);
        _dbContext.SaveChanges();
    }
    
    public Product UpdateProduct(Product product)
    {
        var toUpdate = _dbContext.Products.Find(product.Id);
        if (toUpdate is null) return null;

        toUpdate.Name = product.Name;
        toUpdate.Quantity = product.Quantity;
        toUpdate.IsPromotional = product.IsPromotional;
        toUpdate.AdditionalInfo = product.AdditionalInfo;

        if (!product.IsPromotional)
        {
            toUpdate.Price = 0;
            toUpdate.PromotionDescription = "";
        }
        else
        {
            toUpdate.Price = product.Price;
            toUpdate.PromotionDescription = product.PromotionDescription;
        }
        
        _dbContext.SaveChanges();

        return toUpdate;
    }
}