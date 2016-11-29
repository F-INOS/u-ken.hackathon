<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset=UTF-8">
    <title>検索結果</title>
<style type="text/css">

/* @group reset */
* {margin: 0;padding: 0}

a { text-decoration : none}
ul, ol { list-style : none}
img { vertical-align : middle; max-width : 100% }

html, body {width:100%;height: auto;
min-height: 100%;
}
body {
  font-size : 13px;
  font-family: 'meiryo';
  background: linear-gradient(to right, rgb(135,235,235),rgb(245,145,245), rgb(235,235,135));

    /*background: linear-gradient(to right,rgb(255,255,255), rgb(245,245,245), rgb(250,250,250));
	background-color: #fff;
	background-image: linear-gradient(-45deg, rgba(0,0,0,.5) 25%, transparent 25%, transparent 50%, rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 75%, transparent 75%, transparent 100%), linear-gradient(45deg, rgba(0,0,0,.5) 25%, transparent 25%, transparent 50%,  rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 75%, transparent 75%, transparent 100%);
	background-size: 52px 52px;*/
);
}
ul.horizontal {
  padding-left : 0px;
  list-style   : none;
  margin-top   : 0px;
}
ul.horizontal li {
  float     : left;
  padding   : 8px;
  margin-top: 10px;
  margin-left: 10px;
  border    : 1px dotted silver;
  display   : block;
  min-width : 300px;
  cursor    : pointer;
  background-color :white;
}
ul.horizontal li:hover {
  background-color : rgb(222, 222, 242);
  border    : 1px solid gray;
}

h2 {margin-left:13px;padding-top:10px;font-size:2em;}

span.title {
	font-weight: bold;
	font-size: 2em;
}
span.artist {
	font-size: 1.2em;
	color: #888888;
}

#modal-overlay{
	z-index:1;
	display:none;
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:120%;
	background-color:rgba(30,30,30,0.75);
}

div#modal-content {
	display: none;
	z-index:2;
	position:fixed;
	background:white;
	width: 400px;
	height: 400px;
	background: linear-gradient(to right,rgb(255,255,255), rgb(245,245,245), rgb(250,250,250));
	background-color: #fff;
	background-image: linear-gradient(-45deg, rgba(0,0,0,.5) 25%, transparent 25%, transparent 50%, rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 75%, transparent 75%, transparent 100%), linear-gradient(45deg, rgba(0,0,0,.5) 25%, transparent 25%, transparent 50%,  rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 75%, transparent 75%, transparent 100%);
	background-size: 52px 52px;
}
	input.button {
		border:solid 1px #ccc;
		padding:11px 30px;
		margin:0 0 20px;
		font-family:Arial, sans-serif;
		font-size:1.2em;
		text-transform:uppercase;
		font-weight:bold;
		color:#333;
		cursor:pointer;

		background-image: -webkit-gradient(linear, left top, left bottom, from(#ddd), to(#aaa));
		background-image: -webkit-linear-gradient(top, #ddd, #aaa);
		background-image: -moz-linear-gradient(top, #ddd, #aaa);
		background-image: -ms-linear-gradient(top, #ddd, #aaa);
		background-image: -o-linear-gradient(top, #ddd, #aaa);
		background-image: linear-gradient(top, #ddd, #aaa);
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ddd', endColorstr='#aaa',GradientType=0 ); /* IE6-9 */

		-moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5);
		-webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5);
		box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5);

		-moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2);
		-webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.2);
		box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2);

		-moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
		-webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
		box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);

		-moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
		-webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
		box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		border-radius: 3px;

		text-shadow: 0px -1px 1px rgba(255, 255, 255, 0.8);
	}
	table {
	  background: white;
	  width : 400px;
	  border : 3px solid silver;
	}
	tr {
		padding-top: 20px;
		padding-bottom: 20px;
	}
	th, td {
		text-align: left;
		font-size : 16px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	th {
		color: #666;
		padding-left: 10px;
		font-weight: normal;
		font-size:1em;
	}
	td {
		color: blue;
		padding-left: 10px;
		font-weight: bold;
		font-size:1.5em;
	}
	td#reqno {
		color: #3344FF;
	}
	td#artist {
		color: #555555;
	}
	td#title {
		color: #222222;
	}
	.center{
	  text-align: center;
	}
</style>
	<script type="text/javascript">
	function jump(artist, title, reqno, startSong) {
	    var reqnoElem = document.getElementById("reqno");
		reqnoElem.innerHTML = reqno;
	    var artistElem = document.getElementById("artist");
	    artistElem.innerHTML = artist;
	    var titleElem = document.getElementById("title");
		titleElem.innerHTML = title;
	    var startElem = document.getElementById("start");
		startElem.innerHTML = startSong;

		centeringModalSyncer()
	    document.body.insertAdjacentHTML("beforeend",'<div id="modal-overlay"></div>');
	    var el = document.getElementById("modal-overlay");
	    el.style.display = "block";
	    el.style.transition = 'opacity 3s';
	    // fadeIn
	    el.style.opacity = '1';
	    var el2 = document.getElementById("modal-content");
	    el2.style.display = "block";
	    el2.style.transition = 'opacity 3s';
	    // fadeIn
	    el2.style.opacity = '1';
	}
	function centeringModalSyncer() {

		//画面(ウィンドウ)の幅、高さを取得
		var w = window.innerWidth;
		var h = window.innerHeight;

		// コンテンツ(#modal-content)の幅、高さを取得

	    var el2 = document.getElementById("modal-content");
		//var ch = getHeight(el2);
		//var ch = el2.clientHeight;
		//var cw = el2.clientWidth;
		var ch = 400;
		var cw = 400;
		//var cw = $( "#modal-content" ).outerWidth();
		//var ch = $( "#modal-content" ).outerHeight();

		//センタリングを実行する
		//$( "#modal-content" ).css( {"left": ((w - cw)/2) + "px","top": ((h - ch)/2) + "px"} ) ;
		el2.style.left = ((w - cw)/2) + "px";
		el2.style.top = ((h - ch)/2) + "px";

	}
	function getHeight(el) {
		  const styles = window.getComputedStyle(el);
		  const height = el.offsetHeight;
		  const borderTopWidth = parseFloat(styles.borderTopWidth);
		  const borderBottomWidth = parseFloat(styles.borderBottomWidth);
		  const paddingTop = parseFloat(styles.paddingTop);
		  const paddingBottom = parseFloat(styles.paddingBottom);
		  return height - borderBottomWidth - borderTopWidth - paddingTop - paddingBottom;
	}
	function closePopup() {
	    var el = document.getElementById("modal-overlay");
	    el.style.display = "none";
	    var el2 = document.getElementById("modal-content");
	    el2.style.display = "none";
	}
	function init() {
		var jsonstr = <%= (String)request.getAttribute("jsonstr") %>;
		var songs = eval(jsonstr);
		var songlistElem = document.getElementById("songlist");
		for (var i = 0; i < songs.length; i++) {
			var song = songs[i];
			var artist = song["singer"];
			var title = song["songTitle"];
			var reqNo = song["requestNo"];
			var startSong = song["startSong"];
			var liStr = "<li onclick=\"jump('" + artist + "', '" + title + "','" + reqNo +"','" + startSong + "')\">";
			liStr = liStr + "<span class=\"title\">" + title + "</span><br>";
			liStr = liStr + "<span class=\"artist\">" + artist + "</span>";
			liStr = liStr + "</li>";
			songlistElem.insertAdjacentHTML("beforeend", liStr);
		}
	}
	</script>
  </head>

  <body onLoad="init();">
		<h2><span style="color:#888888">検索結果：</span><%=request.getParameter("word") %></h2>
		<ul class="horizontal" id="songlist">
			<!--
			<li onclick="jump('宇多田ヒカル', 'Fantome', '1234567890');">
				<span class="title">Fantome</span><br>
				<span class="artist">宇多田ヒカル</span>
			</li>
			<li onclick="jump('RADWIMPS', '君の名は。', '1234567891');">
				<span class="title">君の名は。</span><br>
				<span class="artist">RADWIMPS</span>
			</li>
			<li onclick="jump('嵐', 'Are You Happy?', '1234567892');">
				<span class="title">Are You Happy?</span><br>
				<span class="artist">嵐</span>
			</li>
			<li onclick="jump('back number', 'シャンデリア', '1234567893');">
				<span class="title">シャンデリア</span><br>
				<span class="artist">back number</span>
			</li>
			<li onclick="jump('EXILE', 'EXTREME', '1234567894');">
				<span class="title">EXTREME</span><br>
				<span class="artist">EXILE</span>
			</li>
			-->
		</ul>

		<div id="modal-content" style="padding : 25px;">
			<table>
			<tr>
			<th>リクエスト No</th>
			<td id="reqno"></td>
			</tr>
			<tr>
			<th>アーティスト</th>
			<td id="artist"></td>
			</tr>
			<tr>
			<th>タイトル</th>
			<td id="title"></td>
			</tr>
			<tr>
			<th>歌い出し</th>
			<td id="start"></td>
			</tr>
			</table>
			<div class="center" style="padding-top: 50px;">
				<form>
					<input type="button" value="閉じる" class="button" onclick="closePopup()"/>
				</form>
			</div>
		</div>
  </body>
