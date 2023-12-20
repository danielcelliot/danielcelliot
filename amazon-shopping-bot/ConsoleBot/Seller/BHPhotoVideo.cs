namespace ShoppingBot.Seller
{
    class BHPhotoVideo
    {
        // Web element paths
        public string EmailTextbox { get; } = "//*[@id=\"user-input\"]";
        public string PasswordTextbox { get; } = "//*[@id=\"password-input\"]";
        public string SignInBtn { get; } = "//input[@data-selenium=\"checkoutNoLogin\"]";
        public string AlertText { get; } = "//*[@id=\"onePopupLayer\"]/div[2]/div/div/div[2]/div[1]/form/div[3]/label";
        public string AddToCartBtn { get; } = "//button[@data-selenium=\"addToCartButton\"]";
        public string ViewCartBtn { get; } = "//a[@data-selenium=\"itemLayerViewCartBtn\"]";
        public string CheckoutBtn { get; } = "//input[@data-selenium=\"checkoutLogin\"]";
        public string PlaceOrderBtn { get; } = "//button[@data-selenium=\"placeOrder\"]";
        public string ProductName { get; } = "//h1[@data-selenium=\"productTitle\"]";

        // URLs
        public string BaseUrl { get; } = "https://www.bhphotovideo.com/";
        public string ProductUrl { get; } = "/c/product/";
        public string CartUrl { get; } = "/find/cart.jsp";

        // Product IDs
        public string PS5Standard { get; } = "1595083-REG";

        public string GetProductId(string id)
        {
            return id switch
            {
                "1" => PS5Standard,
                _ => null,
            };
        }
    }
}
