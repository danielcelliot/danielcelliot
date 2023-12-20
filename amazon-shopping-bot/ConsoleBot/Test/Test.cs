using ShoppingBot.Bot;
using System;
using System.Threading;

namespace ShoppingBot
{
    class Test
    {
        /* Modify network conditions */
        //ChromeNetworkConditions conditions = new ChromeNetworkConditions();
        //conditions.DownloadThroughput = 40000;
        //conditions.UploadThroughput = 20000;
        //conditions.Latency = TimeSpan.FromMilliseconds(1500);
        //(driver as ChromeDriver).NetworkConditions = conditions;

        /* Browser info */
        //var userAgent = (driver as IJavaScriptExecutor).ExecuteScript("return window.navigator.userAgent");
        //var plugins = (driver as IJavaScriptExecutor).ExecuteScript("return window.navigator.plugins");
        //var languages = (driver as IJavaScriptExecutor).ExecuteScript("return window.navigator.languages");

        public void GetJsonTest()
        {

        }

        public void AmazonBotTest()
        {
            var amazonBot = new AmazonBot("danielcelliot@fakeemail.com", "thisisafakepassword");
            var browser = new Browser();

            /* Amazon Test IDs */
            // B08FC6C75Y   dualsense
            // B089FMM133   ps4-pro
            // B074LRF639   ps4-slim
            // B06Y66K3XD   rx-580
            // B08FC5L3RG   ps5-standard

            try
            {
                // Product page
                string url = amazonBot.GetProductUrl(amazonBot.Amazon.PS5Standard);
                browser.NavigateTo(url);
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                (bool isAvailable, string message) product;
                int delay = 5000;
                do
                {
                    product = amazonBot.CheckProductAvailability(browser);
                    if (!product.isAvailable)
                    {
                        Console.WriteLine($"{product.message}\nRetrying...");
                        browser.Refresh(delay);
                    }
                } while (!product.isAvailable);

                (bool success, string message) = amazonBot.AddItemToCart(browser);
                if (!success)
                {
                    Console.WriteLine(message);
                    browser.Close();

                    Browser.CreateUserSession(url);
                    return;
                }
                Console.WriteLine("Item added to cart...");

                success = amazonBot.CheckoutItem(browser);
                if (!success)
                {
                    Console.WriteLine("Failed to check out item");
                    browser.Close();

                    Browser.CreateUserSession(amazonBot.Amazon.BaseUrl + amazonBot.Amazon.CartUrl);
                    return;
                }
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                if (browser.GetPageTitle().ToLower().Contains("sign-in"))
                {
                    (success, message) = amazonBot.SignIn(browser);
                    if (!success)
                    {
                        Console.WriteLine(message);
                        browser.Close();

                        Browser.CreateUserSession(amazonBot.Amazon.BaseUrl + amazonBot.Amazon.CartUrl);
                        return;
                    }
                    Console.WriteLine("Signed in successfully...");
                }
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                //success = amazonBot.PlaceOrder(browser);
                //if (!success)
                //{
                //    Console.WriteLine("Failed to place order");
                //    browser.Close();
                //    Browser.CreateUserSession(amazonBot.Amazon.BaseUrl + amazonBot.Amazon.CartUrl);
                //    return;
                //}
                //Console.WriteLine("Placing order for item...");

                // TODO: Display confirmation (Item name, order id)
                // TODO: Save screenshot
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e.Message}");
                return;
            }

            // Cleanup
            //browser.Close();
            //return;
        }

        public void NeweggBotTest()
        {
            var neweggBot = new NeweggBot("danielcelliot@fakeemail.com", "thisisafakepassword", "572");
            var browser = new Browser();

            /* Newegg Test IDs */
            // N82E16814137445  RTX 2070 Super
            // N82E16814126452  RTX 3080
            // N82E16879261876  Demon's Souls
            // N82E16820248142  Xbox Series X|S Expansion
            // N82E16868105274  Xbox Series S
            // N82E16868105273  Xbox Series X

            try
            {
                // Order steps:

                // 1. Go to product page
                string url = neweggBot.GetProductUrl("N82E16879261876");
                browser.NavigateTo(url);
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                if (neweggBot.CheckForCaptcha(browser))
                {
                    Console.WriteLine("CAPTCHA verification detected!");
                    browser.Close();

                    Browser.CreateUserSession(url);
                    return;
                }

                // 2. Check for availability
                (bool isAvailable, string message) product;
                int delay = 5000;
                do
                {
                    product = neweggBot.CheckProductAvailability(browser);
                    if (!product.isAvailable)
                    {
                        Console.WriteLine($"{product.message}\nRetrying...");
                        browser.Refresh(delay);

                        if (neweggBot.CheckForCaptcha(browser))
                        {
                            Console.WriteLine("CAPTCHA verification detected!");
                            browser.Close();

                            Browser.CreateUserSession(url);
                            return;
                        }
                    }
                } while (!product.isAvailable);

                // Moving too fast triggers cart error
                while (browser.GetReadyState().ToLower() != "interactive" && browser.GetReadyState().ToLower() != "complete")
                {
                    Console.WriteLine(browser.GetReadyState());
                }
                Thread.Sleep(3000);

                // 3. Click add to cart / pre-order button
                (bool success, string message) = neweggBot.AddItemToCart(browser);
                if (!success)
                {
                    Console.WriteLine(message);
                    browser.Close();

                    Browser.CreateUserSession(url);
                    return;
                }
                Console.WriteLine(message);

                // 4. Click checkout button
                success = neweggBot.CheckoutItem(browser);
                if (!success)
                {
                    Console.WriteLine("Failed to check out item!");
                    browser.Close();

                    Browser.CreateUserSession(neweggBot.Newegg.CartUrl);
                    return;
                }
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                // NOTE: Check must be completed. Otherwise proceeding code will execute before next page is loaded.
                Thread.Sleep(3000);
                while (browser.GetReadyState().ToLower() != "complete")
                {
                    Console.WriteLine(browser.GetReadyState());
                }

                // 5. Sign In
                if (browser.GetPageTitle().ToLower().Contains("sign in"))
                {
                    (success, message) = neweggBot.SignIn(browser);
                    if (!success)
                    {
                        Console.WriteLine(message);
                        browser.Close();

                        Browser.CreateUserSession(neweggBot.Newegg.CartUrl);
                        return;
                    }
                    Console.WriteLine("Signed in successfully!");
                }
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                // 6. Enter CC Code in textbox
                success = neweggBot.EnterCardCode(browser);
                if (!success)
                {
                    Console.WriteLine("Failed to enter credit card code");
                    browser.Close();

                    Browser.CreateUserSession(neweggBot.Newegg.CartUrl);
                    return;
                }
                Console.WriteLine("Credit card code entered...");

                // 7. Click place order button
                //success = neweggBot.PlaceOrder(browser);
                //if (!success)
                //{
                //    Console.WriteLine("Failed to place order");
                //    return;
                //}
                //Console.WriteLine("Placing order for item...");

                // 8. TODO: Display confirmation (Item name, order id)
                // 9. TODO: Save screenshot
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e.Message}");
                return;
            }

            // 10. Cleanup
            //browser.Close();
            //return;
        }

        public void BHPhotoVideoBotTest(string productNumber)
        {
            var bhPhotoVideoBot = new BHPhotoVideoBot();
            var browser = new Browser();

            /* B&H Test IDs */
            // 1297871-REG  GTX 1050 Ti

            try
            {
                // 1. Go to product page
                string productUrl = bhPhotoVideoBot.GetProductUrl("1297871-REG");
                browser.NavigateTo(productUrl);
                Console.WriteLine($"Current page: {browser.GetPageTitle()}");

                // 2. Check for availability
                (bool isAvailable, string message) product;
                int delay = 5000;
                do
                {
                    product = bhPhotoVideoBot.CheckProductAvailability(browser);
                    if (!product.isAvailable)
                    {
                        Console.WriteLine($"{product.message}\nRetrying...");
                        browser.Refresh(delay);
                    }
                } while (!product.isAvailable);

                // 3. Post toast notification
                Notifier.Notify("B&H Photo Video", browser.GetElementText(bhPhotoVideoBot.BHPhotoVideo.ProductName, 5));
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e.Message}");
                return;
            }

            // 10. Cleanup
            //browser.Close();
            //return;
        }
    }
}