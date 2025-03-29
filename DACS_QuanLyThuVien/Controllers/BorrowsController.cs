using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DACS_QuanLyThuVien.Data;
using DACS_QuanLyThuVien.Models;

namespace DACS_QuanLyThuVien.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BorrowsController : ControllerBase
    {
        private readonly LibraryContext _context;
        public BorrowsController(LibraryContext context) => _context = context;

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Borrow>>> GetBorrows() =>
            await _context.Borrows.Include(b => b.Book).Include(b => b.Student).ToListAsync();

        [HttpGet("{id}")]
        public async Task<ActionResult<Borrow>> GetBorrow(int id)
        {
            var borrow = await _context.Borrows.Include(b => b.Book).Include(b => b.Student).FirstOrDefaultAsync(b => b.Id == id);
            return borrow == null ? NotFound() : Ok(borrow);
        }

        [HttpPost]
        public async Task<ActionResult<Borrow>> PostBorrow(Borrow borrow)
        {
            _context.Borrows.Add(borrow);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetBorrow), new { id = borrow.Id }, borrow);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutBorrow(int id, Borrow borrow)
        {
            if (id != borrow.Id) return BadRequest();
            _context.Entry(borrow).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBorrow(int id)
        {
            var borrow = await _context.Borrows.FindAsync(id);
            if (borrow == null) return NotFound();
            _context.Borrows.Remove(borrow);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}