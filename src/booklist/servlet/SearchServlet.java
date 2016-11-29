package booklist.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booklist.bean.Book;

@WebServlet("/Search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SearchServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //http://localhost:9080/BookListApplication/BookList

        Book book1 = new Book("WebSphere Application Server 構築・運用バイブル", "WebSphere", 4800, "978-4774153193");
        Book book2 = new Book("DB2 10 エバリュエーション・ガイドブック", "DB2", 3200, "978-4798131894");
        Book book3 = new Book("スマートマシンがやってくる", "Cognitive", 1600, "978-4822250324");

        ArrayList<Book> bookList = new ArrayList<Book>();
        bookList.add(book1);
        bookList.add(book2);
        bookList.add(book3);

        request.setAttribute("bookList", bookList);

        RequestDispatcher rd = request.getRequestDispatcher("./search.jsp");
        rd.forward(request, response);
    }


}
