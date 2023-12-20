using System;
using System.Linq;
using System.Threading;
using Windows.Data.Xml.Dom;
using Windows.UI.Notifications;

namespace ShoppingBot
{
    public class Program
    {
        static void Main(string[] args)
        {
            var test = new Test();
            //test.AmazonBotTest();
            //test.NeweggBotTest();
            //test.BHPhotoVideoBotTest();

            Console.WriteLine("Welcome to the Shopping Bot");
            Thread.Sleep(1000);

            int seller;
            do
            {
                Console.WriteLine("Select the seller to monitor:");
                Console.WriteLine("1 - Amazon.con");
                Console.WriteLine("2 - Newegg.com");
                Console.WriteLine("3 - B&H Photo Video");

                seller = Convert.ToInt32(Console.ReadLine());
            } while (true);



            switch (seller)
            {
                case "1":
                    test.AmazonBotTest();
                    break;
                case "2":
                    test.NeweggBotTest();
                    break;
                case "3":
                    test.BHPhotoVideoBotTest();
                    break;

                default:
                    break;
            }


        }
    }
}