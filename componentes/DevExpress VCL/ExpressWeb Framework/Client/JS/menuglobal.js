/*
   ExpressWeb Framework by Developer Express
   ExpressWebMenus

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
var dxMenu = [];
dxMenu["Inf"] = new dx_Info();
dxMenu["Utl"] = new dx_Utils();
dxMenu["Mng"] = new dx_MenuManager();
dxMenu["Pos"] = dxMenu.Utl.CreatePosHelper();
dxMenu["Obj"] = dxMenu.Utl.CreateObjHelper();
dxMenu["Evt"] = new dx_EventManager();

if(dxMenu.Inf.ns4) {
	dxMenu.Mng.Initialize = function() {
		for(var i = 0; i < this.menus.length; i++) {
			this.menus[i].ItemInitialize();
		}
	}
	dxMenu.Mng.OnResize = function() {
		for(var i = 0; i < this.menus.length; i++) {
			this.menus[i].ItemClear();
		}
		this.HideAll();
		this.Initialize();
	}
	dx_MainMenu.prototype.ItemInitialize = function() {
		for(var i = 0; i < this.items.length; i++) {
			this.items[i].Initialize();
		}
	}
	dx_MainMenu.prototype.ItemClear = function() {
		for(var i = 0; i < this.items.length; i++) {
			this.items[i].Clear();
		}
	}
}

function CreateMainMenu() {
	return dxMenu.Mng.CreateMenu();
}
function SelectMenuItem(id) {
	dxMenu.Mng.SelectMenuItem(id);
}
function ShowContextMenu(id, e, x, y) {
	dxMenu.Mng.PopupMenu(id, e, x, y, true);
}
function HideContextMenu(id) {
	dxMenu.Mng.HideMenu(id);
}
function RaiseItemEvent(id, itemId) {
	__doPostBack(id, DoEventArg("item",itemId));
}

dxMenu.Evt.Attach("window.onresize", function() { dxMenu.Mng.OnResize(); } );
window.onresize = function() { dxMenu.Evt.Exec("window.onresize"); }

dxMenu.Evt.Attach("window.onload", function() { dxMenu.Mng.Initialize(); } );
window.onload = function() { dxMenu.Evt.Exec("window.onload"); }

dxMenu.Evt.Attach("window.document.onmousedown", function(e) { dxMenu.Mng.OnMouseDown(e); } );
window.document.onmousedown = function(e) { dxMenu.Evt.Exec("window.document.onmousedown",e); }

dxMenu.Evt.Attach("window.document.onmouseout", function(e) { dxMenu.Mng.OnMouseOut(e); } );
window.document.onmouseout = function(e) { dxMenu.Evt.Exec("window.document.onmouseout",e); }

window.onerror = function() { 
	return true;
};
