using DACS_QuanLyThuVien.Data;
using DACS_QuanLyThuVien.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DACS_QuanLyThuVien.Controllers
{
    
    [ApiController]
    [Route("api/[controller]")]
    public class ReviewsController : ControllerBase
    {
        private readonly LibraryContext _context;
        public ReviewsController(LibraryContext context) => _context = context;

        [HttpGet("book/{bookId}")]
        public async Task<IActionResult> GetByBook(int bookId)
        {
            var reviews = await _context.Reviews.Where(r => r.BookId == bookId).ToListAsync();
            return Ok(reviews);
        }

        [HttpPost]
        public async Task<IActionResult> Create(Review review)
        {
            _context.Reviews.Add(review);
            await _context.SaveChangesAsync();
            return Ok(review);
        }
    }
}