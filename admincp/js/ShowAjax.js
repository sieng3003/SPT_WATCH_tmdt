var xmlHttp

function key_ListDepartmentUse(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_ListDepartmentUse
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_ListDepartmentUse() 
{ 
	document.getElementById("showListRoomUse").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("showListRoomUse").innerHTML=xmlHttp.responseText 
	} 
} 



function key_ListDepartmentBuy(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_ListDepartmentBuy
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_ListDepartmentBuy() 
{ 
	document.getElementById("showListRoomBuy").innerHTML="<center><div class=DarkText width=150px><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("showListRoomBuy").innerHTML=xmlHttp.responseText 
	} 
} 


function key_search_box_ListComponent(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_key_search_ListComponent
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_key_search_ListComponent() 
{ 
	document.getElementById("PlaceShow_ListComponent").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("PlaceShow_ListComponent").innerHTML=xmlHttp.responseText 
	} 
}


function key_search_box_ListConfig(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_key_search_ListConfig
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_key_search_ListConfig() 
{ 
	document.getElementById("PlaceShow_ListConfig").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("PlaceShow_ListConfig").innerHTML=xmlHttp.responseText 
	} 
} 


function key_search_box_ListSoftware(str)
{ 
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
	{
		alert ("Browser does not support HTTP Request")
		return
	} 
	var url=str
	xmlHttp.onreadystatechange=stateChanged_key_search_ListSoftware
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
}

function stateChanged_key_search_ListSoftware() 
{ 
	document.getElementById("PlaceShow_ListSoftware").innerHTML="<center><div class=DarkText width=150px><br><br><img src='images/loading.gif'></div><center>";

	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
	document.getElementById("PlaceShow_ListSoftware").innerHTML=xmlHttp.responseText 
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