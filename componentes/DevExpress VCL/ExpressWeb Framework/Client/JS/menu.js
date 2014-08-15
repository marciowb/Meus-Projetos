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

/* class Menu */
function dx_Menu(owner) 
{
	this.items = [];
	this.owner = owner;
	this.id = "empty";
	this.offset = new dx_Point(0,0);
	this.altOffset = new dx_Point(0,0);
	this.width = 0;
	this.isParent = false;
	
	this.GetElementById = function(id) {
		return dxMenu.Obj.GetElementById(id);
	}
	this.GetMenuElement = function() {
		if(this.isParent && Exists(this.menuElement) == false) {
			this.menuElement = this.GetElementById(this.id + "_Menu");
		}
		return this.menuElement;
	}
	this.GetAnchorElement = function() {
		if(Exists(this.anchorElement) == false) {
			this.anchorElement = this.GetElementById(this.id + "_Anchor");
		}
		return this.anchorElement;
	}
	this.GetAnchorPos = function() {
		var el = this.GetAnchorElement();
		return ( Exists(el) ) ? dxMenu.Pos.GetAbsolutePos(el) : null;
	}
	this.HideChildren = function(skipItem) {
		for(var i = 0; i < this.items.length; i++) {
			var item = this.items[i];
			if(item != skipItem) {
				item.HideChildren(skipItem);
				item.Show(false);
				item.Highlight(false);
			}
		}
	}
	this.Show = function(visible) {
		if( !this.isParent ) return;
		if(visible) {
			var pt = this.GetMenuPos();
			this.PopupMenu(pt.x, pt.y, false);
		} else {
			this.HideMenu();
		}
	}
	this.PopupMenu = function(x, y, isContextMenu) {
		this.SetMenuPos(x, y, isContextMenu);
		this.ShowMenu();
	}
	this.SetMenuPos = function(x, y, isContextMenu) {
		var el = this.GetMenuElement();
		if( Exists(el) ) {
			if(isContextMenu){
				var elHeight = dxMenu.Pos.GetElementHeight(el);
				var elWidth = dxMenu.Pos.GetElementWidth(el);
				var wRect = dxMenu.Pos.GetWindowRect();
				if(y + elHeight > wRect.bottom)
					y -= y + elHeight - wRect.bottom;
				if(x + elWidth > wRect.right)
					x -= x + elWidth - wRect.right;
			}
			dxMenu.Pos.SetAbsolutePos(el, x, y);
		}
	}
	this.HideMenu = function() {
		var el = this.GetMenuElement();
		if( Exists(el) ) this.SetMenuVisibility(el, false);
	}
	this.ShowMenu = function() {
		var el = this.GetMenuElement();
		if( Exists(el) ) this.SetMenuVisibility(el, true);
	}
	this.SetMenuVisibility = function(el, visible) {
		this.SetElementVisibility(el, visible);
	}
	this.SetElementVisibility = function(el, visible) {
		if ( Exists(el) ) dxMenu.Obj.SetElementVisibility(el, visible);
	}
	this.IsElemVisible = function(el) {
		return dxMenu.Obj.IsElementVisible(el);
	}
	this.GetMenuPos = function() {
		var pt = this.GetAnchorPos();
		if( Exists(pt) ) {
			var rc = dxMenu.Pos.GetWindowRect();
			var part1 = this.GetHiddenPart(rc, pt, this.offset);
			var part2 = this.GetHiddenPart(rc, pt, this.altOffset);
			if(part1 <= part2)
				pt.Offset(this.offset.x, this.offset.y);
			else
				pt.Offset(this.altOffset.x, this.altOffset.y);
		}
		return pt;
	}
	this.GetHiddenPart = function(rc, pos, offset) {
		var pt = pos.Clone();
		pt.Offset(offset.x, offset.y);
		var leftPiece = Math.max(0, rc.left - pt.x);
		var rightPiece = Math.max(0, pt.x + this.width - rc.right);
		return leftPiece + rightPiece;
	}
	this.GetItemById = function(id) {
		for(var i = 0; i < this.items.length; i++) {
			var item = this.items[i];
			if(item.id == id) return item;
			item = item.GetItemById(id);
			if( Exists(item) ) return item;
		}
		return null;
	}
	this.AddItem = function(id) {
		var item = this.CreateItem();
		if( Exists(id) ) item.id = id;
		this.items.Add(item);
		this.isParent = true;
		return item;
	}
	this.CreateItem = function() {
		return dxMenu.Inf.ns4 ? new dx_MenuItemNS4(this, this.owner) :
			new dx_MenuItem(this, this.owner);
	}
}
/* class MenuItem */
function dx_MenuItem(parent, owner) 
{
	this.inherit = dx_Menu;
	this.inherit(owner);
	this.parent = parent;

	this.GetSelectedElement = function() {
		if(Exists(this.selectedElement) == false) {
			this.selectedElement = this.GetElementById(this.id + "_Selected");
		}
		return this.selectedElement;
	}
	this.Highlight = function(visible) {
		var el = this.GetSelectedElement();
		this.SetElementVisibility(el, visible);
	}
	this.IsSelected = function() {
		var el = this.GetSelectedElement();
		return this.IsElemVisible(el);
	}
	this.Select = function() {
		if(this.IsSelected() == false) {
			this.parent.HideChildren(this);
			this.Highlight(true);
			this.Show(true);
		}
	}
	this.Index = function() {
		return this.parent.items.IndexOf(this);
	}
}
/* class MenuItemNS4 */
function dx_MenuItemNS4(parent, owner) 
{
	this.inherit = dx_MenuItem;
	this.inherit(parent, owner);

	this.SetMenuVisibility = function(el, visible) {
		this.SetElementVisibility(el, visible);
		if(visible) {
			for(var i = 0; i < this.items.length; i++) {
				this.items[i].SetElementPos();
			}
		}
		for(var i = 0; i < this.items.length; i++) {
			this.items[i].SetLinkVisibility(visible);
		}
	}
	this.SetLinkVisibility = function(visible) {
		var el = this.GetLinkElement();
		this.SetElementVisibility(el, visible);
	}
	this.GetLinkElement = function() {
		if(Exists(this.linkElement) == false) {
			this.linkElement = this.CreateLink();
		}
		return this.linkElement;
	}
	this.Clear = function() {
		if( Exists(this.linkElement) ) {
			delete this.linkElement;
			this.linkElement = null;
		}
		for(var i = 0; i < this.items.length; i++) {
			this.items[i].Clear();
		}
	}
	this.Initialize = function() {
		this.SetElementPos();
		for(var i = 0; i < this.items.length; i++) {
			this.items[i].Initialize();
		}
	}
	this.SetElementPos = function() {
		var pt = this.GetAnchorPos();
		if( Exists(pt) ) {
			if(this.HasHorizontalParent() && this.owner.itemHeight > 0) 
				pt.y -= (this.owner.itemHeight - 1);
			var el = this.GetLinkElement();
			if(Exists(el)) dxMenu.Pos.SetAbsolutePos(el, pt.x, pt.y);
			el = this.GetSelectedElement();
			if( Exists(el) ) dxMenu.Pos.SetAbsolutePos(el, pt.x, pt.y);
		}
	}
	this.GetAnchorPos = function() {
		var el = this.GetAnchorElement();
		if( Exists(el) ) return dxMenu.Pos.GetAbsolutePos(el);
		var el = this.parent.GetMenuElement();
		if( Exists(el) ) {
			var pt = dxMenu.Pos.GetAbsolutePos(el);
			pt.x += this.parent.borderWidth;
			pt.y += this.parent.borderWidth;
			pt.y += this.Index() * this.owner.itemHeight;
			return pt;
		}
		return null;
	}
	this.HasRootParent = function() {
		return (this.owner == this.parent);
	}
	this.HasHorizontalParent = function() {
		return (this.owner == this.parent && this.owner.horizontal > 0);
	}
	this.GetItemWidth = function() {
		return Exists(this.itemWidth) ? this.itemWidth : this.parent.width;
	}
	this.CreateLink = function() {
		var lyr = dxMenu.Obj.CreateLayer(this.parent.width, window, null);
		with(lyr) {
			clip.width = this.GetItemWidth();
			clip.height = this.owner.itemHeight;
		}
		var visible = this.HasRootParent() ? true : false;
		this.SetElementVisibility(lyr, visible);
		lyr.menuItem = this;
		lyr.onmouseover = function() { this.menuItem.Select(); }
		if( Exists(this.href) ) {
			lyr.captureEvents(Event.CLICK);
			lyr.onclick = function(){ this.menuItem.OnClick() };
		}
		return lyr;
	}
	this.OnClick = function() {
		dxMenu.Utl.NavigateUrl(this.href, this.target);
	}
}
/* class MainMenu */
function dx_MainMenu() 
{
	this.inherit = dx_Menu;
	this.inherit(this);
	this.horizontal = 0;
	this.itemHeight = 10;
}
/* class MenuManager */
function dx_MenuManager() 
{
	this.menus = [];
	this.Initialize = function() {
	}
	this.OnResize = function() {
		this.HideAll();
	}
	this.HideAll = function() {
		for(var i = 0; i < this.menus.length; i++) {
			this.menus[i].HideChildren(null);
		}
	}
	this.CreateMenu = function() {
		var menu = new dx_MainMenu();
		this.menus.Add(menu);
		return menu;
	}
	this.GetMenuItem = function(id) {
		for(var i = 0; i < this.menus.length; i++) {
			var item = this.menus[i].GetItemById(id);
			if(Exists(item)) return item;
		}
		return null;
	}
	this.GetMainMenu = function(id) {
		for(var i = 0; i < this.menus.length; i++)
			if(id == this.menus[i].id) return this.menus[i];
		return null;
	}
	this.SelectMenuItem = function(id) {
		var item = this.GetMenuItem(id);
		if( Exists(item) ) item.Select();
	}
	this.PopupMenu = function(id, e, x, y, isContextMenu) {
		var item = this.GetMenuItem(id);
		if( Exists(item) ) {
			if(Exists(x) == false) x = dxMenu.Pos.GetEventX(e, window);
			if(Exists(y) == false) y = dxMenu.Pos.GetEventY(e, window);
			item.PopupMenu(x,y,isContextMenu);
		}
	}
	this.HideMenu = function(id) {
		var item = this.GetMenuItem(id);
		if( Exists(item) ) item.HideMenu();
	}
	this.OnMouseDown = function(e) {
		var el = dxMenu.Inf.GetSrcElement(e);
		el = dxMenu.Obj.GetParentById(el, "_MenuItem");
		if(!Exists(el)) this.HideAll();
	}
        this.OnMouseOut = function(e) {
                var el = dxMenu.Inf.GetTargetElement(e);
                if (!Exists(el)) this.HideAll();
        }

}
