/**
SAL - Simple Ajax Lib. 23-Sep-2005
by Nigel Liefrink
Email: leafrink@hotmail.com
*/

var debug = false;
/**
Browser Compatability function.
Returns the correct XMLHttpRequest depending on the current browser.
*/
function GetXmlHttp() {	
	var xmlhttp = false;
	if (window.XMLHttpRequest)
	{
		xmlhttp = new XMLHttpRequest();
  }
	else if (window.ActiveXObject)// code for IE
	{
		try 
		{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e) 
		{
			try 
			{
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (E) {
				xmlhttp=false;
			}
		}
	}
	return xmlhttp;
}


/**
<summary>
Gets the response stream from the passed url, and then calls the callbackFuntion passing the response and the div_ids.
</summary>
<param name="url">The url to make the request to get the response data.</param>
<param name="callbackFunction">The function to call after the response has been recieved. the response <b>must</b> always be the first argument to the function.</param>
<param name="params"> (optional) Any other parameters you want to pass to the functions. (Note: only constants/strings/globals can be passed as params, most variables will be out of scope.) </param>
</summary>
<example>
	<code>
PassAjaxResponseToFunction('?getsomehtml=1', 'FunctionToHandleTheResponse', "\'div1\',\'div2\',\'div3\'');

function FunctionToHandleTheResponse(response, d1, d2, d3){
	var data = response.split(';');
	document.getElementById(d1).innerHTML = data[0];
	document.getElementById(d2).innerHTML = data[1];
	document.getElementById(d3).innerHTML = data[2];
}
	</code>
</example>
*/
function PassAjaxResponseToFunction(url, callbackFunction, params)
{		
  var xmlhttp = new GetXmlHttp();
  //now we got the XmlHttpRequest object, send the request.
  if (xmlhttp)
  {
    xmlhttp.onreadystatechange = function () 
                                {
	                                if (xmlhttp && xmlhttp.readyState==4)
	                                {//we got something back..
		                                if (xmlhttp.status==200)
		                                {
			                                var response = xmlhttp.responseText;
			                                var functionToCall = callbackFunction+'(response,'+params+')';
			                                if(debug){
				                                alert(response);
				                                alert (functionToCall);
			                                }
			                                eval(functionToCall);
		                                } else if(debug){
			                                document.write(xmlhttp.responseText);
		                                }
	                                }
                                }
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
  }
}


/**
///<summary>
///Sets the innerHTML property of obj_id with the response from the passed url./
///</summary>
///<param name="url">The url to make the request to get the response data.</param>
///<param name="obj_id">The object or the id of the object to set the innerHTML for.</param>
*/
function AjaxResponse(url, obj_id)
{		
  var xmlhttp = new GetXmlHttp();
  //now we got the XmlHttpRequest object, send the request.
  if (xmlhttp)
  {
    xmlhttp.onreadystatechange = function () 
                                {
	                                document.getElementById(obj_id).innerHTML="<table cellspacing='0' cellpadding='0' style='border-collapse: collapse' border=1 bordercolor='#F0F0F0' bgcolor='#F7F7F7' width='98%' height='90'><tr><td class='DarkText' align='center'><img src='images/loading.gif'> <b>Đang tải dữ liệu...</b></td></tr></table>";
									if (xmlhttp && xmlhttp.readyState==4)
	                                {//we got something back..
		                                if (xmlhttp.status==200)
		                                {
			                                if(debug){
				                                alert(xmlhttp.responseText);
			                                }
			                                if(typeof obj_id == 'object'){
				                                obj_id.innerHTML = xmlhttp.responseText;
			                                } else {
				                                document.getElementById(obj_id).innerHTML = xmlhttp.responseText;
			                                }
		                                } else if(debug){
			                                document.Write(xmlhttp.responseText);
		                                }
	                                }
                                }
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
  }
}



function SetActivePublic(url)
{		
  var xmlhttp = new GetXmlHttp();
  //now we got the XmlHttpRequest object, send the request.
  if (xmlhttp)
  {
    xmlhttp.onreadystatechange = function () 
                                {
									if (xmlhttp && xmlhttp.readyState==4)
	                                {//we got something back..
		                                if (xmlhttp.status==200)
		                                {
			                                if(debug){
				                                alert(xmlhttp.responseText);
			                                }
											else {
				                                alert(xmlhttp.responseText);
			                                }
		                                } else if(debug){
			                                alert(xmlhttp.responseText);
		                                }
	                                }
                                }
	var d = new Date();
	var t = d.getTime();
	url = url + "&Time=" + t;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
  }
}



function RefreshLastestPublic()
{		
  var xmlhttp = new GetXmlHttp();
  //now we got the XmlHttpRequest object, send the request.
  if (xmlhttp)
  {
    xmlhttp.onreadystatechange = function () 
                                {
									if (xmlhttp && xmlhttp.readyState==4)
	                                {//we got something back..
		                                if (xmlhttp.status==200)
		                                {
			                                if(debug){
				                                alert(xmlhttp.responseText);
			                                }
											else {
				                                alert(xmlhttp.responseText);
			                                }
		                                } else if(debug){
			                                alert(xmlhttp.responseText);
		                                }
	                                }
                                }
	var url ="IsAdmin.asp";
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
  }
}


function ShowLastestPublic(url, obj_id)
{
	var d2 = new Date();
	var t2 = d2.getTime();
	url = url + "?Time=" + t2;
	AjaxResponse(url, obj_id);
}




function DelConfirm()
{
	if( confirm('Bạn có thực sự muốn xóa không ?') )
		return true;
	else 
		return false;
}

function DeletePublic(url)
{		  
	if (DelConfirm())
	{
		var xmlhttp = new GetXmlHttp();
		//now we got the XmlHttpRequest object, send the request.
		if (xmlhttp)
		{
		xmlhttp.onreadystatechange = function () 
									{
										if (xmlhttp && xmlhttp.readyState==4)
										{//we got something back..
											if (xmlhttp.status==200)
											{
												if(debug){
													alert(xmlhttp.responseText);
												}
												else {
													alert(xmlhttp.responseText);
												}
											} else if(debug){
												alert(xmlhttp.responseText);
											}
										}
									}
		var d = new Date();
		var t = d.getTime();
		url = url + "&Time=" + t;
		xmlhttp.open("GET",url,true);
		xmlhttp.send(null);
		}
	}
}


function showWeather()
{
	window.open("http://www.thitruong24h.com.vn/thongtin?act=thoitiet","my_new_window","scrollbars=no, resizable=no, width=150, height=210");
}

function showGoldPrice()
{
	window.open("http://www.thitruong24h.com.vn/thongtin?act=giavang","my_new_window","scrollbars=no, resizable=no, width=150, height=160");
}

function showMoneyRate()
{
	window.open("http://www.thitruong24h.com.vn/thongtin?act=tygia","my_new_window","scrollbars=no, resizable=no, width=150, height=275");
}


function showStock()
{		
	myWin = open("http://www.bsc.com.vn/OP/OP.htm", "displayWindow", "width=800,height=590,status=no,toolbar=no,menubar=no,top=0,left=0");
}

function showLPS()
{		
	myWin = open("LichPhatSong.asp?Channel=VTV3", "displayWindow", "width=500,height=600,scrollbars=yes,status=no,toolbar=no,menubar=no,top=0,left=0");
}

function showKQXS()
{		
	myWin = open("KQXoSo.asp?Channel=XSTT", "displayWindow", "width=500,height=400,scrollbars=yes,status=no,toolbar=no,menubar=no,top=0,left=0");
}

function open_win(url)
{
	window.open(url,"_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=600, height=400")
}