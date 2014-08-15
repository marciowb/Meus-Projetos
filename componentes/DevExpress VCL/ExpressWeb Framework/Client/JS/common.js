/*
   ExpressWeb Framework by Developer Express
   Common script

   Copyright (c) 2000-2004 Developer Express Inc.
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and   
   International Copyright Laws. Unauthorized reproduction,     
   reverse-engineering, and distribution of all or any portion of   
   the code contained in this file is strictly prohibited and may
   result in severe civil and criminal penalties and will be
   prosecuted to the maximum extent possible under the law.
*/

Array.prototype.IndexOf = function(item) { return GetItemIndex(this, item); }
Array.prototype.Add = function(item) { this[this.length] = item; }
Array.prototype.First = function() { return (this.length > 0) ? this[0] : null; }
Array.prototype.Last = function() { return (this.length > 0) ? this[this.length - 1] : null; }

function insp(obj) {
	var s;
	for(i in obj) {
	        if(i.indexOf("on") != 0 && i.indexOf("outer") != 0 && i.indexOf("inner") != 0) {
				var val = " = " + eval("obj." + i);
				if(val.indexOf("function") < 0)		
					s += i + val + "\t\t";
			}
	}
	alert(s);
}
function SetProperties(obj, s) {
	var a = s.split( ";" );
	for(var i = 0; i < a.length; i++) {
		var b = a[i].split( ":" );
		if(b.length == 2) eval("obj." + b[0] + "=" + b[1]);
	}
}
function Exists(obj) {
	return null != obj && (typeof(obj) == "string" && obj == "") == false && "undefined" != typeof(obj);
}
function DoEventArgs(args) {
	var s = "";
	for(var i = 0; i < args.length; i++) {
		s += DoEventArg(args[i][0], args[i][1]);
	}
	return s;
}
function DoEventArg(name, val) { 
	return name + ":" + val + ";";
}
function GetItemIndex(items, item) { 
	if( Exists(items) ) {
		for(var i = 0; i < items.length; i++) 
			if(items[i] == item) return i; 
	}
	return -1; 
}
function GetItemByName(items, name) { 
	return Exists(items) ? items[name] : null;
}
/* class */
function dx_Utils()
{
	this.NavigateUrl = function(url, target) {
		if(url.indexOf("javascript") != -1) eval(url);
		else {
			if( Exists(target) ) {
				if( this.IsSpecial(target) ) {
					this.NavigateSpecialTarget(url, target);
				} else {
					var frame = this.GetFrame(top.frames, target);
					if( Exists(frame) ) frame.location.href = url;
					else location.href = url;
				}
			} else {
				location.href = url;
			}
		}
	}
	this.IsSpecial = function(target) {
		var targets = ['_top','_self','_search','_parent','_blank'];
		for(var i = 0; i < targets.length; i++)
			if(targets[i] == target) return true;
		return false;
	}
	this.NavigateSpecialTarget = function(url, target) {
		if("_top" == target) {
			top.location.href = url;
		} else if("_self" == target) {
			location.href = url;
		} else if("_search" == target) {
		} else if("_parent" == target) {
			if( Exists(window.parent) ) window.parent.location.href = url;
		} else if("_blank" == target) {
			window.open(url, 'blank');
		}
	}
	this.GetFrame = function(frames, name) {
		if( Exists(frames) ) {
			for(var i = 0; i < frames.length; i++) {
				var frame = frames[i];
				if(frame.name == name) return frame;	

				frame = this.GetFrame(frame.frames, name);
				if( Exists(frame) ) return frame;	
			}
		}
		return null;
	}
	this.CreatePosHelper = function() {
		var info = new dx_Info();
		var pos = info.ie ? new dx_PosIE() : (info.op ? new dx_PosOpera() : ( info.ns4 ? new dx_PosNS4() : ( info.ns6 ? new dx_PosNS6() : new dx_PosHelper() ) ) );
		return pos;
	}
	this.CreateObjHelper = function() {
		var info = new dx_Info();
		var obj = info.ie4 ? new dx_ObjIE4() : ( info.ns4 ? new dx_ObjNS4() : ( info.dom ? new dx_ObjDOM() : new dx_ObjHelper() ) );
		return obj;
	}
	this.IsObjectMoved = function(x1, x2, y1, y2) {
		return (Math.abs(x1 - x2) > 3) || (Math.abs(y1 - y2) > 3);
	}
}
/* class */
function dx_Info()
{
	this.ver = navigator.appVersion;
	this.agent = navigator.userAgent.toLowerCase();
	this.dom = document.getElementById?1:0;
	this.op = (this.agent.indexOf("opera")>-1 || this.agent.indexOf("opera")>-1) && window.opera;
	this.op5 = (this.agent.indexOf("opera 5")>-1 || this.agent.indexOf("opera/5")>-1) && window.opera;
	this.op6 = (this.agent.indexOf("opera 6")>-1 || this.agent.indexOf("opera/6")>-1) && window.opera;   
	this.ie5 = (this.agent.indexOf("msie 5")>-1 && !this.op5 && !this.op6);
	this.ie55 = (this.ie5 && this.agent.indexOf("msie 5.5")>-1);
	this.ie6 = (this.agent.indexOf("msie 6")>-1 && !this.op5 && !this.op6);
	this.ie4 = (this.agent.indexOf("msie")>-1 && document.all &&!this.op5 &&!this.op6 &&!this.ie5&&!this.ie6);
	this.ie = (this.ie4 || this.ie5 || this.ie6);
	this.mac = (this.agent.indexOf("mac")>-1);
	this.ns6 = (this.agent.indexOf("gecko")>-1 || window.sidebar);
	this.ns4 = (!this.dom && document.layers)?1:0;
	this.bw = (this.ie6 || this.ie5 || this.ie4 || this.ns4 || this.ns6 || this.op5 || this.op6);
	this.px = this.dom&&!this.op5?"px":"";
	this.ie = (this.ie6 || this.ie5 || this.ie4);
	this.GetEvent = function(e) { return this.ie || this.op ? event : Exists(e) ? e : null; }
	this.GetSrcElement = function(e) { return this.ie ? event.srcElement : Exists(e) ? e.target : null; }
	this.GetTargetElement = function(e) { return this.ie ? event.toElement : Exists(e) ? e.relatedTarget : null; }
        this.GetAltState = function(e) { return Exists(this.GetEvent(e)) ? Exists(this.GetEvent(e).modifiers) ? (this.GetEvent(e).modifiers | 1 > 0) : this.GetEvent(e).altKey : false; }
        this.GetCtrlState = function(e) { return Exists(this.GetEvent(e)) ? Exists(this.GetEvent(e).modifiers) ? (this.GetEvent(e).modifiers | 2 > 0) : this.GetEvent(e).ctrlKey : false; }
        this.GetShiftState = function(e) { return Exists(this.GetEvent(e)) ? Exists(this.GetEvent(e).modifiers) ? (this.GetEvent(e).modifiers | 4 > 0) : this.GetEvent(e).shiftKey : false; }
	return this;
}
/* class */
function dx_Rect(left, top, width, height) 
{
	this.left = left;
	this.top = top;
	this.right = left + width;
	this.bottom = top + height;
	
	this.IsEmpty = function() {
		return (this.left == 0 && this.top == 0 && this.right == 0 && this.bottom == 0) ?
			true : false;
	}
	this.Contains = function(pt) {
		return (pt.x > this.left && pt.x < this.right && pt.y > this.top && pt.y < this.bottom) ?
			true : false;
	}
	return this;
}
/* class */
function dx_Point(x,y)
{
	this.x = x;
	this.y = y;
	this.FromString = function(s) {
		var arr = s.split( ";" );
		if(arr.length > 1) {
			this.x = parseInt(arr[0], 10);
			this.y = parseInt(arr[1], 10);
		}
	}
	this.Offset = function(dx, dy) { this.x += dx; this.y += dy; }
	this.Clone = function() { return new dx_Point(this.x, this.y); }
	return this;
}
/* class */
function dx_PosHelper()
{
	this.GetEventX = function(e, wind) { return 0; }
	this.GetEventY = function(e, wind) { return 0; }
	this.GetWindowRect = function() {
                return new dx_Rect(0, 0, 0, 0);
	}
	this.GetWindowScroll = function() {
                return new dx_Point(0, 0);
	}
	this.SetWindowScroll = function(left, top) {
	}
	this.EventPoint = function(e, wind) {
		return new dx_Point(this.GetEventX(e,wind), this.GetEventY(e,wind));
	}
	this.GetElementHeight = function(el) {
                return el.offsetHeight;
	}
	this.GetElementWidth = function(el) {
                return el.offsetWidth;
	}
	this.GetAbsolutePos = function(el) {
		var pt = new dx_Point(0, 0);
		if( Exists(el) ) {
			if( Exists(el.offsetParent) ) {
				pt = this.GetAbsolutePos(el.offsetParent);
				if(el.offsetWidth != 0 || el.offsetHeight != 0 || "absolute" == el.style.position) {
					pt.Offset(el.offsetLeft, el.offsetTop);
				}
			} else {
				pt = new dx_Point(el.offsetLeft, el.offsetTop);
			}
		}
		return pt;
	}
	this.SetAbsolutePos = function(elem, x, y) {
		if( Exists(elem) ) {
			elem.style.left = x;
			elem.style.top = y;
		}
	}
	return this;
}
/* class */
function dx_PosIE()
{
	this.inherit = dx_PosHelper;
	this.inherit();

	this.GetEventX = function(e, wind) { return event.clientX + wind.document.body.scrollLeft; }
	this.GetEventY = function(e, wind) { return event.clientY + wind.document.body.scrollTop; }
	this.GetWindowRect = function() {
		with(document.body) {
			return new dx_Rect(scrollLeft, scrollTop, clientWidth, clientHeight);
		}
	}
	this.GetWindowScroll = function() {
		with(document.body) {
                	return new dx_Point(scrollLeft, scrollTop);
                }
	}
	this.SetWindowScroll = function(left, top) {
		document.body.scrollLeft = left;
		document.body.scrollTop = top;	
	}
	this.SetAbsolutePos = function(elem, x, y) {
		if( Exists(elem) ) {
			var offset = this.GetParentOffset(elem);
			elem.style.left = x - offset.x;
			elem.style.top = y - offset.y;
		}
	}
	this.GetParentOffset = function(elem) {
		var pt = new dx_Point(0,0);
		var parent = elem.offsetParent;
		while( Exists(parent) ) {
			if("absolute" == parent.style.position) {
				pt.Offset(parent.offsetLeft, parent.offsetTop);
			}
			parent = parent.offsetParent;
		}
		return pt;
	}
	return this;
}
function dx_PosOpera()
{
	this.inherit = dx_PosHelper;
	this.inherit();

	this.GetEventX = function(e, wind) { return e.clientX; }
	this.GetEventY = function(e, wind) { return e.clientY; }
	this.GetWindowRect = function() {
		with(window) {
			return new dx_Rect(pageXOffset, pageYOffset, innerWidth, innerHeight);
		}
	}
	this.GetWindowScroll = function() {
		with(window) {
			return new dx_Point(pageXOffset, pageYOffset);
		}
	}
	this.SetWindowScroll = function(left, top) {
		window.scrollTo(left, top);	
	}
	return this;
}
/* class */
function dx_PosNS()
{
	this.inherit = dx_PosHelper;
	this.inherit();

	this.GetEventX = function(e, wind) { return e.pageX; }
	this.GetEventY = function(e, wind) { return e.pageY; }
	this.GetWindowRect = function() {
		with(window) {
			return new dx_Rect(pageXOffset, pageYOffset, innerWidth, innerHeight);
		}
	}
	this.GetWindowScroll = function() {
		with(window) {
			return new dx_Point(pageXOffset, pageYOffset);
		}
	}
	this.SetWindowScroll = function(left, top) {
		window.scrollTo(left, top);	
	}
	return this;
}
/* class */
function dx_PosNS4()
{
	this.inherit = dx_PosNS;
	this.inherit();

	this.GetElementHeight = function(el) {
                return 0;
	}
	this.GetElementWidth = function(el) {
                return 0;
	}
	this.GetAbsolutePos = function(el) {
		var pt = new dx_Point(el.x, el.y);
		var parent = this.GetParentOf(el);
		if( Exists(parent) && Exists(parent.pageX) && Exists(parent.pageY) )
			pt.Offset(parent.pageX, parent.pageY);
		return pt;
	}
	this.SetAbsolutePos = function(el, x, y) {
		var pt = new dx_Point(x, y);
		var parent = this.GetParentOf(el);
		if( Exists(parent) && Exists(parent.pageX) && Exists(parent.pageY) )
			pt.Offset(-parent.pageX, -parent.pageY);
		el.x = pt.x; el.y = pt.y;
	}
	this.GetParentOf = function(el) {
		if(Exists(el.parentElement) == false) {
			el.parentElement = this.SearchParentOf(el);
		}
		return el.parentElement;
	}
	this.SearchParentOf = function(el) {
		var searcher = new dx_Searcher();
		searcher.GetNodes = function(node) { return node.document.layers; }
		searcher.GetElement = function(node, val) {
			if(Exists(val.name) == false) return null;
			var el = GetItemByName(node.document.layers, val.name);
			if( Exists(el) ) return node;
			var el = GetItemByName(node.document.images, val.name);
			if( Exists(el) ) return node;
			var el = GetItemByName(node.document.anchors, val.name);
			if( Exists(el) ) return node;
			return null;
		}
		return searcher.GetElementByVal(window, el);
	}
	return this;
}
/* class */
function dx_PosNS6()
{
	this.inherit = dx_PosNS;
	this.inherit();
	return this;
}
/* class */
function dx_StringComparer()
{
	this.Equals = function(a, b) { return (Exists(a) && a.indexOf(b) != -1); }
	return this;
}
/* class */
function dx_DefaultComparer()
{
	this.Equals = function(a, b) { return a == b; }
	return this;
}
/* class */
function dx_NodeCollector(comp)
{
	this.comp = comp;
	this.nodes = [];
	this.SelectNodes = function(src, property, value) {
		if(Exists(this.comp) == false) this.comp = new dx_DefaultComparer();
		for(var i = 0; i < src.length; i++) {
			var node = src[i];
			var propValue = eval("node." + property);
			if( this.comp.Equals(propValue,value) )
				this.nodes.Add(node);
		}
	}
}
/* class */
function dx_ObjHelper()
{
	this.IsElementVisible = function(el) { return false; }
	this.SetElementVisibility = function(el, visible) {}
	this.GetElementById = function(name) { return null; }
	this.ParentOf = function(elem) { return null; }
	this.ChildrenOf = function(elem) { return null; }
	this.GetTags = function(elem, name) {
		return this.GetChildren(elem, "tagName", name.toUpperCase(), null);
	}
	
	this.GetNodes = function(src, property, value, comp) {
		var coll = new dx_NodeCollector(comp);
		coll.SelectNodes(src, property, value);
		return coll.nodes;
	}
	this.GetChildren = function(elem, property, value, comp) {
		var coll = new dx_NodeCollector(comp);
		this.SelectChildren(elem, coll, property, value);
		return coll.nodes;
	}
	this.SelectChildren = function(elem, coll, property, value) {
		var src = this.ChildrenOf(elem);
		if( Exists(src) ) {
			coll.SelectNodes(src, property, value);
			for(var i = 0; i < src.length; i++) {
				this.SelectChildren(src[i], coll, property, value);
			}
		}
	}
	this.GetParentByClass = function(elem, className) {
		while( Exists(elem) && elem.className != className ) {
			elem = this.ParentOf(elem);
		}
		return elem;
	}
	this.GetParentById = function(elem, id) {
		while( Exists(elem) ) {
			if(Exists(elem.id) && elem.id.indexOf(id) != -1)
				break;
			elem = this.ParentOf(elem);
		}
		return elem;
	}
	this.GetChildById = function(elem, id) {
		var searcher = new dx_Searcher();
		searcher.GetNodes = this.ChildrenOf;
		searcher.GetElement = function(node, val) { return (val == node.id) ? node : null; }
		return searcher.GetElementByVal(elem, id);
	}
	return this;
}
/* class */
function dx_ObjIE4()
{
	this.inherit = dx_ObjHelper;
	this.inherit();

	this.IsElementVisible = function(el) { return "visible" == el.style.visibility; }
	this.SetElementVisibility = function(el, visible) { el.style.visibility = visible ? "visible" : "hidden"; }
	this.GetElementById = function(name) { return document.all[name]; }
	this.ParentOf = function(elem) { return elem.parentElement; }
	this.ChildrenOf = function(elem) { return elem.children; }
	this.GetTags = function(elem, name) { return elem.all.tags(name); }
	return this;
}
/* class */
function dx_ObjNS4()
{
	this.inherit = dx_ObjHelper;
	this.inherit();

	this.IsElementVisible = function(el) { return "hide" != el.visibility; }
	this.SetElementVisibility = function(el, visible) { el.visibility = visible ? "visible" : "hidden"; }
	this.CreateLayer = function(width, parent, s) {
		var el = new Layer(width, parent);
		this.WriteLayer(el, s);
		return el;
	}
	this.WriteLayer = function(el, s) {
		if( Exists(el) && Exists(s) ) {
			el.document.open();
			el.document.write(s);
			el.document.close();
		}
	}
	this.GetElementById = function(name) {
		var searcher = new dx_Searcher();
		searcher.GetNodes = function(node) { return node.document.layers; }
		searcher.GetElement = function(node, val) { 
			var el = node.document.layers[val];
			if(Exists(el) == false) el = node.document.anchors[val];
			if(Exists(el) == false) el = node.document.images[val];
			if(Exists(el) == false) {
				for(var i = 0; i < node.document.forms.length; i ++) {
					el = node.document.forms[i].elements[val];		
					if( Exists(el) ) break;
				}
			}
			if( Exists(el) ) el.parentElement = node;
			return el;
		}
		return searcher.GetElementByVal(window, name);
	}
	return this;
}
/* class */
function dx_ObjDOM()
{
	this.inherit = dx_ObjHelper;
	this.inherit();

	this.IsElementVisible = function(el) { return "visible" == el.style.visibility; }
	this.SetElementVisibility = function(el, visible) { el.style.visibility = visible ? "visible" : "hidden"; }
	this.GetElementById = function(name) { return document.getElementById(name); }
	this.ParentOf = function(elem) { return elem.parentNode; }
	this.ChildrenOf = function(elem) { return elem.childNodes; }
	return this;
}
/* class */
function dx_Searcher()
{
	this.GetElement = function(node, val) { return null; }
	this.GetNodes = function(node) { return null; }
	
	this.GetElementByVal = function(src, val) {
		var el = this.GetElement(src, val);
		if( Exists(el) ) return el;
		
		var nodes = this.GetNodes(src);
		if(Exists(nodes) == false) return null;

		for(var i = 0; i < nodes.length; i++) {
			el = this.GetElement(nodes[i], val);
			if( Exists(el) ) return el;
			el = this.GetElementByVal(nodes[i], val);
			if( Exists(el) ) return el;
		}
		return null;
	}
	return this;
}
/* class */
function dx_Event()
{
	this.func = null;
	this.prev = null;
	this.capture = false;
	
	this.Exec = function(e) {
		if(this.capture == false && Exists(this.prev) ) this.prev(e);
		if( Exists(this.func) ) this.func(e);
	}
	this.Attach = function(name, func) {
		if(Exists(this.prev) == false) {
			this.prev = eval(name);
			this.func = func;
		}
	}
	this.Capture = function(name, func) {
		this.Attach(name, func);
		this.capture = true;
	}
	this.Detach = function(name) {
		eval(name + " = this.prev");
		this.func = null;
		this.prev = null;
		this.capture = false;
	}
	return this;
}
/* class */
function dx_EventManager()
{
	this.events = [];
	this.Exec = function(name,e) {
		var ev = this.events[name];
		if( Exists(ev) ) ev.Exec(e);
	}
	this.AddEvent = function(name) {
		var ev = new dx_Event();
		this.events[name] = ev;
		return ev;
	}
	this.Capture = function(name, func) {
		if(Exists(this.events[name]) == false) {
			var ev = this.AddEvent(name);
			ev.Capture(name, func);
		}
	}
	this.Attach = function(name, func) {
		if(Exists(this.events[name]) == false) {
			var ev = this.AddEvent(name);
			ev.Attach(name, func);
		}
	}
	this.Detach = function(name) {
		if(Exists(this.events[name]) == true) {
			this.events[name].Detach(name);
			this.events[name] = null;
		}		
	}
}
