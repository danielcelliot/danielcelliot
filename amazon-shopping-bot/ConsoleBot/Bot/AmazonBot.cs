using System;

namespace ShoppingBot
{
    public class AmazonBot : IBot
    {
        public Account Account = new Account();
        public Amazon Amazon = new Amazon();

        public AmazonBot()
        {
            Console.Write("Enter your email: ");
            Account.Email = Console.ReadLine();

            Console.Write("Enter your password: ");
            ConsoleKey key;

            do
            {
                ConsoleKeyInfo keyInfo = Console.ReadKey(intercept: true);
                key = keyInfo.Key;

                if (key == ConsoleKey.Backspace && Account.Password.Length > 0)
                {
                    Console.Write("\b \b");
                    Account.Password = Account.Password[0..^1];
                }
                else if (!Char.IsControl(keyInfo.KeyChar))
                {
                    Console.Write("*");
                    Account.Password += keyInfo.KeyChar;
                }
            } while (key != ConsoleKey.Enter);

            Console.Write("\n");
        }

        public AmazonBot(string email, string password)
        {
            Account.Email = email;
            Account.Password = password;
        }

        public string FormatProductInfo(string name, string price, string qty) => $"Item: {name}\nPrice: {price}\nQuantity: {qty}";
        public string GetProductUrl(string id) => Amazon.BaseUrl + Amazon.AddToCartUrl + id;

        public (bool successful, string message) SignIn(in Browser browser)
        {
            // Email address input
            bool textInputted = browser.InputText(Amazon.EmailTextbox, Account.Email, true, 5);

            if (textInputted)
            {
                (bool emailVerified, string emailMessage) = Verify(browser);

                if (!emailVerified)
                    return (emailVerified, emailMessage);
            }

            // Password input
            textInputted = browser.InputText(Amazon.PasswordTextbox, Account.Password, true, 5);

            if (textInputted)
            {
                (bool passwordVerified, string passwordMessage) = Verify(browser);

                if (!passwordVerified)
                    return (passwordVerified, passwordMessage);
            }

            return (true, "Success");

            (bool verified, string message) Verify(in Browser browser)
            {
                // Webpage displayes an alert message when the input is invalid.
                string alertHeader = browser.GetElementText(Amazon.AlertHeading, 3);

                if (alertHeader == null)
                {
                    return (true, "No alert messages found");
                }

                string alertContent = browser.GetElementText(Amazon.AlertText);
                return (false, $"{alertHeader}. {alertContent}");
            }
        }

        public (bool found, string message) CheckProductAvailability(in Browser browser)
        {
            string itemHeader, itemName, price, qty;

            for (int i = 0; i < Amazon.ItemHeaders.Length; i++)
            {
                itemHeader = browser.GetElementText(Amazon.ItemHeaders[i]);

                if (itemHeader != null)
                {
                    itemName = browser.GetElementText(Amazon.ItemNames[i]);

                    if (itemHeader.ToLower() == "item")
                    {
                        price = browser.GetElementText(Amazon.ItemPrices[i]);
                        qty = browser.GetElementText(Amazon.ItemQtys[i]);

                        if (price != null && qty != null)
                            return (true, FormatProductInfo(itemName, price, qty));
                        else
                            return (false, FormatProductInfo(itemName, "Unknown", "Unknown"));
                    }
                    else
                    {
                        return (false, $"{itemHeader} {itemName}");
                    }
                }
            }

            return (false, "Not available!");
        }

        public (bool added, string message) AddItemToCart(in Browser browser)
        {
            bool itemAdded = browser.ClickElement(Amazon.AddToCartBtn);

            if (itemAdded)
                return (itemAdded, "Item added to cart");

            return (itemAdded, "Cart Error: Cannot add item to cart");
        }
        
        public bool CheckoutItem(in Browser browser) => browser.ClickElement(Amazon.CheckoutBtn);
        public bool PlaceOrder(in Browser browser) => browser.ClickElement(Amazon.PlaceOrderBtn);
    }
}