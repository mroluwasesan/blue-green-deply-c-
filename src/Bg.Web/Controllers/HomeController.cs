using Microsoft.AspNetCore.Mvc;

namespace Bg.Web.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.Environment = "Blue"; // Change to "Green" in the Green environment
            return View();
        }
    }
}