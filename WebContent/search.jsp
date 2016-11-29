<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>WhatSong</title>
		<style type="text/css">
		body {
			//background: linear-gradient(to right, rgb(215,235,35),rgb(245,245,245), rgb(185,245,185), rgb(35,65,215));
			    background:-webkit-gradient(radial, center center, 0, center center, 100, from(#ff0000), to(#0000ff));
			    background:-webkit-radial-gradient(center, circle cover, #ff0000 0%, #0000ff 100%);
			    background:-moz-radial-gradient(center, circle cover, #ff0000 0, #0000ff 100%);
			    background:-o-radial-gradient(center, circle cover, #ff0000 0, #0000ff 100%);
			    background:radial-gradient(#ffffff 0, #ffff00 100%);
		}
		input.textfield {
	    border:0;
		padding:10px;
		font-size:1.3em;
		font-family:Arial, sans-serif;
		color:#555;
		border:solid 1px #ccc;
		margin:0 0 20px;
		width:600px;

		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		border-radius: 3px;

		-moz-box-shadow: inset 0 0 4px rgba(0,0,0,0.2);
		-webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.2);
		box-shadow: inner 0 0 4px rgba(0, 0, 0, 0.2);

		-moz-box-shadow: inset 1px 4px 9px -6px rgba(0,0,0,0.5);
		-webkit-box-shadow: inset 1px 4px 9px -6px rgba(0, 0, 0, 0.5);
		box-shadow: inset 1px 4px 9px -6px rgba(0,0,0,0.5);

		-webkit-box-shadow: 0px 1px rgba(255, 255, 255, 0.5);
		-moz-box-shadow: 0px 1px rgba(255, 255, 255, 0.5);
		box-shadow: 0px 1px rgba(255, 255, 255, 0.5);
		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		border-radius: 3px;
    }
    input:focus {
    	border:solid 1px #EEA34A;
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

	.center{
	  text-align: center;
	}

	.megashadow {
		font: 170px "PublicGothicCircular";
		/*color: rgb(218,88,110);*/
		color: rgb(58,52,215);
		text-shadow:rgb(200,62,87) 1px 1px 0,
		rgb(200,62,87) 2px 2px 0,
		rgb(200,62,87) 3px 3px 0,
		rgb(200,62,87) 4px 4px 0,
		rgb(200,62,87) 5px 5px 0,
		rgb(200,62,87) 6px 6px 0,
		rgb(200,62,87) 7px 7px 0,
		rgb(200,62,87) 8px 8px 0,
		rgb(200,62,87) 9px 9px 0,
		rgb(200,62,87) 10px 10px 0,
		rgb(200,62,87) 11px 11px 0,
		rgb(200,62,87) 12px 12px 0,
		rgb(200,62,87) 13px 13px 0,
		rgb(200,62,87) 14px 14px 0,
		rgb(200,62,87) 15px 15px 0,
		rgb(200,62,87) 16px 16px 0,
		rgb(200,62,87) 17px 17px 0,
		rgb(200,62,87) 18px 18px 0,
		rgb(200,62,87) 19px 19px 0,
		rgb(200,62,87) 20px 20px 0,
		rgb(200,62,87) 21px 21px 0,
		rgb(200,62,87) 22px 22px 0,
		rgb(200,62,87) 23px 23px 0,
		rgb(200,62,87) 24px 24px 0,
		rgb(200,62,87) 25px 25px 0,
		rgb(200,62,87) 26px 26px 0,
		rgb(200,62,87) 27px 27px 0,
		rgb(200,62,87) 28px 28px 0,
		rgb(200,62,87) 29px 29px 0,
		rgb(200,62,87) 30px 30px 0,
		rgb(200,62,87) 31px 31px 0,
		rgb(200,62,87) 32px 32px 0,
		rgb(200,62,87) 33px 33px 0,
		rgb(200,62,87) 34px 34px 0,
		rgb(200,62,87) 35px 35px 0,
		rgb(200,62,87) 36px 36px 0,
		rgb(200,62,87) 37px 37px 0,
		rgb(200,62,87) 38px 38px 0,
		rgb(200,62,87) 39px 39px 0,
		rgb(200,62,87) 40px 40px 0,
		rgb(200,62,87) 41px 41px 0,
		rgb(200,62,87) 42px 42px 0,
		rgb(200,62,87) 43px 43px 0,
		rgb(200,62,87) 44px 44px 0,
		rgb(200,62,87) 45px 45px 0,
		rgb(200,62,87) 46px 46px 0,
		rgb(200,62,87) 47px 47px 0,
		rgb(200,62,87) 48px 48px 0,
		rgb(200,62,87) 49px 49px 0,
		rgb(200,62,87) 50px 50px 0,
		rgb(200,62,87) 51px 51px 0,
		rgb(200,62,87) 52px 52px 0,
		rgb(200,62,87) 53px 53px 0,
		rgb(200,62,87) 54px 54px 0,
		rgb(200,62,87) 55px 55px 0,
		rgb(200,62,87) 56px 56px 0,
		rgb(200,62,87) 57px 57px 0,
		rgb(200,62,87) 58px 58px 0,
		rgb(200,62,87) 59px 59px 0,
		rgb(200,62,87) 60px 60px 0,
		rgb(200,62,87) 61px 61px 0,
		rgb(200,62,87) 62px 62px 0,
		rgb(200,62,87) 63px 63px 0,
		rgb(200,62,87) 64px 64px 0,
		rgb(200,62,87) 65px 65px 0,
		rgb(200,62,87) 66px 66px 0,
		rgb(200,62,87) 67px 67px 0,
		rgb(200,62,87) 68px 68px 0,
		rgb(200,62,87) 50px 50px 0,
		rgb(200,62,87) 69px 69px 0,
		rgb(200,62,87) 70px 70px 0,
		rgb(200,62,87) 71px 71px 0,
		rgb(200,62,87) 72px 72px 0,
		rgb(200,62,87) 73px 73px 0,
		rgb(200,62,87) 74px 74px 0,
		rgb(200,62,87) 75px 75px 0,
		rgb(200,62,87) 76px 76px 0,
		rgb(200,62,87) 77px 77px 0,
		rgb(200,62,87) 78px 78px 0,
		rgb(200,62,87) 79px 79px 0,
		rgb(200,62,87) 80px 80px 0,
		rgb(200,62,87) 81px 81px 0,
		rgb(200,62,87) 82px 82px 0,
		rgb(200,62,87) 83px 83px 0,
		rgb(200,62,87) 84px 84px 0,
		rgb(200,62,87) 85px 85px 0,
		rgb(200,62,87) 86px 86px 0,
		rgb(200,62,87) 87px 87px 0,
		rgb(200,62,87) 88px 88px 0,
		rgb(200,62,87) 89px 89px 0,
		rgb(200,62,87) 90px 90px 0,
		rgb(200,62,87) 91px 91px 0,
		rgb(200,62,87) 92px 92px 0,
		rgb(200,62,87) 93px 93px 0,
		rgb(200,62,87) 94px 94px 0,
		rgb(200,62,87) 95px 95px 0,
		rgb(200,62,87) 96px 96px 0,
		rgb(200,62,87) 97px 97px 0,
		rgb(200,62,87) 98px 98px 0,
		rgb(200,62,87) 99px 99px 0,
		rgb(200,62,87) 100px 100px 0;
	}
	img {
		position: relative;
		top: 35px;
		cursor: pointer;
	}
	</style>
	<script type="text/javascript">
	var flag = false;
	function init() {
		document.getElementById("textfield").focus();
	}
	function mike() {
		//document.getElementById("textfield").focus();
		if (flag) {
			var mikeimg = document.getElementById("mikeimg");
			mikeimg.src = "Mikes.png";
			var textfield = document.getElementById("textfield");
			flag = false;
			var recognize = function(){
				var textfield = document.getElementById("textfield");
				textfield.value = "盛り上がる曲を教えて";
			}
			setTimeout(recognize, 2300);
		} else {
			var mikeimg = document.getElementById("mikeimg");
			mikeimg.src = "Mikesn.png";
			flag = true;
		}
	}
	</script>
	</head>
	<body onLoad="init()">
		<div class="center">
			<p class="megashadow">
				<span>WhatSong</span>
			</p>
			<!--
			<form name="frm" method="post" enctype="multipart/form-data" action="./Result">
			-->
			<form name="frm" method="post" action="./Result">
				<input type="input" name="word" class="textfield" id="textfield" />
				<input type="hidden" id="hidUrl">
				<input type="submit" value="検索" class="button"/>
				<img id="mikeimg" src="Mikes.png" onclick="mike()"/>
			</form>
			<span style="color:gray;font-family:Meiryo;">入力例）　盛り上がる曲を教えて</span>
		</div>
	</body>
</html>