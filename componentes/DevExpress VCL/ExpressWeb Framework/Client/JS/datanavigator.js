/*
   ExpressWeb Framework by Developer Express
   ExpressWebDataNavigator

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
var dxDataNavigator = [];
dxDataNavigator["Inf"] = new dx_Info();
dxDataNavigator["Mng"] = new dx_DataNavigatorManager();
dxDataNavigator["Utl"] = new dx_Utils();
dxDataNavigator["Obj"] = dxDataNavigator.Utl.CreateObjHelper();
dxDataNavigator["Evt"] = new dx_EventManager();


function dx_DataNavigator()
{
  this.Name = "";
  this.PageSize = 1;
  this.ProcessPageSizeSrc = "";  
  this.ApplyPageSizeSrc = "";
  this.AssignOnChangePageSize = false;
  this.Editing = false;
// Data binding 
  this.DataControl = null;
  this.DataController = null;
// Events	
  this.OnButtonClick = null;
  this.OnChangePageSize = null;

  this.GetPageSizeEditElement = function() {
  	return dxDataNavigator.Obj.GetElementById(this.Name + "PageSizeEdit");
  }
  this.GetApplyPageSizeImage = function() {
  	return dxDataNavigator.Obj.GetElementById(this.Name + "_NBChPS_");
  }
  this.Initialize = function() {
        if(Exists(this.DataControl) && Exists(this.DataController)) return;
        this.DataControl = dxDataControls.Mng.GetDataControl(this.Name);
        if( Exists(this.DataControl)) this.DataController = dxDataController.Mng.GetDataController(this.DataControl.DataControllerName);
  }
  this.OnFirstClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "first");
        if( Exists(this.DataController)) {
	        this.CancelPageSize();
        	this.DataController.MoveTo(0);
        }
  }
  this.OnPriorPageClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "priorpage");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.MoveBy(-this.PageSize);
        }
  }
  this.OnPriorClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "prior");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.MoveBy(-1);
        }
  }
  this.OnChangePageSizeClick = function() {
	var pageSizeEdit = this.GetPageSizeEditElement();
	if( Exists(pageSizeEdit) ) {
		if(this.Editing) this.ApplyPageSize();
		else pageSizeEdit.focus();
	}
  }
  this.OnNextClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "next");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.MoveBy(1);
        }
  }
  this.OnNextPageClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "nextpage");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.MoveBy(this.PageSize);
        }
  }
  this.OnLastClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "last");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.MoveTo(this.DataController.RowCount - 1);
        }
  }
  this.OnInsertClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "inser");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.Insert(this.DataController.FocusedRow);
        }
  }
  this.OnEditClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "edit");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.StartEdit(this.DataController.FocusedRow);
        }
  }
  this.OnDeleteClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "delete");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.Delete(this.DataController.FocusedRow);
        }
  }
  this.OnPostClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "post");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.PostEdit("");
        }
  } 
  this.OnCancelClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "cancel");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.CancelEdit(true);
        }
  }
  this.OnRefreshClick = function() {
        if(this.OnButtonClick) this.OnButtonClick(this, "refresh");
        if( Exists(this.DataController) ) {
	        this.CancelPageSize();
        	this.DataController.Refresh();
        }
  }
  this.ProcessPageSize = function() {
	var pageSizeEdit = this.GetPageSizeEditElement();
	if( Exists(pageSizeEdit) ) {
	        if(!this.Editing) {
        	        pageSizeEdit.focus();
	                this.Editing = true;
		        var pageSizeImage = this.GetApplyPageSizeImage();
        		if( Exists(pageSizeImage) ) pageSizeImage.src = this.ApplyPageSizeSrc;
		}
	}
  }
  this.CancelPageSize = function() {
        if(this.Editing) {
		var pageSizeEdit = this.GetPageSizeEditElement();
		if( Exists(pageSizeEdit) ) {
		        pageSizeEdit.value = this.PageSize;
                	this.Editing = false;
        	}
        	var pageSizeImage = this.GetApplyPageSizeImage()
        	if( Exists(pageSizeImage) ) pageSizeImage.src = this.ProcessPageSizeSrc;
        }
  }
  this.ApplyPageSize = function(){
	var pageSizeEdit = this.GetPageSizeEditElement();
	if( Exists(pageSizeEdit) ) {
		var reg = /^[0-9]+$/;
		if(!reg.test(pageSizeEdit.value)) {
			alert("The size of page must be an integer number");
		} else {
	                this.PageSize = pageSizeEdit.value;
                	this.Editing = false;
                	if(this.AssignOnChangePageSize) __doPostBack(this.Name, "CHANGEPAGESIZE:" + this.PageSize);
	                else if(this.OnChangePageSize) this.OnChangePageSize(this, this.PageSize);
		}
	}
        var pageSizeImage = this.GetApplyPageSizeImage();
        if( Exists(pageSizeImage) ) pageSizeImage.src = this.ProcessPageSizeSrc;
  }
  this.OnPageEditFocus = function(){
  	this.ProcessPageSize();
  }
}

// Class DataNavigatorManager
function dx_DataNavigatorManager()
{
  this.navigators = [];

  this.Initialize = function() {
	for(var i = 0; i < this.navigators.length; i++) {
		this.navigators[i].Initialize();
	}
	if(dxDataNavigator.Inf.ns6) {
		dxDataNavigator.Evt.Attach("window.document.onmousedown", function(e) { dxDataNavigator.Mng.OnMouseDown(e); } );
		window.document.onmousedown = function(e) { dxDataNavigator.Evt.Exec("window.document.onmousedown", e); }
	}
  }
  this.CreateDataNavigator = function() { 
  	var navigator = new dx_DataNavigator(); 
  	this.navigators.Add(navigator);
  	return navigator; 
  }
  this.GetDataNavigator = function(AName) {
	for(var i = 0; i < this.navigators.length; i++)
		if(AName == this.navigators[i].Name) return this.navigators[i];
	return null;
  }
  this.OnMouseDown = function(evt){
	var btn = evt.target;
	if(btn.id != undefined && btn.id.indexOf("_NBFirst_") != -1){ 
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBFirst_")));
		if( Exists(navigator)) navigator.OnFirstClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBPgUp_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBPgUp_")));
		if( Exists(navigator)) navigator.OnPriorPageClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBPrev_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBPrev_")));
		if( Exists(navigator)) navigator.OnPriorClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBChPS_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBChPS_")));
		if( Exists(navigator)) navigator.OnChangePageSizeClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBNext_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBNext_")));
		if( Exists(navigator)) navigator.OnNextClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBPgDn_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBPgDn_")));
		if( Exists(navigator)) navigator.OnNextPageClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBLast_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBLast_")));
		if( Exists(navigator)) navigator.OnLastClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBIns_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBIns_")));
		if( Exists(navigator)) navigator.OnInsertClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBEdit_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBEdit_")));
		if( Exists(navigator)) navigator.OnEditClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBDel_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBDel_")));
		if( Exists(navigator)) navigator.OnDeleteClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBOk_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBOk_")));
		if( Exists(navigator)) navigator.OnPostClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBCancel_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBCancel_")));
		if( Exists(navigator)) navigator.OnCancelClick();
		return;
	}
	if(btn.id != undefined && btn.id.indexOf("_NBRefresh_") != -1) {
                var navigator = this.GetDataNavigator(btn.id.substr(0, btn.id.indexOf("_NBRefresh_")));
		if( Exists(navigator)) navigator.OnRefreshClick();
		return;
	}
  }
}	

function CreateDataNavigator() {
	return dxDataNavigator.Mng.CreateDataNavigator();
}
function OnNBFirstClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnFirstClick();
}
function OnNBPriorPageClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnPriorPageClick();
}
function OnNBPriorClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnPriorClick();
}
function OnNBChangePageSizeClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnChangePageSizeClick();
}
function OnNBNextClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnNextClick();
}
function OnNBNextPageClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnNextPageClick();
}
function OnNBLastClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnLastClick();
}
function OnNBInsertClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnInsertClick();
}
function OnNBEditClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnEditClick();
}
function OnNBDeleteClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnDeleteClick();
}
function OnNBPostClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnPostClick();
}
function OnNBCancelClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnCancelClick();
}
function OnNBRefreshClick(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnRefreshClick();
}
function OnNEFocus(AName) {
        var datanavigator = dxDataNavigator.Mng.GetDataNavigator(AName);
        if( Exists(datanavigator) ) datanavigator.OnPageEditFocus();
}

dxDataNavigator.Evt.Attach("window.onload", function() { dxDataNavigator.Mng.Initialize(); } );
window.onload = function() { dxDataNavigator.Evt.Exec("window.onload"); }
