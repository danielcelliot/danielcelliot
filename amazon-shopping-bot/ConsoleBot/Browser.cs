using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;

namespace ShoppingBot
{
    public class Browser
    {
        private string[] _userAgents =
        {
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36",
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.83 Safari/537.1",
            "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/605.1.15 (KHTML, like Gecko)",
            "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
            "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/605.1.15 (KHTML, like Gecko)",
            "Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36",
            "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36",
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36",
            "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1",
            "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0",
            "Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134"
        };

        private readonly IWebDriver _driver;

        public Browser()
        {
            // Get a random user agent
            var random = new Random();
            int index = random.Next(_userAgents.Length);

            var options = new ChromeOptions { BinaryLocation = "./chrome-bin/chrome.exe" };
            //options.EnableMobileEmulation(deviceName);
            options.AddArguments(new List<string>()
            {
                //"headless",
                //"disable-gpu",
                //"disable-software-rasterizer",
                //"no-sandbox",
                //"remote-debugging-port=9222",
                //"--app=http://www.google.com",
                //"--window-size=796,766",       // Newegg 'are you human' page
                //"--start-maximized"
                $"user-agent={_userAgents[index]}",
                "user-data-dir=C:\\Users\\Daniel\\AppData\\Local\\Chromium\\User Data",
                "log-level=4"
            });
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalCapability("useAutomationExtension", false);
            _driver = new ChromeDriver(options);
        }
        public Browser(string path)
        {
            // Get a random user agent
            var random = new Random();
            int index = random.Next(_userAgents.Length);

            var options = new ChromeOptions { BinaryLocation = path };
            options.AddArguments(new List<string>()
            {
                "headless",
                $"user-agent={_userAgents[index]}",
                "user-data-dir=C:\\Users\\Daniel\\AppData\\Local\\Chromium\\User Data",
                "log-level=4"
            });
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalCapability("useAutomationExtension", false);
            _driver = new ChromeDriver(options);
        }
        public Browser(List<string> args)
        {
            // Get a random user agent
            var random = new Random();
            int index = random.Next(_userAgents.Length);

            var options = new ChromeOptions { BinaryLocation = "./chrome-bin/chrome.exe" };
            args.Add($"user-agent={_userAgents[index]}");
            options.AddArguments(args);
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalCapability("useAutomationExtension", false);
            _driver = new ChromeDriver(options);
        }
        public Browser(string path, List<string> args)
        {
            // Get a random user agent
            var random = new Random();
            int index = random.Next(_userAgents.Length);

            var options = new ChromeOptions { BinaryLocation = path };
            args.Add($"user-agent={_userAgents[index]}");
            options.AddArguments(args);
            options.AddExcludedArgument("enable-automation");
            options.AddAdditionalCapability("useAutomationExtension", false);
            _driver = new ChromeDriver(options);
        }

        public static void CreateUserSession(string url)
        {
            Console.WriteLine("Error: Failed to automate order.");

            var visibleBrowser = new Browser(new List<string>
            {
                "log-level=4",
                "user-data-dir=C:\\Users\\Daniel\\AppData\\Local\\Chromium\\User Data"
            });
            visibleBrowser.NavigateTo(url);
        }
        public ReadOnlyCollection<Cookie> GetCookies()
        {
            ICookieJar cookies = _driver.Manage().Cookies;
            return cookies.AllCookies;
        }
        public IWebElement GetElementByXPath(string elementPath, int timeout)
        {
            ReadOnlyCollection<IWebElement> elements;

            if (timeout > 0)
            {
                _driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(timeout);
                elements = _driver.FindElements(By.XPath(elementPath));

                // Reset implicit wait timeout
                _driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(0);
            }
            else
            {
                elements = _driver.FindElements(By.XPath(elementPath));
            }

            if (elements.Count > 0)
            {
                for (int i = 0; i < elements.Count; i++)
                {
                    if (elements[i].Displayed && elements[i].Enabled)
                    {
                        return elements[i];
                    }
                }
            }

            return null;
        }
        public IWebElement GetElementByXPath(IWebElement element, string elementPath, int timeout)
        {
            ReadOnlyCollection<IWebElement> elements;

            if (timeout > 0)
            {
                _driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(timeout);
                elements = element.FindElements(By.XPath(elementPath));

                // Reset implicit wait timeout
                _driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(0);
            }
            else
            {
                elements = element.FindElements(By.XPath(elementPath));
            }

            if (elements.Count > 0)
            {
                for (int i = 0; i < elements.Count; i++)
                {
                    if (elements[i].Displayed && elements[i].Enabled)
                    {
                        return elements[i];
                    }
                }
            }

            return null;
        }
        public void Close() => _driver.Quit();
        public void NavigateTo(string url) => _driver.Url = url;
        public string GetUrl() => _driver.Url;
        public string GetPageTitle() => _driver.Title;
        //=> (string)(_driver as IJavaScriptExecutor).ExecuteScript("return document.title");
        public void Refresh(int delay = 0)
        {
            if (delay > 0)
                Thread.Sleep(delay);

            _driver.Navigate().Refresh();  
        }
        public string GetReadyState() => (string)(_driver as IJavaScriptExecutor).ExecuteScript("return document.readyState");
        public bool ClickElement(string elementPath, int timeout = 0, int attempts = 5, int delay = 2000)
        {
            bool isElementFound = false;
            IWebElement element = GetElementByXPath(elementPath, timeout);

            if (element != null)
            {
                isElementFound = true;

                try
                {
                    element.Click();
                }
                catch (Exception e)
                {
                    if (attempts > 0)
                    {
                        attempts--;
                        Thread.Sleep(delay);
                        ClickElement(elementPath, timeout, attempts, delay);
                    }

                    Console.WriteLine($"Click Error: {e.Message}");
                    throw new ElementClickInterceptedException();
                }
            }

            return isElementFound;
        }
        public bool ClickElement(string[] elementPaths, int timeout = 0, int attempts = 5, int delay = 2000)
        {
            bool isElementFound = false;

            for (int i = 0; i < elementPaths.Length; i++)
            {
                IWebElement element = GetElementByXPath(elementPaths[i], timeout);

                if (element != null)
                {
                    isElementFound = true;

                    try
                    {
                        element.Click();
                    }
                    catch (Exception e)
                    {
                        if (attempts > 0)
                        {
                            attempts--;
                            Thread.Sleep(delay);
                            ClickElement(elementPaths, timeout, attempts, delay);
                        }

                        Console.WriteLine($"Click Error: {e.Message}");
                        throw new ElementClickInterceptedException();
                    }
                }
            }

            return isElementFound;
        }
        public void MoveToElement(IWebElement element)
        {
            var actions = new Actions(_driver);
            actions.MoveToElement(element).Build().Perform();
            //actions.Perform();
        }
        public bool InputText(string elementPath, string text, bool submit, int timeout = 0)
        {
            bool isElementFound = false;
            IWebElement element = GetElementByXPath(elementPath, timeout);

            if (element != null)
            {
                isElementFound = true;
                string elementValue;
                //element.SendKeys(text);

                do
                {
                    element.SendKeys(text);
                    elementValue = GetElementValue(elementPath);

                } while (!String.Equals(elementValue, text));

                if (submit == true)
                    element.Submit();
            }

            return isElementFound;
        }
        public bool InputText((string elementPath, string text)[] items, bool submit, int timeout = 0)
        {
            IWebElement element = null;
            bool isElementFound = false;

            for (int i = 0; i < items.Length; i++)
            {
                element = GetElementByXPath(items[i].elementPath, timeout);

                if (element != null)
                {
                    isElementFound = true;
                    element.SendKeys(items[i].text);
                }
            }

            if (submit == true && element != null)
            {
                element = GetElementByXPath(items[^1].elementPath, timeout);
                element.Submit();
            }

            return isElementFound;
        }
        public string GetElementText(string elementPath, int timeout = 0)
        {
            IWebElement element = GetElementByXPath(elementPath, timeout);
            return element?.Text;
        }
        public string GetElementText(string[] elementPaths, int timeout = 0)
        {
            for (int i = 0; i < elementPaths.Length; i++)
            {
                IWebElement element = GetElementByXPath(elementPaths[i], timeout);

                if (element != null)
                    return element.Text;
            }

            return null;
        }
        public string GetElementText(IWebElement element, string elementPath, int timeout = 0)
        {
            IWebElement item = GetElementByXPath(element, elementPath, timeout);
            return item?.Text;
        }
        public string GetElementValue(string elementPath, int timeout = 0)
        {
            IWebElement element = GetElementByXPath(elementPath, timeout);
            return element?.GetAttribute("value");
        }
        public string GetElementValue(string[] elementPaths, int timeout = 0)
        {
            for (int i = 0; i < elementPaths.Length; i++)
            {
                IWebElement element = GetElementByXPath(elementPaths[i], timeout);

                if (element != null)
                    return element.GetAttribute("value");
            }

            return null;
        }
        public string GetElementValue(IWebElement element, string elementPath, int timeout = 0)
        {
            IWebElement item = GetElementByXPath(element, elementPath, timeout);
            return item?.GetAttribute("value");
        }
    }
}