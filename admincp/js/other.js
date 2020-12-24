//================================================
function setVisible(obj)
{
	obj = document.getElementById(obj);
	obj.style.visibility = (obj.style.visibility == 'visible') ? 'hidden' : 'visible';
	//var t=setTimeout("goUrl()",2000);
	
}
function goUrl()
{
	location.href="file:///C:/Documents%20and%20Settings/vb/Desktop/New%20Folder%20(2)/sugar-suite.html";
}
function setHidden(obj)
{
	obj = document.getElementById(obj);
	obj.style.visibility = (obj.style.visibility == 'hidden') ? 'visible' : 'hidden';
}
//================================================
function change_color(name,num)
{
	for (c = 0; c < num; c++)
	{
		name.cells[c].style.backgroundColor = '#EEEEEE';
	}

}
function delete_color(name,num)
{
	for (c = 0; c < num; c++)
	{
		name.cells[c].style.backgroundColor = '';
	}
}



//=============================================

function changeState(obj)
{
	if(obj.checked == false) obj.checked = true;
	else obj.checked = false;
	//alert('0');
}
var mainChecked = false;
var totalChecked = 0;
var lastChecked;
var selectStart;

<!--
function checkAll(field)
{
    var obj=document.getElementsByName("row[]");
	if(field.allbox.checked==true)
	{
		for(i=0;i<obj.length;i++)
			obj[i].checked=true;
	}
	else
	{
		for(i=0;i<obj.length;i++)
			obj[i].checked=false;
	}
	
}


//-->

function checkMain(form, name) {
    //alert('0');
	mainChecked = true;
	for (var element = 0; element < form.elements.length && mainChecked == true; element++) {
		var checkbox = document.form.elements[element];
		if (checkbox.name != 'allbox' && (!name || (name && checkbox.name.substr(0, name.length) == name)) && checkbox.type == 'checkbox' && checkbox.checked == false) {
			mainChecked = false;
		}
	}
	form.allbox.checked = mainChecked;
}

var marked_row = new Array;
function PMA_markRowsInit() {
	var rows = document.getElementsByTagName('tr');
	for ( var i = 0; i < rows.length; i++ ) {
		if ( 'odd' != rows[i].className && 'light' != rows[i].className ) {
		    continue;
		}
	    if ( navigator.appName == 'Microsoft Internet Explorer' ) {
			rows[i].onmouseover = function() {
			    this.className += ' hover';
			}
			rows[i].onmouseout = function() {
			    this.className = this.className.replace( ' hover', '' );
			}
	    }
		rows[i].onmousedown = function() {
		    var unique_id;
            var checkbox;

            checkbox = this.getElementsByTagName( 'input' )[0];
            if ( checkbox && checkbox.type == 'checkbox' ) {
                unique_id = checkbox.name + checkbox.value;
            } else if ( this.id.length > 0 ) {
                unique_id = this.id;
            } else {
		        return;
		    }

            if ( typeof(marked_row[unique_id]) == 'undefined' || !marked_row[unique_id] ) {
                marked_row[unique_id] = true;
            } else {
                marked_row[unique_id] = false;
            }

            if ( marked_row[unique_id] ) {
			    this.className += ' marked';
            } else {
			    this.className = this.className.replace(' marked', '');
            }

            if ( checkbox && checkbox.disabled == false ) {
                checkbox.checked = marked_row[unique_id];
            }
		}

		var checkbox = rows[i].getElementsByTagName('input')[0];
		if ( checkbox ) {
		    checkbox.onclick = function() {
		        this.checked = ! this.checked;
		    }
	    }
	}
}
window.onload=PMA_markRowsInit;