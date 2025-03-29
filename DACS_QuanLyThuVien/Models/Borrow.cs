namespace DACS_QuanLyThuVien.Models
{
    public class Borrow
    {
        public int Id { get; set; }
        public int BookId { get; set; }
        public int StudentId { get; set; }
        public DateTime BorrowDate { get; set; }
        public DateTime? ReturnDate { get; set; }

        public Book? Book { get; set; }
        public Student? Student { get; set; }
    }
}
