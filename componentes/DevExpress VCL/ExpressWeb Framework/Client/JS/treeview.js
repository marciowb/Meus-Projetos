/* 
   ExpressWeb Framework by Developer Express
   ExpressWebTreeView

   Copyright (c) 2000-2004 Developer Express Inc.
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and   
   International Copyright Laws. Unauthorized reproduction,     
   reverse-engineering, and distribution of all or any portion of   
   the code contained in this file is strictly prohibited and may  
   result in severe civil and criminal penalties and will be        
   prosecuted to the maximum extent possible under the law.
*/

var dxTreeView = [];
dxTreeView["Inf"] = new dx_Info();
dxTreeView["Utl"] = new dx_Utils();
dxTreeView["Mng"] = new dx_TreeViewManager();
dxTreeView["Obj"] = dxTreeView.Utl.CreateObjHelper();

function dx_TreeView()
{
  this.Name = "";
  this.ForcePostBack = false;
  this.ColImg = "";
  this.ExpImg = "";
  this.ColTitle = "";
  this.ExpTitle = "";
  
  this.StoreState = function (NodeName, State) {
  	var storage = dxTreeView.Obj.GetElementById(this.Name + "_EXPANDSTATE");
  	var pos = storage.value.indexOf(NodeName + "=");
  	var value = storage.value;
  	var newValue = NodeName + "=" + State + ",";
  	if (pos == -1) storage.value = value + newValue;
  	else storage.value = value.substring(0, pos) + newValue + value.substring(pos + newValue.length, value.length + 1); 
  }
  this.NodeClick = function (e, PBFlag) {
	if (dxTreeView.Inf.ns6) { 
  		var nodeName = dxTreeView.Inf.GetSrcElement(e).parentNode.parentNode.parentNode.id;
    		if(this.OnTreeItemClick) this.OnTreeItemClick(this, nodeName);
    		if(PBFlag) __doPostBack(this.Name, "CLICK:" + nodeName);
  	} else {
  		eTarget = dxTreeView.Inf.GetSrcElement(e);
    		if (eTarget.parentElement.tagName == "A") {
      			var nodeName = eTarget.parentElement.parentElement.id;
      			if (eTarget.tagName == "IMG") this.ToggleNode(nodeName);
      			else {
      				if(this.OnTreeItemClick) this.OnTreeItemClick(this, nodeName);
        			if ((eTarget.tagName == "SPAN") && PBFlag) {
                                        __doPostBack(this.Name, "CLICK:" + nodeName);
                                }
        		}
        	}
        }
  }
  this.ToggleNode = function (NodeName) {
  	if(this.ForcePostBack) __doPostBack(this.Name, "TOGGLE:" + NodeName)
  	else {
    		var BtnImg = dxTreeView.Obj.GetElementById(NodeName + "_Img");
    		var Block = dxTreeView.Obj.GetElementById("Sub_" + NodeName);
		if( !Exists(Block)) return;

    		if (Block.style.display == "") {
      			var AllowAction = true;
      			if(this.OnTreeItemCollapse) {
      				AllowAction = this.OnTreeItemCollapse(this, NodeName);
      				if(typeof AllowAction == "undefined") AllowAction = true;
      			}
      			if(AllowAction == true) {
        			Block.style.display = "none";
        			if( Exists(BtnImg) ) {
          				BtnImg.src = this.ColImg;
          				BtnImg.alt = this.ColTitle;
          			}
          			this.StoreState(NodeName, "0");
          		}
          	} else {
      			var AllowAction = true;
      			if(this.OnTreeItemExpand) {
      				AllowAction = this.OnTreeItemExpand(this, NodeName);
				if(typeof AllowAction == "undefined") AllowAction = true;
      			}
      			if(AllowAction == true) {
      				Block.style.display = ""; 
      				if( Exists(BtnImg) ) {
      					BtnImg.src = this.ExpImg;
      					BtnImg.alt = this.ExpTitle;
      				}
      				this.StoreState(NodeName, "1");
      			}
      		}
  	}
  }
// Events
  this.OnTreeItemClick = null;
  this.OnTreeItemCollapse = null;
  this.OnTreeItemExpand = null;
}

// Class TreeViewManager
function dx_TreeViewManager()
{
  this.treeviews = [];

  this.CreateTreeView = function() { 
  	var treeview = new dx_TreeView(); 
  	this.treeviews.Add(treeview);
  	return treeview; 
  }
  this.GetTreeView = function(AName) {
	for(var i = 0; i < this.treeviews.length; i++)
		if(AName == this.treeviews[i].Name) return this.treeviews[i];
	return null;
  }
}

function CreateTreeView() {
	return dxTreeView.Mng.CreateTreeView();
}
function TreeNodeClick(TreeName, e, PBFlag) {
	var treeview = dxTreeView.Mng.GetTreeView(TreeName);
	if( Exists(treeview) ) treeview.NodeClick(e, PBFlag);
}
function TreeNodeToggle(TreeName, NodeName) {
	var treeview = dxTreeView.Mng.GetTreeView(TreeName);
	if( Exists(treeview) ) treeview.ToggleNode(NodeName);		
}	
