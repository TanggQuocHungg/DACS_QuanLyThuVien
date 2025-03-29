using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DACS_QuanLyThuVien.Data;
using DACS_QuanLyThuVien.Models;

namespace DACS_QuanLyThuVien.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BooksController : ControllerBase
    {
        private readonly LibraryContext _context;
        public BooksController(LibraryContext context) => _context = context;

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Book>>> GetBooks() => Ok(await _context.Books.ToListAsync());

        [HttpGet("{id}")]
        public async Task<ActionResult<Book>> GetBook(int id)
        {
            var book = await _context.Books.FindAsync(id);
            return book == null ? NotFound() : Ok(book);
        }

        [Authorize(Roles = "Admin,Librarian")]
        [HttpPost]
        public async Task<ActionResult<Book>> PostBook(Book book)
        {
            _context.Books.Add(book);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetBook), new { id = book.Id }, book);
        }

        [Authorize(Roles = "Admin,Librarian")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBook(int id, Book book)
        {
            if (id != book.Id) return BadRequest();
            _context.Entry(book).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [Authorize(Roles = "Admin,Librarian")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBook(int id)
        {
            var book = await _context.Books.FindAsync(id);
            if (book == null) return NotFound();
            _context.Books.Remove(book);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<Book>>> Search(string? query, bool? availableOnly)
        {
            var books = _context.Books.AsQueryable();
            if (!string.IsNullOrWhiteSpace(query))
                books = books.Where(b => b.Title.Contains(query) || b.Author.Contains(query) || b.Genre.Contains(query));
            if (availableOnly == true)
                books = books.Where(b => b.Quantity > 0);
            return await books.ToListAsync();
        }
    }
}