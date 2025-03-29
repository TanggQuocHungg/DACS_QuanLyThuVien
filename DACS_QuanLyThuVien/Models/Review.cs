using System.ComponentModel.DataAnnotations;

namespace DACS_QuanLyThuVien.Models
{
    public class Review
    {
        public int Id { get; set; }

        public int BookId { get; set; }
        public string? ReviewerName { get; set; }

        [Range(1, 5)]
        public int Rating { get; set; }

        public string? Comment { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public Book? Book { get; set; }
    }
}
