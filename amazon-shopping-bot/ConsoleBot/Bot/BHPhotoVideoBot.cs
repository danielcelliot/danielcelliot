using OpenQA.Selenium;
using ShoppingBot.Seller;
using System;

namespace ShoppingBot.Bot
{
    class BHPhotoVideoBot : IBot
    {
        public Account Account = new Account();
        public BHPhotoVideo BHPhotoVideo = new BHPhotoVideo();

        public BHPhotoVideoBot()
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

        public BHPhotoVideoBot(string email, string password)
        {
            Account.Email = email;
            Account.Password = password;
        }

        public string GetProductUrl(string id) => BHPhotoVideo.BaseUrl + BHPhotoVideo.ProductUrl + id;

        public (bool found, string message) CheckProductAvailability(in Browser browser)
        {
            string buttonText = browser.GetElementText(BHPhotoVideo.AddToCartBtn);

            if (buttonText != null)
            {
                if (buttonText.ToLower().Contains("add to cart") || buttonText.ToLower().Contains("preorder"))
                    return (true, "Product is available!");
            }

            return (false, "Product not available");
        }

        public (bool added, string message) AddItemToCart(in Browser browser)
        {
            bool itemAdded = false;

            IWebElement element = browser.GetElementByXPath(BHPhotoVideo.AddToCartBtn, 5);

            if (element != null)
            {
                // TEST: Move cursor to element before clicking
                browser.MoveToElement(element);
                bool addToCartClicked = browser.ClickElement(BHPhotoVideo.AddToCartBtn);

                if (addToCartClicked)
                {
                    itemAdded = browser.ClickElement(BHPhotoVideo.ViewCartBtn, 5);

                    if (itemAdded)
                    {
                        return (itemAdded, "Item added to cart");
                    }
                }
            }

            return (itemAdded, "Cart Error: Cannot add item to cart");
        }

        public bool CheckoutItem(in Browser browser) => throw new NotImplementedException();
        public bool PlaceOrder(in Browser browser) => throw new NotImplementedException();
        public (bool successful, string message) SignIn(in Browser browser) => throw new NotImplementedException();
    }
}
