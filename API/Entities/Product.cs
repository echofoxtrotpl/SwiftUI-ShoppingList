namespace ShoppingListAPI.Entities;

public class Product
{
    public string Id { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public bool IsPromotional { get; set; }
    public decimal Price { get; set; }
    public string PromotionDescription { get; set; }
    public string AdditionalInfo { get; set; }
}