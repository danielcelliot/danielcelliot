namespace ShoppingBot
{
    public interface IBot
    {
        string GetProductUrl(string id);
        (bool successful, string message) SignIn(in Browser browser);
        (bool found, string message) CheckProductAvailability(in Browser browser);
        (bool added, string message) AddItemToCart(in Browser browser);
        bool CheckoutItem(in Browser browser);
        bool PlaceOrder(in Browser browser);
    }
}