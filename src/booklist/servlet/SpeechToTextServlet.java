package booklist.servlet;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.ibm.watson.developer_cloud.http.HttpMediaType;
import com.ibm.watson.developer_cloud.natural_language_classifier.v1.NaturalLanguageClassifier;
import com.ibm.watson.developer_cloud.natural_language_classifier.v1.model.Classification;
import com.ibm.watson.developer_cloud.speech_to_text.v1.SpeechToText;
import com.ibm.watson.developer_cloud.speech_to_text.v1.model.RecognizeOptions;
import com.ibm.watson.developer_cloud.speech_to_text.v1.model.SpeechResults;

/**
 * Servlet implementation class SpeechToTextServlet
 */
//@WebServlet("/SpeechToTextServlet")
@WebServlet("/speech2text")
public class SpeechToTextServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SpeechToTextServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

		  String contenttype = "application/json; charset=UTF-8";
		    String audio_type = "audio/wav";
		    byte[] audio_file = null;
		    String out = "";

		    String uploadPath = getServletContext().getRealPath("/WEB-INF/uploaded")+"/moriagaru.wav";
		    ArrayList<String> resultOutput = new ArrayList<String>();

		    // Speech to Text を使うための username と password（環境変数にかかれていたもの）
		    //String username = "66f9705d-b524-4cac-b532-9691ffc9fa10", password = "SH2mRhiSzUkL";
		    String username = "be7c608d-c792-41b1-9058-84a79efdcce0", password = "e36CKJKNlfFY";

		    req.setCharacterEncoding( "UTF-8" );

		    ServletContext sc = this.getServletContext();
		    String path = getServletContext().getRealPath("data");

		    DiskFileItemFactory factory = new DiskFileItemFactory();
		    ServletFileUpload upload = new ServletFileUpload(factory);

		    upload.setHeaderEncoding( "UTF-8" );

		    JSONParser parser = new JSONParser();

		    String strHidURL = "";
		    String strInput = "";

		    String strHidBlob="";

		    try{

		    	strHidURL = req.getParameter("bUrl");
		    	strInput = req.getParameter("tInput");

		    	if (strInput.indexOf("もりあがる")!=-1)
		    	{

		    	}

		    	//Part part= req.getPart(strHidBlob);
		    	//part.write(uploadPath);

		      //List<FileItem> list = upload.parseRequest(req);
		      //Iterator<FileItem> iterator = list.iterator();

		      FileItemIterator iterator = upload.getItemIterator( req );

		      ////FileItemIterator iterator = upload.getItemIterator( req );
		      while( iterator.hasNext() ){
		    	FileItemStream item = iterator.next();
		        //FileItem item=(FileItem)iterator.next();
		        InputStream stream = item.openStream();

		        if	(item.isFormField()){
		        		strHidURL = req.getParameter("hidUrl");
		        }

		        if( !item.isFormField() ){
		          String fieldname = item.getFieldName();
		          String filename = item.getName();

		          if ((filename != null) && (!filename.equals(""))){
		              // ファイル名に関する処理
		              filename = (new File(filename)).getName();
		              //item.write(new File(path + "/" + filename));
		            }

		          // audio_file フィールドに指定された音声ファイルのバイナリを取得する
		          if( fieldname.equals( "audio_file" ) ){
		            audio_type = item.getContentType();  // 音声ファイルの Content-Type

		            int len = 0;
		            int size = 0;
		            byte[] buffer = new byte[10*1024*1024]; //. 10MB MAX
		            ByteArrayOutputStream baos = new ByteArrayOutputStream();
		            while( ( len = stream.read( buffer, 0, buffer.length ) ) != -1 ){
		              baos.write( buffer, 0, len );
		              size += len;
		            }

		            audio_file = baos.toByteArray();  // 音声ファイルのバイト配列

		            //toku
		            FileOutputStream fos = new FileOutputStream("./testaudio.wav");
		            fos.write(audio_file);
		            fos.close();//閉じる(fosを使ったファイル操作を終えた時に実行)
		          }
		        }
		      }

		      /*if( audio_file != null ){
		        HttpClient client = new HttpClient();
		        byte[] b64data = Base64.encodeBase64( ( username + ":" + password ).getBytes() );

		        // /v1/recognize に音声ファイルのバイナリをポストする（パラメータで日本語音声であることを指定）
		        PostMethod post = new PostMethod( "https://stream.watsonplatform.net/speech-to-text/api/v1/recognize?model=ja-JP_BroadbandModel" );
		        post.setRequestHeader( "Authorization", "Basic " + new String( b64data ) );
		        post.setRequestHeader( "Content-Type", audio_type );
		        ByteArrayRequestEntity entity = new ByteArrayRequestEntity( audio_file );
		        post.setRequestEntity( entity );

		        int sc = client.executeMethod( post );
		        if( sc == 200 ){
		          // ポスト結果(JSON)を UTF-8 テキストで取り出す
		          byte[] b = post.getResponseBody();
		          out = new String( b, "UTF-8" );  // ※

		          resultOutput.add(out);



		          // テキスト内の日本語認識結果と、その確度（自信）を取り出す
		          JSONObject obj = ( JSONObject )parser.parse( out );
		          JSONArray results = ( JSONArray )obj.get( "results" );
		          if( results.size() > 0 ){
		            JSONObject result = ( JSONObject )results.get( 0 );
		            JSONArray alternatives = ( JSONArray )result.get( "alternatives" );
		            for( int i = 0; i < alternatives.size(); i ++ ){
		              JSONObject alternative = ( JSONObject )alternatives.get( i );
		              Double confidence = ( Double )alternative.get( "confidence" );
		              String transcript = ( String )alternative.get( "transcript" );

		              out = transcript + "\t" + confidence;  // 結果をタブでつないで出力する
		              System.out.println( out );

		              resultOutput.add(confidence.toString());
		              resultOutput.add(transcript);
		            }
		          }
		        }
		      }*/
		    }catch( Exception e ){
		      e.printStackTrace();
		    }



		    //com.ibm.watson.developer_cloudのやりかた
		    //参考：http://qiita.com/oyahiroki/items/a56f7d8a5d278764349d
		    SpeechToText stt = new SpeechToText();
	        stt.setUsernameAndPassword(username, password);
	        //stt.setEndPoint("https://stream.watsonplatform.net/speech-to-text/api");

	        //File audio = new File("C:\\tmp\\aiueo1.wav");
	        //File audio = new File(strHidURL);
	        File audio = new File(uploadPath);
	        RecognizeOptions recognizeOptions = new RecognizeOptions.Builder()
            .contentType(HttpMediaType.AUDIO_WAV) //
            .continuous(true) //
            .interimResults(true) //
            .model("ja-JP_BroadbandModel") //
            .build();

	        SpeechResults rs = stt.recognize(audio , recognizeOptions).execute();

	        System.out.println(rs);
	        resultOutput.add(rs.toString());

	        // テキスト内の日本語認識結果と、その確度（自信）を取り出す
			try {
		        JSONObject obj = null;
				obj = ( JSONObject )parser.parse( rs.toString() );
				JSONArray results = ( JSONArray )obj.get( "results" );
		        if( results.size() > 0 ){
		        JSONObject result = ( JSONObject )results.get( 0 );
		        JSONArray alternatives = ( JSONArray )result.get( "alternatives" );
		        for( int i = 0; i < alternatives.size(); i ++ ){
		            JSONObject alternative = ( JSONObject )alternatives.get( i );
		            Double confidence = ( Double )alternative.get( "confidence" );
		            String transcript = ( String )alternative.get( "transcript" );

		            out = transcript + "\t" + confidence;  // 結果をタブでつないで出力する
		            System.out.println( out );

		            resultOutput.add(confidence.toString());
		            resultOutput.add(transcript);


		            //NLCはどうかな？
					NaturalLanguageClassifier service = new NaturalLanguageClassifier();
					service.setUsernameAndPassword("69b20f57-c85e-4cf0-a016-9e5bfd407a6d", "NhApFs18GHA3");

					Classification classification = service.classify("8d6cd8x123-nlc-1120", transcript).execute();
					System.out.println(classification);
					resultOutput.add(classification.toString());
					obj = ( JSONObject )parser.parse( classification.toString() );
					JSONArray classes = ( JSONArray )obj.get( "classes" );
					for( int j = 0; j < classes.size(); j ++ ){
			            JSONObject m_class = ( JSONObject )classes.get( j );
			            Double m_confidence = ( Double )m_class.get( "confidence" );
			            String m_class_name = ( String )m_class.get( "class_name" );

			            out = m_class_name + "\t" + m_confidence;  // 結果をタブでつないで出力する
			            System.out.println( out );

			            resultOutput.add(m_confidence.toString());
			            resultOutput.add(m_class_name);
					}
		          }

		        }
			} catch (ParseException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}

	          //TextToSpeech Tts = new TextToSpeech();




	        req.setAttribute("resultOutput", resultOutput);





	        RequestDispatcher rd = req.getRequestDispatcher("./speech2text.jsp");
	        rd.forward(req, res);

	}

}
