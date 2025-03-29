namespace DACS_QuanLyThuVien.Models
{
    public class Favorite
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int BookId { get; set; }

        public Student? Student { get; set; }
        public Book? Book { get; set; }
    }
}
