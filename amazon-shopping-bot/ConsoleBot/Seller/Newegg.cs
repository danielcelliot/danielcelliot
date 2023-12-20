namespace ShoppingBot
{
    class Newegg
    {
        // Web element paths
        public string SignInNavBtn { get; } = "//*[@class=\"nav-complex-title\"]";
        public string EmailTextbox { get; } = "//*[@id=\"labeled-input-signEmail\"]";
        public string PasswordTextbox { get; } = "//*[@id=\"labeled-input-password\"]";
        public string PersonalizedText { get; } = "//*[@id=\"myaccount\"]/a/div[2]";
        public string AlertText { get; } = "//*[@class=\"color-red\"]";
        public string SignInBtn { get; } = "//*[@id=\"signInSubmit\"]";
        public string AddToCartBtn { get; } = "//*[@id=\"ProductBuy\"]/div/div[2]/button";
        public string AddToCartErrorMsg { get; } = "//*[@class=\"modal-content\"]";
        public string NoThanksBtn { get; } = "//*[@class=\"modal-footer\"]/button[1]";
        public string ContinueToCartBtn { get; } = "//*[@class=\"item-actions\"]/button[2]";
        public string CheckoutBtn { get; } = "//*[@class=\"summary-actions\"]/button";
        public string CardCodeTextbox { get; } = "//*[@class=\"retype-security-code\"]/input";
        public string PlaceOrderBtn { get; } = "//*[@id=\"btnCreditCard\"]";
        public string SecurityCodeAlert { get; } = "//*[@class=\"form-v-code\"]";

        // URLs
        public string BaseUrl { get; } = "https://www.newegg.com";
        public string AreYouHumanUrl { get; } = "/areyouahuman?itn=true&referer=/areyouahuman?referer=";
        public string ProductUrl { get; } = "/p/";
        public string SignInUrl { get; } = "/NewMyAccount/AccountLogin.aspx";
        public string CartUrl { get; } = "https://secure.newegg.com/shop/cart";
        public string ProductJson { get; } = "/product/api/ProductRealtime?ItemNumber=";

        // Product IDs
        public string PS5BundleController { get; } = "N82E16868110292";
        public string PS5BundleLE { get; } = "N82E16868110293";
        public string PS5BundleUE { get; } = "N82E16868110291";
        public string XboxSeriesX { get; } = "N82E16868105273";
        public string XboxSeriesS { get; } = "N82E16868105274";
    }
}