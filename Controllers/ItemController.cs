using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using ItemFinderWeb.Models;
using System.Collections.ObjectModel;

namespace ItemFinderWeb.Controllers
{
    public class ItemController : Controller
    {
        public IActionResult Index(string search)
        {
            var filePath = Path.Combine(Directory.GetCurrentDirectory(), "Assets", "ItemData.json");
            var jsonData = System.IO.File.ReadAllText(filePath);
            var menuItems = JsonConvert.DeserializeObject<List<ItemModel>>(jsonData);
            if (!string.IsNullOrWhiteSpace(search) && menuItems != null)
            {
                menuItems = menuItems.Where(item =>item.ItemName.Contains(search, StringComparison.OrdinalIgnoreCase)).ToList();
            }
            else
            {
                //menuItems = menuItems.ToList();
            }

            ViewBag.Search = search;
            return View(menuItems);
        }
    }
}
