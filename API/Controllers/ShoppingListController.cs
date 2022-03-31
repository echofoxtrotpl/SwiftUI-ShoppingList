using Microsoft.AspNetCore.Mvc;
using ShoppingListAPI.Entities;
using ShoppingListAPI.Services;

namespace ShoppingListAPI.Controllers;

[ApiController]
[Route("products")]
public class ShoppingListController
{
    private readonly ProductService _productService;

    public ShoppingListController(ProductService productService)
    {
        _productService = productService;
    }
    
    [HttpGet]
    public IEnumerable<Product> GetAllProducts()
    {
        return _productService.GetAllProducts();
    }
    
    [HttpGet("{id}")]
    public Product GetProductById([FromRoute] string id)
    {
        return _productService.GetProductById(id);
    }

    [HttpPost]
    public void AddProduct([FromBody] Product product)
    {
        _productService.AddProduct(product);
    }

    [HttpDelete]
    public void DeleteProduct([FromQuery] string id)
    {
        _productService.DeleteProduct(id);
    }
    
    [HttpPut]
    public Product UpdateProduct([FromBody] Product product)
    {
        return _productService.UpdateProduct(product);
    }
}