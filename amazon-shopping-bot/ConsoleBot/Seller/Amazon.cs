namespace ShoppingBot
{
    public class Amazon
    {
        // Web element paths
        public string EmailTextbox { get; } = "//*[@id=\"ap_email\"]";
        public string PasswordTextbox { get; } = "//*[@id=\"ap_password\"]";
        public string PersonalizedText { get; }  = "//*[@class=\"nav-line-1-container\"]";
        public string AlertHeading { get; } = "//*[@class=\"a-alert-heading\"]";
        public string AlertText { get; } = "//*[@class=\"a-list-item\"]";
        public string[] ItemHeaders { get; } = new string[]
        {
            "//*[@class=\"itemq\"]/tbody/tr[1]/td[2]",
            "//*[@class=\"itemq\"]/tbody/tr[1]/td"
        };
        public string[] ItemNames { get; } = new string[]
        {
            "//*[@class=\"itemq\"]/tbody/tr[2]/td[2]",
            "//*[@class=\"itemq\"]/tbody/tr[2]/td"
        };
        public string[] ItemPrices { get; } = new string[]
        {
            "//*[@class=\"itemq\"]/tbody/tr[2]/td[3]",
            "//*[@class=\"itemq\"]/tbody/tr[2]/td[2]"
        };
        public string ItemQty { get; } = "//*[@class=\"itemq\"]/tbody/tr[2]/td[4]";
        public string[] ItemQtys { get; } = new string[]
        {
            "//*[@class=\"itemq\"]/tbody/tr[2]/td[4]",
            "//*[@class=\"itemq\"]/tbody/tr[2]/td[3]"
        };
        public string AddToCartBtn = "//input[@name='add']";
        public string CheckoutBtn { get; } = "//input[@name=\"proceedToRetailCheckout\"]";
        public string PlaceOrderBtn { get; } = "//*[@id=\"submitOrderButtonId\"]/span/input";

        // URLs
        public string BaseUrl { get; } = "https://www.amazon.com";
        public string ProductUrl { get; } = "/gp/product/";
        public string AddToCartUrl { get; } = "/gp/item-dispatch?action=addToCart&asin.1=";
        public string CartUrl { get; } = "/gp/cart/view.html";
        public string SignInUrl { get; } = "/ap/signin?" +
                "openid.ns=http://specs.openid.net/auth/2.0&" +
                "openid.mode=checkid_setup&" +
                "openid.identity=http://specs.openid.net/auth/2.0/identifier_select&" +
                "openid.assoc_handle=usflex&" +
                "openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select";

        // Product IDs
        public string PS5Standard { get; } = "B08FC5L3RG";
        public string PS5Digital { get; } = "B08FC6MR62";
        public string XboxSeriesX { get; } = "B08H75RTZ8";
        public string XboxSeriesS { get; } = "B08G9J44ZN";
    }
}
