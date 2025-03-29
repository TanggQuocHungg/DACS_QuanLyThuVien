using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DACS_QuanLyThuVien.Data;
using DACS_QuanLyThuVien.Models;

namespace DACS_QuanLyThuVien.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FavoritesController : ControllerBase
    {
        private readonly LibraryContext _context;
        public FavoritesController(LibraryContext context) => _context = context;

        [HttpGet("student/{studentId}")]
        public async Task<IActionResult> GetByStudent(int studentId)
        {
            var favorites = await _context.Favorites
                .Include(f => f.Book)
                .Where(f => f.StudentId == studentId)
                .ToListAsync();
            return Ok(favorites);
        }

        [HttpPost]
        public async Task<IActionResult> Add(Favorite favorite)
        {
            _context.Favorites.Add(favorite);
            await _context.SaveChangesAsync();
            return Ok(favorite);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Remove(int id)
        {
            var fav = await _context.Favorites.FindAsync(id);
            if (fav == null) return NotFound();
            _context.Favorites.Remove(fav);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}