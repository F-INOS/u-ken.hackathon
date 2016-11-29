package booklist.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;

import booklist.bean.Book;

@WebServlet("/Result")
public class ResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ResultServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException{
        request.setCharacterEncoding("UTF-8");

        String searchWord = request.getParameter("word");
        String str = executeForJson("http://devwatsong.mybluemix.net/SearchWatsong", searchWord);
        str = str.replaceAll("\\\"", "\\\\\\\"");
        str = "\"" + str + "\"";
        request.setAttribute("jsonstr", str);

        RequestDispatcher rd = request.getRequestDispatcher("./search_result.jsp");
        rd.forward(request, response);
    }

	public String executeForJson(String url, String searchWord) {
		HttpResponse response = null;
		String str = "";
		try {
			DefaultHttpClient httpclient = new DefaultHttpClient();
			HttpContext httpcontext = new BasicHttpContext();
			HttpPost request = new HttpPost(url);
			List<NameValuePair> params = new ArrayList<NameValuePair>();
			params.add(new BasicNameValuePair("searchword", searchWord));
			try {
				request.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));
			} catch (UnsupportedEncodingException e) {
			}

			response = httpclient.execute(request, httpcontext);
			int statusCode = response.getStatusLine().getStatusCode();
			HttpEntity entity = response.getEntity();
			str = EntityUtils.toString(entity, HTTP.UTF_8);
		} catch (IOException e) {
		} catch (Exception e) {
		}
		return str;
	}

}
