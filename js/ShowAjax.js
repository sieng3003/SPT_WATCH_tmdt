var xmlHttp


function key_search_List_doors(str)
{ //alert("ok");
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_List_doors
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_List_doors() 
{ 
	document.getElementById("showPlacedoors").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("showPlacedoors").innerHTML=xmlHttp.responseText 
	} 
}

function key_search_List_Granite(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_List_Granite
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_List_Granite() 
{ 
	document.getElementById("showPlaceGranite").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("showPlaceGranite").innerHTML=xmlHttp.responseText 
	} 
} 



function key_search_List_Product(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_List_Product
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_List_Product() 
{ 
	document.getElementById("showPlaceProduct").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("showPlaceProduct").innerHTML=xmlHttp.responseText 
	} 
} 



function GetXmlHttpObject()
{ 
var objXMLHttp=null
if (window.XMLHttpRequest)
{
objXMLHttp=new XMLHttpRequest()
}
else if (window.ActiveXObject)
{
objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP")
}
return objXMLHttp
}