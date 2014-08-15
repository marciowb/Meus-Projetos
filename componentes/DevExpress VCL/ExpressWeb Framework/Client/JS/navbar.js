/*
   ExpressWeb Framework by Developer Express
   ExpressWebNavBar

   Copyright (c) 2000-2004 Developer Express Inc.
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and
   International Copyright Laws. Unauthorized reproduction,
   reverse-engineering, and distribution of all or any portion of
   the code contained in this file is strictly prohibited and may
   result in severe civil and criminal penalties and will be
   prosecuted to the maximum extent possible under the law.
*/

/* class BarManager */
function dx_BarManager() 
{
	this.inf = new dx_Info();
	this.utl = new dx_Utils();
	this.obj = this.utl.CreateObjHelper();
	this.pos = this.utl.CreatePosHelper();
	this.bar = null;
		       
	this.Initialize = function() {
		var nodes = this.obj.GetTags(document, "table");
		nodes = this.obj.GetNodes(nodes, "className", "clsPartContainer");
		for(var i = 0; i < nodes.length; i++) {
			this.InitBar( nodes[i] );
		}
	}
	this.InitBar = function( table ) {
		if( Exists(table.barElement) ) { 
			return;
		}
		var bar = new dx_BarElement(table);
		table.barElement = bar;

		SetProperties(bar, eval(table.id));
		bar.setPartArray();
		
		var value = bar.loadState();
		if(value == null) value = bar.stateElem.value;
		var state = this.ParseUserData(value);
		bar.reorder(state);
	}
	this.ParseUserData = function( s ) {
		try {
			var tmpArray = s.split( ";" );
			var array = new Array(tmpArray.length - 1);
			for(var i = 0; i < array.length; i++) {
				array[i] = tmpArray[i].split( ":" );
			}
			return array;
		} catch(e) { return null; }
	}
	this.OnPartClick = function(e) {
		var el = this.inf.GetSrcElement(e);
		el = this.obj.GetParentById(el, "GroupItem");
		var bar = this.GetBar(el);
		var part = this.obj.GetParentByClass(el, "clsPart");
		
		if(Exists(bar) && part != null && el != null) {
			var action = "ItemClick";
			if( bar.containsAction(action) ) {
				var args = [["group", part.id], ["action", action], ["item", el.id]];
				__doPostBack(bar.table.id, DoEventArgs(args) );
			}
		}
	}
	this.OnMouseDown = function(e) {
		var evt = this.inf.GetEvent(e);
		if(evt.button != mbtn_left) return;

		var el = this.inf.GetSrcElement(evt);
		if( Exists(el.className) == false ) {
			el = this.obj.ParentOf(el);
		}
		this.bar = this.GetBar(el);
		var part = this.obj.GetParentByClass(el, "clsPart");
		var sc = new dx_StringComparer();

		if( sc.Equals(el.className,"clsHeadRight") ) {

			var collapsed = ( this.bar.isContentVisible(part) ? false : true );
			this.bar.showHidePart(part, collapsed);
		} else if( sc.Equals(el.className,"clsHead") ) {
			if( "img" == el.tagName.toLowerCase() ) {
				el.onDragStart = function() { OnDragStart(); }
			}
			this.bar.currentX = this.pos.GetEventX(evt, window);
			this.bar.currentY = this.pos.GetEventY(evt, window);
			this.bar.current = part;
			this.bar.showDragWindow();

			dxBar.Evt.Capture("window.document.onmousemove", function(e) { dxBar.Mng.OnMouseMove(e); } );
			window.document.onmousemove = function(e) { dxBar.Evt.Exec("window.document.onmousemove", e); return false;}

			dxBar.Evt.Capture("window.document.onscroll", function(e) { dxBar.Mng.OnMouseMove(e); } );
			window.document.onscroll = function(e) { dxBar.Evt.Exec("window.document.onscroll", e); return false;}

			dxBar.Evt.Capture("window.document.onmouseup", function() { dxBar.Mng.OnMouseUp(); } );
			window.document.onmouseup = function() { dxBar.Evt.Exec("window.document.onmouseup"); }

			dxBar.Evt.Capture("window.document.onselectstart", function() { } );
			window.document.onselectstart = function() { dxBar.Evt.Exec("window.document.onselectstart"); return false;}

        		if (this.inf.ns6) { evt.preventDefault(); }
		}
	}
	this.GetBar = function(el) {
		var par = this.obj.GetParentByClass(el, "clsPartContainer");
		if(null != par) return par.barElement;
	}
	this.OnMouseMove = function(e) {
		var evt = this.inf.GetEvent(e);
		if(evt.button != mbtn_left) {
			this.OnMouseUp(e);
			return;
		}

		var x = this.pos.GetEventX(evt, window);
		var y = this.pos.GetEventY(evt, window);
		var drag = this.bar.dragWindow.style;
		drag.left = parseInt(drag.left) + x - this.bar.currentX;
		drag.top = parseInt(drag.top) + y - this.bar.currentY;  
   		this.bar.currentX = x;
		this.bar.currentY = y;
		
		if(evt.clientY > window.document.body.clientHeight - 10) {
			window.scrollBy(0, 10);
		} else if(evt.clientY < 10) {
			window.scrollBy(evt.clientX, -10);
		}
	}
	this.OnMouseUp = function(e) {
		dxBar.Evt.Detach("window.document.onmousemove");
		dxBar.Evt.Detach("window.document.onscroll");
		dxBar.Evt.Detach("window.document.onmouseup");
		dxBar.Evt.Detach("window.document.onselectstart");
		if( Exists(this.bar.current) ) {
			this.bar.setDragPosition();
			this.bar.current = null;
			return true;
		} else { 
			return false;
		}
	}
}

/* class BarElement */
function dx_BarElement(table) 
{
	this.inf = new dx_Info();
	this.utl = new dx_Utils();
	this.obj = this.utl.CreateObjHelper();
	this.pos = this.utl.CreatePosHelper();

	this.table = table;
	this.dragWindow = this.obj.GetElementById("DragWindow");
	this.createUniqueID = function(s) { return this.table.id + s; }
	this.getPartParent = function() { return this.table.rows[0].cells[0]; }
	this.getBorderColor = function(part) { return ("open" == part.state) ? this.backColor : this.collapsedBorderColor; }
	this.getBackColor = function(part) { return ("open" == part.state) ? this.backColor : this.collapsedBackColor; }
	this.getForeColor = function(part) { return ("open" == part.state) ? this.foreColor : this.collapsedForeColor; }
	this.getLeftImage = function(part) { return ("open" == part.state) ? this.leftExpandedImage : this.leftCollapsedImage; }
	this.getRightImage = function(part) { return ("open" == part.state) ? this.rightExpandedImage : this.rightCollapsedImage; }
	this.formatFileName = function(name) { if("string" == typeof(name)) { name = name.replace( /[\W]/gi, "" ); return name; } }

	this.stateElem = this.obj.GetElementById( this.createUniqueID("State") );
	this.sContentID = this.formatFileName(window.location.href);

	this.getLayout = function() {
		if(Exists(this.layout) == false)
			this.layout = this.getChildById(this.table, "Layout");
		return this.layout;
	}
	this.getChildById = function(el, id) {
		return this.obj.GetChildById(el, id);
	}
	this.setPartArray = function() {
		var nodes = this.obj.GetTags(this.table, "table");
		this.parts = this.obj.GetNodes(nodes, "className", "clsPart");
	}
	this.hideDragWindow = function() {
		this.dragWindow.style.display = "none";
		this.dragWindow.style.height = "";
		this.dragWindow.style.top = "";
		this.dragWindow.style.left = "";
		this.dragWindow.style.width = "";
		this.dragWindow.zIndex = "";
	}
	this.showDragWindow = function() {
		var part = this.current;
		var drag = this.dragWindow;

		var height = part.offsetHeight;
		drag.style.height = height;
		var pt = this.pos.GetAbsolutePos(part);
		drag.style.top = pt.y + 3;
		drag.style.left = pt.x + 3;
		drag.style.width = part.offsetWidth;
		drag.style.zIndex = 1000;
		drag.style.display = "block";
	}
	this.containsAction = function(action) { 
		return (this.action.indexOf(action) != -1) ? true : false;
	}
	this.getState = function() {
		var state = "";
		try {		
			for(var i = 0; i < this.parts.length; i++) {
				var part = this.parts[i];
				var s = Exists( part.state ) ? part.state : "open";
				state += ( part.id + ":" + s + ";" );
			}
		} catch(e) {}
		return state;
	}
	this.loadState = function() {
		if(this.enableReadState) {
			var data = this.getLayout();	
			try { data.load(this.sContentID + this.table.id); }
			catch(e) { data = null; }
			if( Exists(data) ) return data.getAttribute("userdata");
		}
		return null;
	}
	this.saveState = function() {
		var value = this.getState();
		this.stateElem.value = value;
		if(this.enableWriteState) {
			try {
				var data = this.getLayout();	
				data.setAttribute("userdata", value);
				data.save(this.sContentID + this.table.id);
			} catch(e) {}
		}
	}
	this.setPartPosition = function(part, nextPart) {
		var parent = this.obj.ParentOf(part);
		var lastPart = this.parts.Last();
		if(this.inf.ie4) {
			var index = (nextPart != null) ? GetItemIndex(parent.children, nextPart) :
				GetItemIndex(parent.children, lastPart) + 1;
			parent.innerHTML = this.getPartHTML(parent.children, index);
	//		InitElement( this );
		} else if(this.inf.dom) {
			var nextElem = (nextPart != null) ? nextPart : lastPart.nextSibling;
			parent.insertBefore(part, nextElem);
		}
	}   
	this.getPartHTML = function(partSiblings, nextIndex) {
		var s = "";
		for(var i = 0; i <= partSiblings.length; i++) {
			if(i == nextIndex) s += this.current.outerHTML;
			try {
				var part = partSiblings[i];
				if(part == this.current) continue;
				s += part.outerHTML;
			} catch(e) {}
		}
		return s;
	}
	this.getNextPartIndex = function(el) {
		var pte = this.pos.GetAbsolutePos(el);
		for(var i = 0; i < this.parts.length; i++) {
			var pt = this.pos.GetAbsolutePos(this.parts[i]);
			if(pt.y > pte.y) break;
		}
		return i;
	}   
	this.setDragPosition = function() {
		if(null == this.current) return;
		
		var part = this.current;
		var nextIndex = this.getNextPartIndex(this.dragWindow);
		this.hideDragWindow();
		var action = "Order";

		if( this.containsAction(action) ) {
			var index = nextIndex;
			if(this.parts.IndexOf(part) < index) index--;
			var args = [["group", part.id], ["action", action], ["visIndex", index]];
			__doPostBack(this.table.id, DoEventArgs(args) );
		}
		else {
			if(this.parts.IndexOf(part) != nextIndex) {
				var nextPart = this.parts[nextIndex];
				this.setPartPosition(part, nextPart);
				this.setPartArray();
				this.saveState();
			}
		}
	}
	this.reorder = function(state) {
		if(null == state) return;
		for(var i = 0; i < state.length; i++) {
			var id = state[i][0];
			if( this.parts[i].id != id ) {
				var nextPart = this.parts[i];
				var part = this.getChildById(this.table, id);
				if(part != null) {
					this.setPartPosition(part, nextPart);
					this.setPartArray();
				}
			}
		}
		var closed = false;
		for( var i = 0; i < this.parts.length; i++ ) {
			try { closed = (state[i][1] == "close"); } 
			catch(e) { closed = false; }
			this.showHideContent(this.parts[i], !closed);
		}
	}
	this.showHideContent = function(part, collapsed) {
		this.showContent(part, collapsed);
		part.state = collapsed ? "open" : "close";
		
		var img = this.getChildById(part, "LeftImage");
		if(img != null) img.src = this.getLeftImage(part);

		img = this.getChildById(part, "RightImage");
		if(img != null) img.src = this.getRightImage(part);

		var sc = new dx_StringComparer();
		var nodes = this.obj.GetChildren(part, "className", "clsBorder", sc);
		for(var i = 0; i < nodes.length; i++) {
			nodes[i].style.backgroundColor = this.getBorderColor(part);
		}

		nodes = this.obj.GetChildren(part, "className", "clsHead", sc);
		for(var i = 0; i < nodes.length; i++) {
			nodes[i].style.backgroundColor = this.getBackColor(part);
		}
		nodes = this.obj.GetChildren(part, "className", "clsHeadText", sc);
		for(var i = 0; i < nodes.length; i++) {
			nodes[i].style.color = this.getForeColor(part);
		}
		this.saveState();                      
	}
	this.showHidePart = function(part, collapsed) {
		var action = collapsed ? "Expand" : "Collapse";
		if(this.containsAction(action)) {
			var args = [["group", part.id], ["action", action]];
			__doPostBack(this.table.id, DoEventArgs(args) );
		}
		else this.showHideContent(part, collapsed);
	}
	this.isContentVisible = function(part) {
		if(this.inf.ie4) {
			var content = this.getPartContent(part);
			return (content.style.display != "none");
		} else if(this.inf.dom) {
			var parent = this.getContentParent(part);
			return (parent.content == null) || (parent.content == undefined);
		}
		return false;
	}
	this.showContent = function(part, visible) {
		if(this.inf.ie4) {
			var content = this.getPartContent(part);
			content.style.display = visible ? "inline" : "none";
		} else if(this.inf.dom) {
			var contParent = this.getContentParent(part);
			if(visible) {
				if( Exists(contParent.content) ) {
   					contParent.appendChild(contParent.content);
   					contParent.content = null;
   				}
			} else {
				var content = this.getPartContent(part);
   				contParent.removeChild(content);
   				contParent.content = content;
			}
		}
	}
	this.getPartContent = function(part) {
		return this.getChildById(part, "ContentTable");
	}
	this.getContentParent = function(part) {
		return this.getChildById(part, "ContentCell");
	}
}

// globals

var dxBar = [];
dxBar["Mng"] = new dx_BarManager();
dxBar["Evt"] = new dx_EventManager();
dxBar["Inf"] = new dx_Info();
mbtn_left = dxBar.Inf.ie || dxBar.Inf.op ? 1 : 0;

function OnMouseDown(e) { dxBar.Mng.OnMouseDown(e); return false; }
function OnPartClick(e) { dxBar.Mng.OnPartClick(e); }
function OnDragStart(e) {
	var el = dxBar.Inf.GetSrcElement(e);
        var evt = dxBar.Inf.GetEvent(e);
	if(el.className.indexOf("clsHead") >= 0) evt.returnValue = false;
}

dxBar.Evt.Attach("window.onload", function() { dxBar.Mng.Initialize(); } );
window.onload = function() { dxBar.Evt.Exec("window.onload"); }

window.onerror = function() { 
	return true;
};
