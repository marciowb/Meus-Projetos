/*
   ExpressWeb Framework by Developer Express
   ExpressWebDBLookup

   Copyright (c) 2000-2004 Developer Express Inc.
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and
   International Copyright Laws. Unauthorized reproduction,
   reverse-engineering, and distribution of all or any portion of
   the code contained in this file is strictly prohibited and may
   result in severe civil and criminal penalties and will be
   prosecuted to the maximum extent possible under the law.
*/

// globals
var dxLookup = [];
dxLookup["Inf"] = new dx_Info();
dxLookup["Utl"] = new dx_Utils();
dxLookup["Mng"] = new dx_LookupManager();
dxLookup["Pos"] = dxLookup.Utl.CreatePosHelper();
dxLookup["Obj"] = dxLookup.Utl.CreateObjHelper();
dxLookup["Evt"] = new dx_EventManager();

// Class Lookup
function dx_Lookup()
{
  this.Name = "";
  this.Dropped = false;
  this.BackColor = "window";
  this.ForeColor = "windowtext";
  this.SelectedBackColor = "highlight";
  this.SelectedForeColor = "highlighttext";
// Events
  this.OnChange = null;
// Server events
  this.AssignOnChange = true;

  this.GetMainElement = function() {
  	return dxLookup.Obj.GetElementById(this.Name);
  }
  this.GetLookupElement = function() {
  	return dxLookup.Obj.GetElementById(this.Name + "Lookup");
  }
  this.GetLookupEditorElement = function() {
  	return dxLookup.Obj.GetElementById(this.Name + "Editor");
  }
  this.GetLookupKeyValueElement = function() {
  	return dxLookup.Obj.GetElementById(this.Name + "KeyValue");
  }
  this.Show = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
  		dxLookup.Obj.SetElementVisibility(lookup, true);
  		this.ShowCursor();
  		this.SetScroll();
  		this.Dropped = true;
  	}
  }
  this.Hide = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
		this.HideCursor();
  		dxLookup.Obj.SetElementVisibility(lookup, false);
  		this.Dropped = false;
  	}
  }
  this.Toggle = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
		if(dxLookup.Obj.IsElementVisible(lookup)) this.Hide();
		else this.Show();
	}
  }
  this.ShowCursor = function () {
  	this.SetCursor(this.SelectedBackColor, this.SelectedForeColor);
  }
  this.HideCursor = function () {
  	this.SetCursor(this.BackColor, this.ForeColor);
  }
  this.SetCursor = function (bgColor, textColor) {
	var key = this.GetLookupKeyValueElement();
	if( Exists(key) ) {
		var focusedRow = dxLookup.Obj.GetElementById(this.Name + key.value);
		if( Exists(focusedRow) ) {
			if(focusedRow.tagName == "TR") {
				this.SetBgColor(focusedRow, bgColor);
				this.SetColor(focusedRow, textColor);
			}
		}
	}
  }
  this.SetColor = function (aNode, aColor) {
        for(var i = 0; i < aNode.childNodes.length; i ++) {
                if(aNode.childNodes[i].tagName == "INPUT" && aNode.childNodes[i].tagName == "SELECT") continue;
                aNode.style.color = aColor;
                this.SetColor(aNode.childNodes[i], aColor);
        }
  }
  this.SetBgColor = function (aNode, aColor) {
        for(var i = 0; i < aNode.childNodes.length; i ++)
        {
                if(aNode.childNodes[i].tagName == "INPUT" && aNode.childNodes[i].tagName == "SELECT") continue;
                aNode.style.backgroundColor = aColor;
                this.SetBgColor(aNode.childNodes[i], aColor);
        }
  }
  this.SetScroll = function() {
	var key = this.GetLookupKeyValueElement();
	if( Exists(key) ) {
		var focusedRow = dxLookup.Obj.GetElementById(this.Name + key.value);
		var lookupTable = dxLookup.Obj.GetElementById(this.Name + "LookupTable");
		if( Exists(focusedRow) && Exists(lookupTable) ) {
        		lookupTable.scrollTop = focusedRow.offsetTop;
        	}
	}
  }
  this.SetItem = function (AKeyValue){
	this.HideCursor();	
	var editor = this.GetLookupEditorElement();
	if( Exists(editor) ) {
		var listCell = dxLookup.Obj.GetElementById(this.Name + AKeyValue + 'ListCell');
		if( Exists(listCell) ) {
			if(dxLookup.Inf.ie) editor.value = listCell.innerText;
			else {
				if(listCell.innerHTML.indexOf("<img") == -1) editor.value = listCell.innerHTML;
				else editor.value = "";
			}
		}
	}
	var key = this.GetLookupKeyValueElement();
	if( Exists(key) ) key.value = AKeyValue;
	this.ShowCursor();
	window.setTimeout("dxLookup.Mng.HideLookup('" + this.Name + "');", 100);
  }  
  this.SelectItem = function (AKeyValue){
  	this.SetItem(AKeyValue);
  	this.DoChange();
  }  
  this.DoChange = function (){
        if(this.OnChange) {
        	this.OnChange(this);
	}
       	if(this.AssignOnChange) {
		__doPostBack(this.Name, "CHANGE");
        }
  }  
}

// Class dx_LookupNS4 
function dx_LookupNS4()
{
  this.inherit = dx_Lookup;
  this.inherit();

  this.GetLookupTableElement = function() {
  	return dxLookup.Obj.GetElementById(this.Name + "LookupTable")	
  }
  this.Show = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
                var posImg = dxLookup.Obj.GetElementById(this.Name + "PosImage");
                if( Exists(posImg) ) {
                        lookup.left = posImg.x;
                        lookup.top = posImg.y;
                }
                dxLookup.Obj.SetElementVisibility(lookup, true);
		var lookupTable = this.GetLookupTableElement();
		if( Exists(lookupTable) ) {
	                var LTImg = dxLookup.Obj.GetElementById(this.Name + "TableLTImage");
	                var RBImg = dxLookup.Obj.GetElementById(this.Name + "TableRBImage");	                
                	if( Exists(LTImg) && Exists(RBImg) )
                	{
				lookupTable.pageX = lookup.pageX + LTImg.x;
				lookupTable.pageY = lookup.pageY + LTImg.y;				
				lookupTable.width = RBImg.x - LTImg.x;
				lookupTable.height = RBImg.y - LTImg.y - 1;				
				lookupTable.clip.top = 0; 								
				lookupTable.clip.left = 0; 
				lookupTable.clip.width = RBImg.x - LTImg.x; 								
				lookupTable.clip.height = RBImg.y - LTImg.y - 1; 

                		dxLookup.Obj.SetElementVisibility(lookupTable, true);
			}
        	}
  	}
  }
  this.Hide = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
  		dxLookup.Obj.SetElementVisibility(lookup, false);
  		lookupTable = this.GetLookupTableElement();
  		if( Exists(lookupTable) ) dxLookup.Obj.SetElementVisibility(lookupTable, false);
  		this.Dropped = false;
  	}
  }
  this.ScrollUp = function () {
	var lookupTable = this.GetLookupTableElement();
	if( Exists(lookupTable) ) {
        	var height = lookupTable.clip.height;         	
        	var scrollOffset = height - 20;
        	if(height > lookupTable.clip.top) scrollOffset = lookupTable.clip.top; 
        	if(scrollOffset > 0) {
			lookupTable.clip.top -= scrollOffset; 
			lookupTable.pageY += scrollOffset; 		
			lookupTable.clip.height = height;
		}
        }
  }
  this.ScrollDown = function () {
	var lookupTable = this.GetLookupTableElement();
	if( Exists(lookupTable) ) {
        	var height = lookupTable.clip.height; 
        	var scrollOffset = height - 20;
        	if(lookupTable.clip.top + height > lookupTable.document.height - lookupTable.clip.height) 
        		scrollOffset = lookupTable.document.height - lookupTable.clip.height - lookupTable.clip.top; 
        	if(scrollOffset > 0) {
			lookupTable.clip.top += scrollOffset; 
			lookupTable.pageY -= scrollOffset; 		
			lookupTable.clip.height = height;
		}
        }
  }
  this.SetItem = function (AKeyValue, AListValue) {
	var editor = this.GetLookupEditorElement();
	if( Exists(editor) ) editor.value = AListValue;
	var key = this.GetLookupKeyValueElement();
	if( Exists(key) ) key.value = AKeyValue;		
	window.setTimeout("dxLookup.Mng.HideLookup('" + this.Name + "');", 100);
  }
}

function dx_LookupOpera()
{
  this.inherit = dx_Lookup;
  this.inherit();

  this.Show = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
  		dxLookup.Obj.SetElementVisibility(lookup, true);
  		this.Dropped = true;
  	}
  }
  this.Hide = function () {
  	var lookup = this.GetLookupElement();
  	if( Exists(lookup) ) {
  		dxLookup.Obj.SetElementVisibility(lookup, false);
  		this.Dropped = false;
  	}
  }
  this.SetItem = function (AKeyValue, AListValue) {
	var editor = this.GetLookupEditorElement();
	if( Exists(editor) ) editor.value = AListValue;
	var key = this.GetLookupKeyValueElement();
	if( Exists(key) ) key.value = AKeyValue;
        this.Hide();
  }
}

// Class LookupManager
function dx_LookupManager()
{
  this.lookups = [];

  this.CreateLookup = function() { 
  	var lookup = dxLookup.Inf.ns4 ? new dx_LookupNS4() : dxLookup.Inf.op ? new dx_LookupOpera() : new dx_Lookup();
  	this.lookups.Add(lookup);
  	return lookup; 
  }
  this.GetLookup = function(AName) {
	for(var i = 0; i < this.lookups.length; i++)
		if(AName == this.lookups[i].Name) return this.lookups[i];
	return null;
  }
  this.HideLookup = function(AName) {
  	var lookup = this.GetLookup(AName);
  	if( Exists(lookup) ) lookup.Hide();
  }
  this.OnMouseDown = function(e) {
	for(var i = 0; i < this.lookups.length; i++) {
		if( !Exists(dxLookup.Obj.GetParentById(dxLookup.Inf.GetSrcElement(e), this.lookups[i].Name))) 
			this.lookups[i].Hide();
	}
  }
  this.OnResize = function() {
	for(var i = 0; i < this.lookups.length; i++) this.lookups[i].Hide();
  }
}

function CreateLookup() {
	return dxLookup.Mng.CreateLookup();
}
function LookupButtonClick(name) {
	var lookup = dxLookup.Mng.GetLookup(name);
	if( Exists(lookup) ) lookup.Toggle();		
}
function SelectLookupItem(name, AKeyValue, AListValue) {
	var lookup = dxLookup.Mng.GetLookup(name);
	if( Exists(lookup) ) lookup.SelectItem(AKeyValue, AListValue);
}
function SetLookupItem(name, AKeyValue, AListValue) {
	var lookup = dxLookup.Mng.GetLookup(name);
	if( Exists(lookup) ) lookup.SetItem(AKeyValue, AListValue);
}
function LookupScrollUp(name) {
	var lookup = dxLookup.Mng.GetLookup(name);
	if( Exists(lookup) ) lookup.ScrollUp();
}
function LookupScrollDown(name) {
	var lookup = dxLookup.Mng.GetLookup(name);
	if( Exists(lookup) ) lookup.ScrollDown();
}

dxLookup.Evt.Attach("window.onresize", function() { dxLookup.Mng.OnResize(); } );
window.onresize = function() { dxLookup.Evt.Exec("window.onresize"); }

dxLookup.Evt.Attach("window.document.onmousedown", function(e) { dxLookup.Mng.OnMouseDown(e); } );
window.document.onmousedown = function(e) { dxLookup.Evt.Exec("window.document.onmousedown", e); }
