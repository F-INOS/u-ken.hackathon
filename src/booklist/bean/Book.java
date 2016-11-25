package booklist.bean;

public class Book {
    private String title;
    private String type;
    private int price;
    private String isbn;

    public Book(String title, String type, int price, String isbn) {
        this.title = title;
        this.type = type;
        this.price = price;
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public String getType() {
        return type;
    }

    public int getPrice() {
        return price;
    }

    public String getIsbn() {
        return isbn;
    }

    @Override
    public int hashCode() {
        return title.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Book) {
            return this.equals((Book)obj);
        } else {
            return false;
        }
    }

    public boolean equals(Book obj) {
        if (this == obj) {
            return true;
        } else {
            if ((this.title.equals(obj.title)) && (this.type.equals(obj.type)) &&
                (this.price == obj.price) && (this.isbn.equals(obj.isbn))) {
                return true;
            } else {
                return false;
            }
        }
    }
}
