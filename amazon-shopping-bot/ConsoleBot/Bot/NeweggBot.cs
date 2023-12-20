using OpenQA.Selenium;
using System;
using System.Linq;
using System.Threading;

namespace ShoppingBot
{
    class NeweggBot : IBot
    {
        public Account Account = new Account();
        public Newegg Newegg = new Newegg();

        public NeweggBot()
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

            Console.Write("Enter your 3-digit Credit Card security code: ");
            Account.CardCode = Console.ReadLine();
        }
        
        public NeweggBot(string email, string password, string ccv)
        {
            Account.Email = email;
            Account.Password = password;
            Account.CardCode = ccv;
        }

        public List<string> FormatProductInfo(in Browser browser)
        {
           var cartItemDetails = new List<string>();
           ReadOnlyCollection<IWebElement> cartItems = browser.GetElementsByXPath(Newegg.CartItems, 10);

           if (cartItems != null)
           {
               for (int i = 0; i < cartItems.Count; i++)
               {
                   string itemName = browser.GetElementText(cartItems.ElementAt(i), Newegg.CartItemName, 0);
                   string itemPrice = browser.GetElementText(cartItems.ElementAt(i), Newegg.CartItemPrice, 0);
                   string itemQty = browser.GetElementValue(cartItems.ElementAt(i), Newegg.CartItemQty, 0);

                   cartItemDetails.Add($"Item: {itemName}\nPrice: {itemPrice}\nQuantity: {itemQty}");
               }
           }

           return cartItemDetails;
        }

        public string SolveCaptcha(in Browser browser)
        {
           string currentUrl = browser.GetUrl();

           // Get referrer
           string encodedRef = currentUrl.Remove(currentUrl.Length - 6).Replace(Newegg.AreYouHumanUrl, "");
           string decodedRef = HttpUtility.UrlDecode(encodedRef);

           while (browser.GetPageTitle().ToLower().Contains("are you a human"))
           {
               Console.WriteLine("Waiting for CAPTCHA to be solved...");
               Thread.Sleep(2000);
           }

           return  decodedRef;
        }

        public bool CheckForCaptcha(in Browser browser)
        {
            if (browser.GetPageTitle().ToLower().Contains("are you a human"))
            {
                return true;
            }

            return false;
        }

        public bool EnterCardCode(in Browser browser)
        {
            bool isElementFound = false;
            IWebElement element = browser.GetElementByXPath(Newegg.CardCodeTextbox, 0);

            if (element != null)
            {
                browser.MoveToElement(element);

                isElementFound = true;
                string elementValue, code;

                do
                {
                    Console.WriteLine("Entering code...");

                    // NOTE: This fixes text entry for Credit card code
                    element.SendKeys("   ");
                    element.SendKeys(Keys.Backspace);
                    element.SendKeys(Keys.Backspace);
                    element.SendKeys(Keys.Backspace);

                    element.SendKeys(Account.CardCode);

                    elementValue = browser.GetElementValue(Newegg.CardCodeTextbox);
                    code = String.Concat(elementValue.Where(c => !Char.IsWhiteSpace(c)));
                    Console.WriteLine($"Text value: {code}");

                    Thread.Sleep(1000);
                } while (!String.Equals(Account.CardCode, code));
            }

            return isElementFound;
        }
        
        public string GetProductUrl(string id) => Newegg.BaseUrl + Newegg.ProductUrl + id;

        public (bool successful, string message) SignIn(in Browser browser)
        {
            bool buttonClicked;

            // Email address input
            bool textInputted = browser.InputText(Newegg.EmailTextbox, Account.Email, false, 5);
            if (textInputted)
            {
                 buttonClicked = browser.ClickElement(Newegg.SignInBtn);
            }
            else
            {
                return (false, "Sign-In Error: cannot enter email address");
            }

            if (buttonClicked)
            {
                (bool emailVerified, string emailMessage) = Verify(browser);
            
                if (!emailVerified)
                    return (emailVerified, emailMessage);
            }

            // Security code check
            IWebElement securityAlert = browser.GetElementByXPath(Newegg.SecurityCodeAlert, 5);

            if (securityAlert != null)
            {
                return (false, "Security alert: verification code sent to your email address.");
            }

            // Password input
            textInputted = browser.InputText(Newegg.PasswordTextbox, Account.Password, false, 5);
            if (textInputted)
            {
                buttonClicked = browser.ClickElement(Newegg.SignInBtn);
            }
            else
            {
                return (false, "Sign-In Error: cannot enter password");
            }

            if (buttonClicked)
            {
                (bool passwordVerified, string passwordMessage) = Verify(browser);

                if (!passwordVerified)
                    return (passwordVerified, passwordMessage);
            }

            return (true, "Success");

            (bool verified, string message) Verify(in Browser browser)
            {
                // Webpage displayes an alert message when the input is invalid.
                string alertMessage = browser.GetElementText(Newegg.AlertText, 3);

                if (alertMessage == null)
                    return (true, "No alert messages found");

                return (false, $"{alertMessage}");
            }
        }

        public (bool found, string message) CheckProductAvailability(in Browser browser)
        {
            string buttonText = browser.GetElementText(Newegg.AddToCartBtn);

            if (buttonText != null)
            {
                if (buttonText.ToLower().Contains("add to cart") || buttonText.ToLower().Contains("pre-order"))
                    return (true, "Product is available!");
            }

            return (false, "Product not available");
        }

        public (bool added, string message) AddItemToCart(in Browser browser)
        {
            bool itemAdded = false;

            // TEST: Move cursor to element before clicking
            IWebElement element = browser.GetElementByXPath(Newegg.AddToCartBtn, 5);

            if (element != null)
            {
                browser.MoveToElement(element);
                bool addToCartClicked = browser.ClickElement(Newegg.AddToCartBtn);

                if (addToCartClicked)
                {
                    // Reject special offers, if any
                    _ = browser.ClickElement(Newegg.NoThanksBtn, 3);

                    itemAdded = browser.ClickElement(Newegg.ContinueToCartBtn, 5);

                    if (itemAdded)
                    {
                        return (itemAdded, "Item added to cart");
                    }

                    // Check for 'add to cart' error --  due to bot detection
                    IWebElement cartError = browser.GetElementByXPath(Newegg.AddToCartErrorMsg, 5);

                    if (cartError != null)
                    {
                        return (itemAdded, "Cart Error: Bot was detected!");
                    }
                }
            }

            return (itemAdded, "Cart Error: Cannot add item to cart");
        }
        public bool CheckoutItem(in Browser browser) => browser.ClickElement(Newegg.CheckoutBtn, 5);
        public bool PlaceOrder(in Browser browser) => browser.ClickElement(Newegg.PlaceOrderBtn, 5);
    }
}