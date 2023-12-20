using ShoppingBot.Bot;
using System;
using System.Linq;
using Windows.Data.Xml.Dom;
using Windows.UI.Notifications;

namespace ShoppingBot
{
    public static class Notifier
    {
        public static void Notify(string sellerName, string productName)
        {
            XmlDocument template = ToastNotificationManager.GetTemplateContent(ToastTemplateType.ToastText02);

            var textNodes = template.GetElementsByTagName("text").ToList();
            textNodes[0].AppendChild(template.CreateTextNode($"{sellerName} - Now available:"));
            textNodes[1].AppendChild(template.CreateTextNode($"{productName}"));

            var toast = new ToastNotification(template)
            {
                //Tag = "Console App",
                Group = "Bot",
            };

            ToastNotifier notifier = ToastNotificationManager.CreateToastNotifier("Shopping Bot");
            notifier.Show(toast);
        }
    }
}
