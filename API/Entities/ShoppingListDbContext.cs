using Microsoft.EntityFrameworkCore;

namespace ShoppingListAPI.Entities;

public class ShoppingListDbContext : DbContext
{
    public DbSet<Product> Products { get; set; }
}