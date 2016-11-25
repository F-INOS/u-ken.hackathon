<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="booklist.bean.Book" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book List</title>
  </head>

  <body>
 <%--    <h1>蔵書一覧</h1>

    <table border="1">
      <thead>
        <tr><th>タイトル</th><th>種類</th><th>価格</th><th>ISBN</th></tr>
      </thead>
      <tbody>
        <%
          ArrayList<Book> bookList = (ArrayList<Book>)request.getAttribute("bookList");
          for (int i = 0; i < bookList.size(); i++) {
            Book book = bookList.get(i);
            out.println("<tr>");
            out.println("<td>" + book.getTitle() + "</td>");
            out.println("<td>" + book.getType() + "</td>");
            out.println("<td>" + book.getPrice() + "</td>");
            out.println("<td>" + book.getIsbn() + "</td>");
            out.println("</tr>");
          }
        %>
      </tbody>
    </table> --%>

<!--         <audio controls preload="auto">
      <source src="http://hakuhin.jp/download/js/audio/sample_00.m4a" type="audio/mp4">
      <source src="http://hakuhin.jp/download/js/audio/sample_00.mp3" type="audio/mpeg">
      <source src="http://hakuhin.jp/download/js/audio/sample_00.ogg" type="audio/ogg">
      <source src="http://hakuhin.jp/download/js/audio/sample_00.wav" type="audio/wav">
    </audio> -->

        <button id="StartRecording">スタート</button>
        <button id="StopRecording">ストップ</button>
        <button id="StartPlaying">再生</button>
        <button id="GenerateWAV">WAVの生成</button>
        <button id="DownloadWAV">WAVのダウンロード</button>
        <button id="Upload">Upload</button>



        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
        <script>
    window.Recorder = function(audioContext, bufferSize){
        var o = this;
        o.audioContext = audioContext;
        o.bufferSize = bufferSize || 4096;
    }

    Recorder.prototype = {
        audioContext : '',
        bufferSize : '',
        audioBufferArray : [],
        stream : '',
        recording : function(stream){
            var o = this;
            o.stream = stream;
            var mediaStreamSource =
                o.audioContext.createMediaStreamSource(stream);
            var scriptProcessor =
                o.audioContext.createScriptProcessor(o.bufferSize, 1, 1);
            mediaStreamSource.connect(scriptProcessor);
            o.audioBufferArray = [];
            scriptProcessor.onaudioprocess = function(event){
                var channel = event.inputBuffer.getChannelData(0);
                var buffer = new Float32Array(o.bufferSize);
                for (var i = 0; i < o.bufferSize; i++) {
                    buffer[i] = channel[i];
                }
                o.audioBufferArray.push(buffer);
            }
            //この接続でonaudioprocessが起動
            scriptProcessor.connect(o.audioContext.destination);
            o.scriptProcessor = scriptProcessor;
        },
        recStart : function(){
            var o = this;
            if(o.stream){
                o.recording(o.stream);
            }
            else{
                navigator.getUserMedia(
                    {video: false, audio: true},
                    function(stream){o.recording(stream)},
                    function(err){
                        console.log(err.name ? err.name : err);
                    }
                );
            }
        },
        recStop : function(){
            var o = this;
            o.scriptProcessor.disconnect();
            if(o.stream){
                o.stream.stop();
                o.stream = null;
            }
        },
        getAudioBufferArray : function(){
            var o = this;
            return o.audioBufferArray
        },
        getAudioBuffer : function(){
            var o = this;
            var buffer = o.audioContext.createBuffer(
                1,
                o.audioBufferArray.length * o.bufferSize,
                o.audioContext.sampleRate
            );
            var channel = buffer.getChannelData(0);
            for (var i = 0; i < o.audioBufferArray.length; i++) {
                for (var j = 0; j < o.bufferSize; j++) {
                    channel[i * o.bufferSize + j] = o.audioBufferArray[i][j];
                }
            }
            return buffer;
        }
    }

    window.exportWAV = function(audioData, sampleRate) {
        var encodeWAV = function(samples, sampleRate) {
            var buffer = new ArrayBuffer(44 + samples.length * 2);
            var view = new DataView(buffer);
            var writeString = function(view, offset, string) {
                for (var i = 0; i < string.length; i++){
                    view.setUint8(offset + i, string.charCodeAt(i));
                }
            };
            var floatTo16BitPCM = function(output, offset, input) {
                for (var i = 0; i < input.length; i++, offset += 2){
                    var s = Math.max(-1, Math.min(1, input[i]));
                    output.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
                }
            };
            writeString(view, 0, 'RIFF');  // RIFFヘッダ
            view.setUint32(4, 32 + samples.length * 2, true); // これ以降のファイルサイズ
            writeString(view, 8, 'WAVE'); // WAVEヘッダ
            writeString(view, 12, 'fmt '); // fmtチャンク
            view.setUint32(16, 16, true); // fmtチャンクのバイト数
            view.setUint16(20, 1, true); // フォーマットID
            view.setUint16(22, 1, true); // チャンネル数
            view.setUint32(24, sampleRate, true); // サンプリングレート
            view.setUint32(28, sampleRate * 2, true); // データ速度
            view.setUint16(32, 2, true); // ブロックサイズ
            view.setUint16(34, 16, true); // サンプルあたりのビット数
            writeString(view, 36, 'data'); // dataチャンク
            view.setUint32(40, samples.length * 2, true); // 波形データのバイト数
            floatTo16BitPCM(view, 44, samples); // 波形データ
            return view;
        };
        var mergeBuffers = function(audioData) {
            var sampleLength = 0;
            for (var i = 0; i < audioData.length; i++) {
              sampleLength += audioData[i].length;
            }
            var samples = new Float32Array(sampleLength);
            var sampleIdx = 0;
            for (var i = 0; i < audioData.length; i++) {
              for (var j = 0; j < audioData[i].length; j++) {
                samples[sampleIdx] = audioData[i][j];
                sampleIdx++;
              }
            }
            return samples;
        };
        var dataview = encodeWAV(mergeBuffers(audioData), sampleRate);
        var audioBlob = new Blob([dataview], { type: 'audio/wav' });
        return audioBlob;
    };

    navigator.getUserMedia =
        navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia ||
        navigator.msGetUserMedia;
    window.URL =
        window.URL ||
        window.webkitURL ||
        window.mozURL ||
        window.msURL;
    window.AudioContext =
        window.AudioContext||
        window.webkitAudioContext;


//以下、アプリのためのロジック

var audioContext = new AudioContext();
var recorder = new Recorder(audioContext);
var localurl = null;

function startRecording() {
recorder.recStart(); // 録音開始
};

function stopRecording() {
console.log('録音停止');
recorder.recStop(); // 録音停止
recorder.getAudioBufferArray(); //音声配列データの取得
recorder.getAudioBuffer(); //AudioBuffer の取得
generateWAV();
alert(localurl);
};

function startPlaying() {
	console.log('再生');
    var src = audioContext.createBufferSource();
    src.buffer = recorder.getAudioBuffer();
    src.connect(audioContext.destination);
    src.start()
};

function generateWAV() {
	console.log('WAV生成');
    var blob = exportWAV(recorder.getAudioBufferArray(), audioContext.sampleRate)
    localurl = URL.createObjectURL(blob);
    document.getElementById("hidUrl").value = localurl;
    console.log(localurl);
    alert(document.getElementById("hidUrl").value);
};

//querySelectorでは、#をつけることで、idがbtnStartMonitoringの要素を取得している(つまり、Startボタン)
document.querySelector("#StartRecording").onclick = startRecording; // Wire up start button
document.querySelector("#StopRecording").onclick = stopRecording; // Wire up stop button
document.querySelector("#StartPlaying").onclick = startPlaying; //
document.querySelector("#GenerateWAV").onclick = generateWAV; //
document.querySelector("#DownloadWAV").onclick = function() {
    console.log(localurl);
    return location.href = localurl;
};

document.querySelector("#Upload").onclick = function() {
    console.log('Upload');
    return location.href = 'STTで音声認識Javascriptソースが動作するURLを記述';
};

</script>




<form name="frm" method="post" enctype="multipart/form-data" action="./speech2text">
<input type="file" name="audio_file"/>
<input type="hidden" id="hidUrl">
<input type="submit" value="Submit"/>
</form>



  </body>
</html>