/*
   ExpressWeb Framework by Developer Express
   ExpressWebPageModule

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
var dxModule = [];
dxModule["Inf"] = new dx_Info();
dxModule["Utl"] = new dx_Utils();
dxModule["Page"] = new dx_Page();
dxModule["Obj"] = dxModule.Utl.CreateObjHelper();
dxModule["Pos"] = dxModule.Utl.CreatePosHelper();
dxModule["Evt"] = new dx_EventManager();

// Class TabItem
function dx_TabItem(AName, ATabIndex, ATabStop)
{
  this.Name = AName;
  this.TabIndex = ATabIndex;
  this.TabStop = ATabStop;
}

// Class dx_Page
function dx_Page()
{
  this.Name = "";
  this.ScrollLeft = 0;
  this.ScrollTop = 0;
  this.ActiveControlName = "";
  this.GetPageForm = function() {
  	return eval("document." + this.Name);
  }
  this.FirstFocusedElementName = "";
  this.LastFocusedElementName = "";
  this.FocusedElementName = "";
  this.LockTabbing = false;
  this.UnableTabbing = true;
  
  this.tabitems = [];
  this.AddTabbingElement = function(AName, ATabIndex, ATabStop) {
  	this.tabitems[this.tabitems.length] = new dx_TabItem(AName, ATabIndex, ATabStop);
  }
  this.GetTabStop = function(name) {
        for(var i = 0; i < this.tabitems.length; i ++) {
            if (this.tabitems[i].Name == name) return this.tabitems[i].TabStop;
        }
        return true;
  }
  this.GetTabIndex = function(name) {
        for(var i = 0; i < this.tabitems.length; i ++) {
            if (this.tabitems[i].Name == name) return this.tabitems[i].TabIndex;
        }
        return -1;
  }
  this.GetElementNameByTabIndex = function(tabIndex) {
        for(var i = 0; i < this.tabitems.length; i ++) {
            if (this.tabitems[i].TabIndex == tabIndex) return this.tabitems[i].Name;
        }
        return "";
  }
  this.FocusElement = function(name) {
  	if(!Exists(name)) return;
  	element = dxModule.Obj.GetElementById(name);
  	if(Exists(element)) {
        	element.focus();
        	if(element.tagName == "INPUT" || element.tagName == "TEXTAREA") element.select();
        	this.FocusedElementName = name;
        }
  }
  this.FocusNext = function(evt) {
  	element = dxModule.Inf.GetSrcElement(evt);
  	if(!Exists(element)) return;
        var nextTabIndex = eval(this.GetTabIndex(element.name) + 1);
        focusElementName = this.GetElementNameByTabIndex(nextTabIndex);
        if(Exists(focusElementName)) this.FocusElement(focusElementName);
        else this.FocusElement(this.FirstFocusedElementName);
  }
  this.FocusPrev = function(evt) {
  	element = dxModule.Inf.GetSrcElement(evt);
  	if(!Exists(element)) return;
        var nextTabIndex = eval(this.GetTabIndex(element.name) - 1);
        focusElementName = this.GetElementNameByTabIndex(nextTabIndex);
        if(Exists(focusElementName)) this.FocusElement(focusElementName);
        else this.FocusElement(this.LastFocusedElementName);
  }
  this.OnFocus = function(evt) {
  	if(this.LockTabbing || this.UnableTabbing) return;
  	element = dxModule.Inf.GetSrcElement(evt);
  	if(!Exists(element)) return;
        if(!this.GetTabStop(element.name)) {
            if(dxModule.Inf.GetShiftState(evt)) this.FocusPrev(evt);
            else this.FocusNext(evt);
        }  	
  }
  this.OnMouseDown = function(evt) {
  	this.LockTabbing = true;
  }
  this.OnMouseUp = function(evt) {
  	this.LockTabbing = false;
  }
  this.Initialize = function() {
        var newScrollPos = dxModule.Pos.GetWindowScroll();
        if(this.ScrollLeft != 0) newScrollPos.x = this.ScrollLeft;
        if(this.ScrollTop != 0) newScrollPos.y = this.ScrollTop;
   	dxModule.Pos.SetWindowScroll(newScrollPos.x, newScrollPos.y);
  	this.FocusElement(this.ActiveControlName);
  	for(var i = 0; i < this.tabitems.length; i ++) {
		this.UnableTabbing = this.UnableTabbing && !this.tabitems[i].TabStop;
	}
	if(!dxModule.Inf.ie) this.UnableTabbing = true; //TODO
	if(!this.UnableTabbing) {
	  	this.FirstFocusedElementName = this.GetElementNameByTabIndex(1);
	  	var lastTabIndex = 0;
	        for(var i = 0; i < this.tabitems.length; i ++) {
	            if (this.tabitems[i].TabIndex > lastTabIndex) lastTabIndex = this.tabitems[i].TabIndex;
	        }
	  	this.LastFocusedElementName = this.GetElementNameByTabIndex(lastTabIndex);
	
	  	dxModule.Evt.Attach("window.document.onmousedown", function(e) { dxModule.Page.OnMouseDown(e); } );
		window.document.onmousedown = function(e) { dxModule.Evt.Exec("window.document.onmousedown", e); }
	  	dxModule.Evt.Attach("window.document.onmouseup", function(e) { dxModule.Page.OnMouseUp(e); } );
		window.document.onmouseup = function(e) { dxModule.Evt.Exec("window.document.onmouseup", e); }
	}
  }
  this.Finalize = function() {
	AllowPostBack = true;
  }
}

dxModule.Evt.Attach("window.onload", function() { dxModule.Page.Initialize(); } );
window.onload = function() { dxModule.Evt.Exec("window.onload"); }

dxModule.Evt.Attach("window.onunload", function() { dxModule.Page.Finalize(); } );
window.onunload = function() { dxModule.Evt.Exec("window.onunload"); }
