/*
   ExpressWeb Framework by Developer Express
   ExpressWebGrid

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
var dxGrid = [];
dxGrid["Inf"] = new dx_Info();
dxGrid["Mng"] = new dx_GridManager();
dxGrid["Utl"] = new dx_Utils();
dxGrid["Obj"] = dxGrid.Utl.CreateObjHelper();
dxGrid["Evt"] = new dx_EventManager();
dxGrid["Pos"] = dxGrid.Utl.CreatePosHelper();
dxGrid["DragObj"] = new dx_DragObject();

var BorderCorrect = dxGrid.Inf.ie ? 0 : 2;

var scxNodeImgID = '_NODEIMG_';
var scxSortImgID = '_SORTIMG_';
var scxCellID = '_TD_';
var scxNodeID = '_TR_';
var scxGroupNodeID = '_GTR_';
var scxHeaderNodeID = '_Header_';
var scxGroupPanelNodeID = '_GHeader_';
var scxDragNodeID = '_DHeader_';
var scxGroupUpImageID = 'GUpImage';
var scxGroupDownImageID = 'GDownImage';
var scxCancelBtnID = '_CancelBtn_';
var scxDeleteBtnID = '_DeleteBtn_';
var scxExpandBtnID = '_ExpandBtn_';
var scxInsertBtnID = '_InsertBtn_';
var scxNodeBtnID = '_NodeBtn_';
var scxPostBtnID = '_PostBtn_';
var scxEditorID = '_Editor_';
var scxCancelBtnHandler = 'OnLBCancelCl';
var scxDeleteBtnHandler = 'OnLBDelCl';
var scxExpandBtnHandler = 'OnEBCl';
var scxInsertBtnHandler = 'OnLBInsCl';
var scxNodeBtnHandler = 'OnLBNodeCl';
var scxPostBtnHandler = 'OnLBOkCl';
var scxKeyPressHandler = 'OnEKPrs';

var WebGridGroupPanelInterval = 10;
var WebGridGroupPanelNodeWidth = 100;
var WebGridBitmapHeight = 24;
var WebGridBitmapWidth = 16;
var WebGridExpandBitmapHeight = 12;
var WebGridExpandBitmapWidth = 12;
var WebGridSortBitmapHeight = 16;
var WebGridSortBitmapWidth = 16;
var WebGridGroupBitmapHeight = 11;
var WebGridGroupBitmapWidth = 11;

function GetHandlerElement(SrcElement, ID) {
        var Parent = SrcElement;
        while(Exists(Parent)) {
                if(Exists(Parent.id)) {
                        if(Parent.id.indexOf(ID) != -1) return Parent;
                }
                Parent = Parent.parentNode;
        }
        return null;
}

function dx_Grid()
{
  this.Name = "";
  this.FirstVisibleRow = 0;
  this.PageSize = 0;
  this.Width = 0;
  this.ControlColumnWidth = 0;
  this.BorderWidth = 0;
  this.HeaderHeight = 0;
  this.RowHeight = 0;
  this.KeepRowHeight = false;
  this.HeaderStyle = "";
  this.GroupPanelStyle = "";
  this.ReadOnly = false;
  this.IndicatorStyle = "";
  this.GroupNodesStyle = "";
  this.StatusPanel = "";
  this.SelectedForeColor = "#000000";
  this.SelectedBackColor = "#000000";
  this.LBCursorStyle = false;
  this.AutoWidth = false;
// Visual appearance
  this.ShowGrid = true;
  this.ShowHeader = true;
  this.ShowGroupPanel = true;
  this.ShowGroupedColumns = true;
  this.ShowIndicator = true;
  this.ShowStatusPanel = true;
// Events 
  this.OnRowClick = null;
  this.OnHeaderClick = null;
  this.OnStartDragHeader = null;
  this.OnEndDragHeader = null;
  this.OnIndicatorClick = null;
  this.OnExpandButtonClick = null;
  this.OnGetColumnText = null;
  this.OnGetColumnHref = null;

  this.SavedBackColors = new Array();
  this.SavedForeColors = new Array();
  this.SavedFocusedRow = 0;
  this.SavedFirstVisibleRow = 0;
// Column layout
  this.Columns = new Array();
  this.ColumnCount = 0;
  this.AddColumn = function(AColumn) {
        AColumn.Grid = this;
        AColumn.Index = this.Columns.length;
	this.Columns[this.Columns.length] = AColumn;
        this.ColumnCount = this.Columns.length;
  }
  this.MoveColumn = function(fromIndex, toIndex, needUpdate) {
        if(fromIndex == toIndex) return;
        if(toIndex < 0) toIndex = 0;
        if(toIndex > this.ColumnCount) toIndex = this.ColumnCount;

        var S = "";
        var indexInput = dxGrid.Obj.GetElementById(this.Name + "ColumnIndexes");
        if(Exists(indexInput)) {
	        var ColumnList = new Array();
	        for(var i = 0; i < this.ColumnCount; i ++) ColumnList[i] = this.Columns[i];
	        for(var i = 0; i < this.ColumnCount; i ++)
	        {
	                var Index;
	                if(fromIndex < toIndex) {
	                	
	                        if(i < fromIndex || i > toIndex) Index = i;
	                        else {
	                                if(i > fromIndex && i <= toIndex) Index = i - 1;
	                                else Index = toIndex;
	                        }
	                } else {
	                        if(i < toIndex || i > fromIndex) Index = i;
	                        else {
	                                if(i >= toIndex && i < fromIndex) Index = i + 1;
	                                else Index = toIndex;
	                        }
	                }
	                S = S + Index;
	                if(i != this.ColumnCount - 1) S = S + ":";
	                if(Exists(this.DataController))
	                	if(this.DataController.LoadAllRecords) this.Columns[Index] = ColumnList[i];
	        }
	        indexInput.value = S;
	}
        if(Exists(this.DataController) && needUpdate) {
                if(this.DataController.LoadAllRecords) {
                        this.DataController.ActionName = "UNDEFINED";
                        this.DataControl.Update();
                } else {
                        __doPostBack(this.Name, "");
                }
        }
  }
  this.GetColumnIndexByFieldIndex = function(index) {
        for(var i = 0; i < this.ColumnCount; i ++) {
                if(this.Columns[i].FieldIndex == index) return i;
        }
        return -1;
  }
  this.UpdateFirstVisibleRow = function() {
        if(Exists(this.DataController)) {
                if(this.DataController.RowCount == 0) this.FirstVisibleRow = -1;
                else if(this.DataController.FocusedRow < this.FirstVisibleRow ||
                   this.DataController.FocusedRow >= this.FirstVisibleRow + this.PageSize)
                {
                        if(this.DataController.FocusedRow > this.FirstVisibleRow)
                                this.FirstVisibleRow = this.DataController.FocusedRow - this.PageSize + 1;
                        else
                                this.FirstVisibleRow = this.DataController.FocusedRow;
	                if(this.FirstVisibleRow > this.DataController.RowCount - this.PageSize)
				this.FirstVisibleRow = this.DataController.RowCount - this.PageSize;
			if(this.FirstVisibleRow < 0) this.FirstVisibleRow = 0;
                }
                var firstRowElement = dxGrid.Obj.GetElementById(this.Name + "FirstVisibleRow");
                if(Exists(firstRowElement)) firstRowElement.value = this.FirstVisibleRow;
        }
  }
  this.IsVisibleColumn = function(index) {
        if(Exists(this.DataController))
	        return (this.Columns[index].Visible && (this.ShowGroupedColumns ||
	        	this.DataController.GetItemGroupIndex(this.Columns[index].FieldIndex) == -1));
	else
		return this.Columns[index].Visible;
  }
  this.IsVisibleRow = function(index) {
        return (index >= this.FirstVisibleRow && index < this.FirstVisibleRow + this.PageSize);
  }
  this.LastVisibleColumnIndex = function() {
        for(var i = this.ColumnCount - 1; i >= 0; i --)
                if(this.IsVisibleColumn(i)) return i;
        return -1;
  }
  this.FirstVisibleColumnIndex = function() {
        for(var i = 0; i < this.ColumnCount; i ++)
                if(this.IsVisibleColumn(i)) return i;
        return -1;
  }
  this.GetExpandingColumnCount = function() {
        if(!Exists(this.DataController)) return 0;
        if(this.GetGroupingItemCount() == 0) return 0;
        var Count = 0;
        for(var i = 0; i < this.DataController.RowCount; i ++)  {
                if(!this.IsVisibleRow(i)) continue;
                if(Count < this.DataController.Rows[i].level) Count = this.DataController.Rows[i].level;
        }
        if(Count != this.GetGroupingItemCount()) Count ++;
        return eval(Count);
  }
  this.GetColumnWidth = function(AColumnIndex) {
        if(!Exists(this.DataController)) return this.Columns[AColumnIndex].Width
        if(AColumnIndex == this.FirstVisibleColumnIndex() && this.DataController.LoadAllRecords)
                return (this.Columns[this.FirstVisibleColumnIndex()].Width + this.GetExpandingColumnCount() * this.ControlColumnWidth);
        else
                return this.Columns[AColumnIndex].Width;
  }
  this.GetWidth = function () {
        if(!Exists(this.DataController)) return this.Width;
        var Width = 2 * this.BorderWidth;
        if(this.ShowIndicator) Width += this.ControlColumnWidth;
        Width += this.GetExpandingColumnCount(this) * this.ControlColumnWidth

        for(var i = 0; i < this.ColumnCount; i ++) {
                if(!this.IsVisibleColumn(i)) continue;
                Width += this.Columns[i].Width;
        }
        return Width;
  }

// Data binding
  this.DataControl = null;
  this.DataController = null;

  this.Initialize = function() {
        if(Exists(this.DataControl) && Exists(this.DataController)) return;  
        this.DataControl = dxDataControls.Mng.GetDataControl(this.Name);
        if( Exists(this.DataControl)) this.DataController = dxDataController.Mng.GetDataController(this.DataControl.DataControllerName);
        for(var i = 0; i < this.ColumnCount; i ++) this.Columns[i].Initialize();
  }
  this.Group = function(aColumnIndex, aGroupIndex) {
        if(Exists(this.DataController)) this.DataController.Group(this.Columns[aColumnIndex].FieldIndex, aGroupIndex);
  }
  this.UnGroup = function(aColumnIndex) {
        if(Exists(this.DataController)) this.DataController.UnGroup(this.Columns[aColumnIndex].FieldIndex);
  }
  this.Sort = function(evt, aColumnIndex) {
        if(Exists(this.DataController)) this.DataController.Sort(evt, this.Columns[aColumnIndex].FieldIndex);
  }
  this.Expand = function(evt, ARowIndex) {
        if(Exists(this.DataController)) this.DataController.Expand(evt, ARowIndex);
  }
  this.Delete = function(ARowIndex) {
        if(this.ReadOnly) return;
        if(Exists(this.DataController)) this.DataController.Delete(ARowIndex);
  }
  this.Insert = function() {
        if(this.ReadOnly) return;
        if(Exists(this.DataController)) this.DataController.Insert(this.FocusedRow());
  }
  this.StartEdit = function(ARowIndex) {
        if(this.ReadOnly) return;
        if(Exists(this.DataController)) this.DataController.StartEdit(ARowIndex);
  }
  this.PostEdit = function() {
        if(this.ReadOnly) return;
        if(Exists(this.DataController)) this.DataController.PostEdit(this.Name);
  }
  this.CancelEdit = function() {
        if(Exists(this.DataController)) this.DataController.CancelEdit(true);
  }
  this.MoveTo = function(ARowIndex) {
        if(Exists(this.DataController)) this.DataController.MoveTo(ARowIndex);
  }
  this.EditMode = function() {
        if(this.ReadOnly) return false;
        if(Exists(this.DataController))
                return (this.DataController.ActionName == "STARTEDIT" || this.DataController.ActionName == "INSERT")
        else return false;
  }
  this.FocusedRow = function() {
        if(Exists(this.DataController)) return eval(this.DataController.FocusedRow);
        else return -1;
  }
  this.GetGridGroupingLevel = function() {
        if(!Exists(this.DataController)) return 0;
        return this.DataController.GetGroupingItemCount();
  }
  this.GetGroupingItemCount = function() {
        if(!Exists(this.DataController)) return 0;
        return this.DataController.GetGroupingItemCount();
  }
  this.GetSortingItemCount = function() {
        if(!Exists(this.DataController)) return 0;
        return this.DataController.GetGroupingItemCount();
  }
  this.GetHeaderPanel = function() {
        return dxGrid.Obj.GetElementById(this.Name + "HeaderPanel");
  }
  this.GetHeaderPanelTable = function() {
        return dxGrid.Obj.GetElementById(this.Name + "HeaderPanelTable");
  }
  this.GetHeaderPanelNode = function(Index) {
        return dxGrid.Obj.GetElementById(this.Name + scxHeaderNodeID + Index);
  }
  this.GetGroupPanel = function() {
        return dxGrid.Obj.GetElementById(this.Name + "GroupPanel");
  }
  this.GetGroupPanelTable = function() {
        return dxGrid.Obj.GetElementById(this.Name + "GroupPanelTable");
  }
  this.GetGroupPanelNode = function(Index) {
        return dxGrid.Obj.GetElementById(this.Name + scxGroupPanelNodeID + Index);
  }
  this.GetDataTable = function() {
        return dxGrid.Obj.GetElementById(this.Name + "DataTable");
  }
  this.GetStatusPanelTable = function() {
        return dxGrid.Obj.GetElementById(this.Name + "StatusPanelTable");
  }
  this.GetStatusPanelText = function() {
        return dxGrid.Obj.GetElementById(this.Name + "StatusPanelText");
  }
  this.GetBelongHeaderIndex = function(pt) {
        var headerPanel = this.GetHeaderPanel();
        if(! Exists(headerPanel)) return -1;

	var headerPanelPt = dxGrid.Pos.GetAbsolutePos(headerPanel);
        if(headerPanelPt.y > pt.y || headerPanelPt.y + headerPanel.offsetHeight < pt.y) return -1;
        var currentPos = headerPanelPt.x;
        if(this.ShowIndicator) currentPos += this.ControlColumnWidth;
        if(currentPos > pt.x) return -1;

        var index = 0;
        for(var i = 0; i < this.ColumnCount; i ++)
        {
                if(!this.Columns[i].Visible) continue;
                if(!Exists(this.GetHeaderPanelNode(i))) continue;

                if(currentPos + this.GetColumnWidth(i)/2 > pt.x) return i;
                currentPos += this.GetColumnWidth(i);
                index ++;
        }
        if(currentPos > pt.x) return this.ColumnCount;
        return -1;
  }
  this.GetBelongGroupPanelIndex = function(pt) {
        var groupPanel = this.GetGroupPanelTable();
        if(! Exists(groupPanel)) return -1;

	var groupPanelPt = dxGrid.Pos.GetAbsolutePos(groupPanel);
        if(groupPanelPt.y > pt.y || groupPanelPt.y + groupPanel.offsetHeight < pt.y) return -1;
        var currentPos = groupPanelPt.x + WebGridGroupPanelInterval;

        if(currentPos > pt.x) return -1;
        for(var i = 0; i < this.GetGroupingItemCount(); i ++)
        {
                if(currentPos + WebGridGroupPanelNodeWidth/2 > pt.x) return i;
                currentPos += WebGridGroupPanelNodeWidth + WebGridGroupPanelInterval;
        }

        if(groupPanelPt.x + groupPanel.clientWidth > pt.x) return this.GetGroupingItemCount();
        return -1;
  }
  this.ShowHeaderArrows = function() {
        dxGrid.Pos.SetAbsolutePos(dxGrid.DragObj.ArrowUp, dxGrid.DragObj.ArrowUpX, dxGrid.DragObj.ArrowUpY);
        dxGrid.Pos.SetAbsolutePos(dxGrid.DragObj.ArrowDown, dxGrid.DragObj.ArrowDownX, dxGrid.DragObj.ArrowDownY);
  	dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.ArrowUp, true);
  	dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.ArrowDown, true);
  }
  this.HideHeaderArrows = function() {
  	dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.ArrowUp, false);
  	dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.ArrowDown, false);
  }
  this.UpdateHeaderArrowsPos = function(hIndex, gpIndex) {
        if(hIndex != -1)
        {
                var belongHeader = this.GetHeaderPanelNode(dxGrid.DragObj.HeaderPanelIndex);
                if(Exists(belongHeader))
                {
                        var belongHeaderPt = dxGrid.Pos.GetAbsolutePos(belongHeader);
                        dxGrid.DragObj.ArrowUpX = belongHeaderPt.x - WebGridGroupBitmapWidth / 2;
                        dxGrid.DragObj.ArrowDownX = belongHeaderPt.x - WebGridGroupBitmapWidth / 2;
                        dxGrid.DragObj.ArrowUpY = belongHeaderPt.y + belongHeader.clientHeight;
                        dxGrid.DragObj.ArrowDownY = belongHeaderPt.y - WebGridGroupBitmapHeight;
                }
                else
                {
                        for(var i = dxGrid.DragObj.HeaderPanelIndex; i >=0; i --)
                        {
                                belongHeader = this.GetHeaderPanelNode(i);
                                if(Exists(belongHeader)) break;
                        }
                        if(Exists(belongHeader))
                        {
                                var belongHeaderPt = dxGrid.Pos.GetAbsolutePos(belongHeader);
                                dxGrid.DragObj.ArrowUpX = belongHeaderPt.x + belongHeader.clientWidth - WebGridGroupBitmapWidth / 2;
                                dxGrid.DragObj.ArrowDownX = belongHeaderPt.x + belongHeader.clientWidth - WebGridGroupBitmapWidth / 2;
                                dxGrid.DragObj.ArrowUpY = belongHeaderPt.y + belongHeader.clientHeight;
                                dxGrid.DragObj.ArrowDownY = belongHeaderPt.y - WebGridGroupBitmapHeight;
                        }
                }
        }
        else if(gpIndex != -1)
        {
                var groupPanel = this.GetGroupPanelTable();
                if(Exists(groupPanel)) {
                        var groupPanelPt = dxGrid.Pos.GetAbsolutePos(groupPanel);
                        dxGrid.DragObj.ArrowUpX = groupPanelPt.x + (WebGridGroupPanelNodeWidth + WebGridGroupPanelInterval) * dxGrid.DragObj.GroupPanelIndex;
                        dxGrid.DragObj.ArrowDownX = groupPanelPt.x + (WebGridGroupPanelNodeWidth + WebGridGroupPanelInterval) * dxGrid.DragObj.GroupPanelIndex;;
                        dxGrid.DragObj.ArrowUpY = groupPanelPt.y + WebGridGroupPanelInterval + (dxGrid.DragObj.GroupPanelIndex / 2) * this.HeaderHeight + this.HeaderHeight;
                        dxGrid.DragObj.ArrowDownY = groupPanelPt.y + WebGridGroupPanelInterval + (dxGrid.DragObj.GroupPanelIndex / 2) * this.HeaderHeight - this.HeaderHeight / 2;
                }
        }
  }
  this.StartDragHeader = function(evt, AHeader) {
        if(!dxGrid.DragObj.Dragable) return;

        dxGrid.DragObj.IsDragging = true;
        dxGrid.DragObj.ColumnIndex = AHeader;
        var pt = dxGrid.Pos.GetAbsolutePos(dxGrid.DragObj.SourceElement);
        var eventPt = dxGrid.Pos.EventPoint(evt, window);
        dxGrid.DragObj.Dragable.style.pixelLeft = pt.x;
        dxGrid.DragObj.Dragable.style.pixelTop = pt.y;
        dxGrid.DragObj.Dragable.style.pixelWidth = dxGrid.DragObj.SourceElement.style.pixelWidth;
        dxGrid.DragObj.Dragable.style.pixelHeight = dxGrid.DragObj.SourceElement.style.pixelHeight;
        dxGrid.DragObj.Dragable.innerHTML = dxGrid.DragObj.SourceElement.innerHTML;
        dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, true);
        dxGrid.DragObj.OffsetX = eventPt.x - pt.x;
        dxGrid.DragObj.OffsetY = eventPt.y - pt.y;
        dxGrid.DragObj.Grid = this;
  }
  this.OnHeaderMouseDown = function(evt, AHeader) {
        if(dxGrid.Inf.ie && eval(evt.button & 1) == 0) return false;
        dxGrid.DragObj.SourceElement = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxHeaderNodeID);
        if(Exists(dxGrid.DragObj.SourceElement)) {
                dxGrid.DragObj.IsGrouping = true;
                this.StartDragHeader(evt, AHeader);
	        return true;
        }
        return false;
  }
  this.OnGroupHeaderMouseDown = function(evt, AHeader) {
        if(dxGrid.Inf.ie && eval(evt.button & 1) == 0) return false;
        dxGrid.DragObj.SourceElement = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxGroupPanelNodeID);
        if(Exists(dxGrid.DragObj.SourceElement)) {
                dxGrid.DragObj.IsGrouping = false;
                this.StartDragHeader(evt, AHeader);
	        return true;
        }
        return false;
  }
  this.OnDragHeaderMouseMove = function(evt) {
        if(!dxGrid.Inf.ie || eval(evt.button & 1) != 0)
        {
                var eventPt = dxGrid.Pos.EventPoint(evt, window);
                if(!dxGrid.DragObj.IsMoved)
                {
                        if(this.OnStartDragHeader) this.OnStartDragHeader(this, dxGrid.DragObj.ColumnIndex);
                        var pt = dxGrid.Pos.GetAbsolutePos(dxGrid.DragObj.SourceElement);
                        dxGrid.DragObj.IsMoved = dxGrid.Utl.IsObjectMoved(dxGrid.DragObj.OffsetX, eventPt.x - pt.x,
                          dxGrid.DragObj.OffsetY, eventPt.y - pt.y);
                        if(!dxGrid.DragObj.IsMoved) return; 
                }
		dxGrid.DragObj.Dragable.style.pixelLeft = eventPt.x - dxGrid.DragObj.OffsetX;
                dxGrid.DragObj.Dragable.style.pixelTop = eventPt.y - dxGrid.DragObj.OffsetY;

                dxGrid.DragObj.HeaderPanelIndex = this.GetBelongHeaderIndex(dxGrid.Pos.EventPoint(evt, window));
                dxGrid.DragObj.GroupPanelIndex = this.GetBelongGroupPanelIndex(dxGrid.Pos.EventPoint(evt, window));
                this.UpdateHeaderArrowsPos(dxGrid.DragObj.HeaderPanelIndex, dxGrid.DragObj.GroupPanelIndex);
                if(dxGrid.DragObj.HeaderPanelIndex != -1) {
                        if(dxGrid.DragObj.ColumnIndex < dxGrid.DragObj.HeaderPanelIndex)
                                dxGrid.DragObj.HeaderPanelIndex --;
                        if(this.ShowGroupedColumns && dxGrid.DragObj.IsGrouping) {
                                if(dxGrid.DragObj.ColumnIndex == dxGrid.DragObj.HeaderPanelIndex)
                                        dxGrid.DragObj.HeaderPanelIndex = -1;
                        }
                }
                if(dxGrid.DragObj.HeaderPanelIndex != -1 || dxGrid.DragObj.GroupPanelIndex != -1)
                        this.ShowHeaderArrows();
                else this.HideHeaderArrows();
        }
        else this.OnDragHeaderMouseUp(evt);
  }
  this.OnDragHeaderMouseUp = function(evt) {
        this.HideHeaderArrows();
        dxGrid.DragObj.Dragable.innerHTML = " ";
        dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, false);

        if(dxGrid.DragObj.IsMoved) {
        	if(this.OnEndDragHeader) this.OnEndDragHeader(this, dxGrid.DragObj.ColumnIndex);
                if(dxGrid.DragObj.GroupPanelIndex != -1) {
                        this.Group(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.GroupPanelIndex);
                } else {
                        if(dxGrid.DragObj.HeaderPanelIndex != -1) {
                                if(dxGrid.DragObj.IsGrouping) {
                                        this.MoveColumn(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.HeaderPanelIndex, true);
                                } else {
                                        this.MoveColumn(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.HeaderPanelIndex, false);
                                        if(this.DataController.LoadAllRecords) {
                                                this.UnGroup(dxGrid.DragObj.HeaderPanelIndex);
                                        } else {
                                                this.UnGroup(dxGrid.DragObj.ColumnIndex);
                                        }
                                }
                        }
                }
        } else {
        	if(this.OnHeaderClick) this.OnHeaderClick(this, dxGrid.DragObj.ColumnIndex);
        	this.Sort(evt, dxGrid.DragObj.ColumnIndex);
        }
        dxGrid.DragObj.Clear();
  }
  this.OnExpandClick = function(evt, ANode) {
        if(this.OnExpandButtonClick) this.OnExpandButtonClick(this, ANode);
        this.Expand(evt, ANode);
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnInsertClick = function(evt) {
        if(this.OnIndicatorClick) this.OnIndicatorClick(this, -1, "insert");
        this.Insert();
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnDeleteClick = function(evt, ANode) {
        if(this.OnIndicatorClick) this.OnIndicatorClick(this, ANode, "delete");
        this.Delete(ANode);
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnPostClick = function(evt){
        if(this.OnIndicatorClick) this.OnIndicatorClick(this, -1, "post");
        this.PostEdit();
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnCancelClick = function(evt) {
        if(this.OnIndicatorClick) this.OnIndicatorClick(this, -1, "cancel");
	this.CancelEdit();
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnNodeClick = function(evt, ANode) {
        if(this.OnIndicatorClick) this.OnIndicatorClick(this, ANode, "node");
        if(!(this.EditMode() && this.FocusedRow() == ANode)) this.MoveTo(ANode);
        if(Exists(evt)) evt.cancelBubble = true;
        return false;
  }
  this.OnSimleRowClick = function(evt, ANode) {
        if(this.OnRowClick) this.OnRowClick(this, ANode, false);
	if(!(this.EditMode() && (this.FocusedRow() == ANode))) {
		if(this.FocusedRow() == ANode) {
               		this.StartEdit(ANode);
			return false;
		}
		else this.MoveTo(ANode);
	}
        return false;
  }
  this.OnGroupRowClick = function(evt, ANode) {
        if(this.OnRowClick) this.OnRowClick(this, ANode, true);
        if(!(this.EditMode() && this.FocusedRow() == ANode)) {
                if(this.FocusedRow() == ANode) {
                        this.Expand(evt, ANode);
                        return;
                }
                else this.MoveTo(ANode);
	}
        return false;
  }
  this.OnEditorKeyPress = function(evt){
        switch(evt.keyCode) {
                case 27: {
                        this.CancelEdit();
                        break;
                }
                case 13: {
                        this.PostEdit();
                        break;
                }
        }
  }
}

var scxLTImgID = 'LTImg';
var scxRBImgID = 'RBImg';
var scxGPLT = 'GPLT';
var scxGPRB = 'GPRB';

function dx_GridNS4()
{
  this.inherit = dx_Grid;
  this.inherit();

  this.GetBelongHeaderIndex = function(evt) {
        var left = evt.pageX
        var top = evt.pageY;
        for(var i = 0; i < this.ColumnCount; i ++) {
                if(!this.Columns[i].Visible) continue;
                var LTImg = dxGrid.Obj.GetElementById(this.Name + scxHeaderNodeID + i + scxLTImgID);
                var RBImg = dxGrid.Obj.GetElementById(this.Name + scxHeaderNodeID + i + scxRBImgID);
                if(Exists(LTImg) && Exists(RBImg)) {
        		if(left > LTImg.x && left < RBImg.x && top > LTImg.y && top < RBImg.y)
                                return i;
                }
        }
        return -1;
  }
  this.GetBelongGroupPanelIndex = function(evt) {
	var GPLTImg = dxGrid.Obj.GetElementById(this.Name + scxGPLT);
	var GPRBImg = dxGrid.Obj.GetElementById(this.Name + scxGPRB);
	if(Exists(GPLTImg) && Exists(GPRBImg)) {
                var left = evt.pageX
                var top = evt.pageY;
		if(left > GPLTImg.x && left < GPRBImg.x && top > GPLTImg.y && top < GPRBImg.y) return 0;
	}
        return -1;
  }
  this.StartDragHeader = function(evt, AHeader) {
        dxGrid.DragObj.Dragable = dxGrid.Obj.GetElementById(this.Name + scxDragNodeID + AHeader);
        if(!Exists(dxGrid.DragObj.Dragable)) return;

        dxGrid.DragObj.IsDragging = true;
        dxGrid.DragObj.ColumnIndex = AHeader;
        var LTImg = !dxGrid.DragObj.IsGrouping ?
                dxGrid.Obj.GetElementById(this.Name + scxGroupPanelNodeID + AHeader + scxLTImgID) :
                dxGrid.Obj.GetElementById(this.Name + scxHeaderNodeID + AHeader + scxLTImgID);
        if(Exists(LTImg)) {
            dxGrid.DragObj.Dragable.x = LTImg.x;
            dxGrid.DragObj.Dragable.y = LTImg.y;
        } else {
            dxGrid.DragObj.Dragable.x = evt.target.x;
            dxGrid.DragObj.Dragable.y = evt.target.y;
        }
        dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, true);
        dxGrid.DragObj.Dragable.offX = evt.pageX - dxGrid.DragObj.Dragable.pageX;
        dxGrid.DragObj.Dragable.offY = evt.pageY - dxGrid.DragObj.Dragable.pageY;
        dxGrid.DragObj.Dragable.savemousemove = window.onmousemove;
        dxGrid.DragObj.Dragable.savemouseup = window.onmouseup;
        window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
        window.onmousemove = this.OnDragHeaderMouseMove;
        window.onmouseup = this.OnDragHeaderMouseUp;
        dxGrid.DragObj.Grid = this;
  }
  this.OnHeaderMouseDown = function(evt, AHeader) {
        dxGrid.DragObj.IsGrouping = true;
        this.StartDragHeader(evt, AHeader);
        return false;
  }
  this.OnGroupHeaderMouseDown = function(evt, AHeader) {
        dxGrid.DragObj.IsGrouping = false;
        this.StartDragHeader(evt, AHeader);
        return false;
  }
  this.OnDragHeaderMouseMove = function(evt) {
        if(!Exists(dxGrid.DragObj)) return;
        if(dxGrid.DragObj.IsDragging)
        {
                if(!dxGrid.DragObj.IsMoved)
                {
                        if(dxGrid.DragObj.Grid.OnStartDragHeader) dxGrid.DragObj.Grid.OnStartDragHeader(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                	dxGrid.DragObj.IsMoved = true;
                }
                dxGrid.DragObj.Dragable.x = evt.pageX - dxGrid.DragObj.Dragable.offX;
                dxGrid.DragObj.Dragable.y = evt.pageY - dxGrid.DragObj.Dragable.offY;
        }
        return false;
  }
  this.OnDragHeaderMouseUp = function(evt) {
        if(!Exists(dxGrid.DragObj)) return;
        if(dxGrid.DragObj.IsDragging) {
                window.onmousemove = dxGrid.DragObj.Dragable.savemousemove;
                window.onmouseup = dxGrid.DragObj.Dragable.savemouseup;
                var mask = 0;
                if (!window.onmousemove) mask |= Event.MOUSEMOVE;
                if (!window.onmouseup) mask |= Event.MOUSEUP;
                window.releaseEvents(mask);
                dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, false);

                if(dxGrid.DragObj.IsMoved) {
        		if(dxGrid.DragObj.Grid.OnEndDragHeader) dxGrid.DragObj.Grid.OnEndDragHeader(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                        if(dxGrid.DragObj.IsGrouping) {
                                if(dxGrid.DragObj.Grid.GetBelongGroupPanelIndex(evt) > -1) {
                                        dxGrid.DragObj.Grid.Group(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.Grid.DataController.GetGroupingItemCount());
                                }
                        } else {
                                if(dxGrid.DragObj.Grid.GetBelongHeaderIndex(evt) > -1) {
                                        dxGrid.DragObj.Grid.UnGroup(dxGrid.DragObj.ColumnIndex);
                                }
                        }
                } else {
        		if(dxGrid.DragObj.Grid.OnHeaderClick) dxGrid.DragObj.Grid.OnHeaderClick(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                        dxGrid.DragObj.Grid.Sort(evt, dxGrid.DragObj.ColumnIndex);
                }

                dxGrid.DragObj.Clear();
          }
          return false;
  }
  this.RestoreOldSelection = function(oldNode) {
        var SavedSelection = this.SavedFocusedRow;
        this.SetLeftButtonImage(SavedSelection, GridButtonsImages[0]);
        this.SavedFocusedRow = this.DataController.FocusedRow;
  }
  this.SetNewSelection = function (newNode) {
        this.SetLeftButtonImage(this.FocusedRow(), GridButtonsImages[5]);
  }
}

function dx_GridNS6()
{
  this.inherit = dx_Grid;
  this.inherit();

  this.GetBelongHeaderIndex = function(pt) {
        var panel = this.GetHeaderPanel();
        var panelPt = dxGrid.Pos.GetAbsolutePos(panel);
	if ((pt.x > panelPt.x) && (pt.y > panelPt.y) &&
          (pt.x < panelPt.x + panel.offsetWidth) &&
          (pt.y < panelPt.y + panel.offsetHeight)) return 0;
        else return -1;
  }
  this.GetBelongGroupPanelIndex = function(pt) {
        var panel = this.GetGroupPanelTable();
        var panelPt = dxGrid.Pos.GetAbsolutePos(panel);
	if ((pt.x > panelPt.x) && (pt.y > panelPt.y) &&
          (pt.x < panelPt.x + panel.offsetWidth) &&
          (pt.y < panelPt.y + panel.offsetHeight)) return this.GetGroupingItemCount();
        else return -1;
  }
  this.StartDragHeader = function(evt, AHeader) {
        if(!dxGrid.DragObj.Dragable) return;

        dxGrid.DragObj.IsDragging = true;
        dxGrid.DragObj.ColumnIndex = AHeader;
        var pt = dxGrid.Pos.GetAbsolutePos(dxGrid.DragObj.SourceElement);
        dxGrid.DragObj.Dragable.style.left = pt.x;
        dxGrid.DragObj.Dragable.style.top = pt.y;
        dxGrid.DragObj.Dragable.style.width = dxGrid.DragObj.SourceElement.style.width;
        dxGrid.DragObj.Dragable.style.height = dxGrid.DragObj.SourceElement.style.height;
        dxGrid.DragObj.Dragable.innerHTML = dxGrid.DragObj.SourceElement.innerHTML;
        dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, true);
        dxGrid.DragObj.OffsetX = evt.pageX - pt.x;
        dxGrid.DragObj.OffsetY = evt.pageY - pt.y;
        document.onmousemove = this.OnDragHeaderMouseMove;
        document.onmouseup = this.OnDragHeaderMouseUp;
        dxGrid.DragObj.Grid = this;
  }
  this.OnDragHeaderMouseMove = function(evt) {
        if(!Exists(dxGrid.DragObj)) return;
        if(dxGrid.DragObj.IsDragging)
        {
                if(!dxGrid.DragObj.IsMoved)
                {
                        if(dxGrid.DragObj.Grid.OnStartDragHeader) dxGrid.DragObj.Grid.OnStartDragHeader(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                	dxGrid.DragObj.IsMoved = true;
                }
                dxGrid.DragObj.Dragable.style.left = evt.pageX - dxGrid.DragObj.OffsetX;
                dxGrid.DragObj.Dragable.style.top = evt.pageY - dxGrid.DragObj.OffsetY;
        }
  }
  this.OnDragHeaderMouseUp = function(evt) {
        if(!Exists(dxGrid.DragObj)) return;
        if(dxGrid.DragObj.IsDragging) {
                dxGrid.DragObj.Dragable.innerHTML = "&nbsp;";
                dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, false);
                dxGrid.DragObj.HeaderPanelIndex = dxGrid.DragObj.Grid.GetBelongHeaderIndex(dxGrid.Pos.EventPoint(evt, window));
                dxGrid.DragObj.GroupPanelIndex = dxGrid.DragObj.Grid.GetBelongGroupPanelIndex(dxGrid.Pos.EventPoint(evt, window));

                if(dxGrid.DragObj.IsMoved) {
        		if(dxGrid.DragObj.Grid.OnEndDragHeader) dxGrid.DragObj.Grid.OnEndDragHeader(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                        if(dxGrid.DragObj.IsGrouping) {
                                if(dxGrid.DragObj.GroupPanelIndex > -1) {
                                        dxGrid.DragObj.Grid.Group(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.GroupPanelIndex);
                                }
                        } else {
                                if(dxGrid.DragObj.HeaderPanelIndex > -1) {
                                        dxGrid.DragObj.Grid.UnGroup(dxGrid.DragObj.ColumnIndex);
                                }
                        }
                } else {
        		if(dxGrid.DragObj.Grid.OnHeaderClick) dxGrid.DragObj.Grid.OnHeaderClick(dxGrid.DragObj.Grid, dxGrid.DragObj.ColumnIndex);
                        dxGrid.DragObj.Grid.Sort(evt, dxGrid.DragObj.ColumnIndex);
                }

                dxGrid.DragObj.Clear();
          }
  }
}

function dx_GridOpera()
{
  this.inherit = dx_Grid;
  this.inherit();

  this.GetBelongHeaderIndex = function(pt) {
        var panel = this.GetHeaderPanel();
        var panelPt = dxGrid.Pos.GetAbsolutePos(panel);
	if ((pt.x > panelPt.x) && (pt.y > panelPt.y) &&
          (pt.x < panelPt.x + panel.style.pixelWidth) &&
          (pt.y < panelPt.y + panel.style.pixelHeight)) return 0;
        else return -1;
  }
  this.GetBelongGroupPanelIndex = function(pt) {
        var panel = this.GetGroupPanelTable();
        var panelPt = dxGrid.Pos.GetAbsolutePos(panel);
	if ((pt.x > panelPt.x) && (pt.y > panelPt.y) &&
          (pt.x < panelPt.x + panel.style.pixelWidth) &&
          (pt.y < panelPt.y + panel.style.pixelHeight)) return this.GetGroupingItemCount();
        else return -1;
  }
  this.StartDragHeader = function(evt, AHeader) {
        dxGrid.DragObj.Dragable = dxGrid.Obj.GetElementById(this.Name + scxDragNodeID + AHeader);
        if(!dxGrid.DragObj.Dragable) return;

        dxGrid.DragObj.IsDragging = true;
        dxGrid.DragObj.ColumnIndex = AHeader;
        var pt = dxGrid.Pos.GetAbsolutePos(dxGrid.DragObj.SourceElement);
        var eventPt = dxGrid.Pos.EventPoint(evt, window);
        dxGrid.DragObj.Dragable.style.pixelLeft = pt.x;
        dxGrid.DragObj.Dragable.style.pixelTop = pt.y;
        dxGrid.DragObj.Dragable.style.pixelWidth = dxGrid.DragObj.SourceElement.style.pixelWidth;
        dxGrid.DragObj.Dragable.style.pixelHeight = dxGrid.DragObj.SourceElement.style.pixelHeight;
        dxGrid.DragObj.Dragable.innerHTML = dxGrid.DragObj.SourceElement.innerHTML;
        dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, true);
        dxGrid.DragObj.OffsetX = eventPt.x - pt.x;
        dxGrid.DragObj.OffsetY = eventPt.y - pt.y;
        dxGrid.DragObj.Grid = this;
  }
  this.OnDragHeaderMouseMove = function(evt) {
        if(!dxGrid.DragObj.IsMoved)
        {
                if(this.OnStartDragHeader) this.OnStartDragHeader(this, dxGrid.DragObj.ColumnIndex);
                dxGrid.DragObj.IsMoved = true;
        }
        var eventPt = dxGrid.Pos.EventPoint(evt, window);
        dxGrid.DragObj.Dragable.style.pixelLeft = eventPt.x - dxGrid.DragObj.OffsetX;
        dxGrid.DragObj.Dragable.style.pixelTop = eventPt.y - dxGrid.DragObj.OffsetY;
  }
  this.OnDragHeaderMouseUp = function(evt) {
        if(!Exists(dxGrid.DragObj)) return;
        if(dxGrid.DragObj.IsDragging) {
                dxGrid.Obj.SetElementVisibility(dxGrid.DragObj.Dragable, false);
                dxGrid.DragObj.HeaderPanelIndex = this.GetBelongHeaderIndex(dxGrid.Pos.EventPoint(evt, window));
                dxGrid.DragObj.GroupPanelIndex = this.GetBelongGroupPanelIndex(dxGrid.Pos.EventPoint(evt, window));

                if(dxGrid.DragObj.IsMoved) {
                	if(this.OnEndDragHeader) this.OnEndDragHeader(this, dxGrid.DragObj.ColumnIndex);
                        if(dxGrid.DragObj.GroupPanelIndex > -1) {
                                this.Group(dxGrid.DragObj.ColumnIndex, dxGrid.DragObj.GroupPanelIndex);
                        } else {
                                if(dxGrid.DragObj.HeaderPanelIndex > -1) {
                                        this.UnGroup(dxGrid.DragObj.ColumnIndex);
                                }
                        }
                } else {
                	if(this.OnHeaderClick) this.OnHeaderClick(this, dxGrid.DragObj.ColumnIndex);
                	this.Sort(evt, dxGrid.DragObj.ColumnIndex);
                }
                dxGrid.DragObj.Clear();
        }
  }

}

function dx_PossibleValue(AText, AValue)
{
  this.Text = AText;
  this.Value = AValue;
}

function dx_Column()
{
  this.Grid = null;
  this.Index = -1;
  this.FieldIndex = -1;
  this.Title = "";
  this.CellHint = "";
  this.HeaderHint = "";
  this.ShowCellHint = false;
  this.ShowHeaderHint = false;
  this.Visible = true;
  this.Width = 0;
  this.MinWidth = 0;
  this.HAlignment = "center";
  this.VAlignment = "center";
  this.DefaultStyle = "";
  this.AltDefaultStyle = "";
  this.ReadOnly = false;
  this.WordWrap = true;
  this.Initialize = function() {
  }
  this.Finalize = function() {
  }
  this.GetRowValue = function(rowIndex) {
        return this.Grid.DataController.GetRowValue(rowIndex, this.FieldIndex);
  }
  this.GetRowDisplayText = function(rowIndex) {
  	var Text = this.Grid.DataController.GetRowDisplayText(rowIndex, this.FieldIndex);
  	if(this.Grid.OnGetColumnText) {
  		var NewText = this.Grid.OnGetColumnText(this.Grid, this.Index, rowIndex, Text);
		if(typeof NewText != "undefined") Text = NewText;  		
  	}
        return Text;
  }
  this.GetRowHref = function(rowIndex) {
  	var Href = this.Grid.DataController.GetRowDisplayText(rowIndex, this.FieldIndex);
  	if(this.Grid.OnGetColumnHref) {
  		var NewHref = this.Grid.OnGetColumnHref(this.Grid, this.Index, rowIndex, Href);
		if(typeof NewHref != "undefined") Href = NewHref;  		
  	}
        return Href;
  }
  this.GetRowHint = function(rowIndex) {
        if(this.CellHint == "")
                return this.Grid.DataController.GetRowDisplayText(rowIndex, this.FieldIndex);
        else
                return this.CellHint;
  }
  this.GetDefaultStyle = function(ARowIndex) {
        if((ARowIndex % 2) == 1) return this.AltDefaultStyle;
        return this.DefaultStyle;
  }
  this.FormCellContent = function(ParentEl, rowIndex, IsEditing) {
        if(this.ShowCellHint) ParentEl.title = this.GetRowHint(rowIndex);
        var aTable = document.createElement("TABLE");
        ParentEl.appendChild(aTable);
        aTable.cellSpacing = 0;
        aTable.cellPadding = 0;
        aTable.border = 0;
        aTable.height = "100%";
        aTable.width = "100%";

        var aTBody = document.createElement("TBODY");
        aTable.appendChild(aTBody);
        var aTr = document.createElement("TR");
        aTBody.appendChild(aTr);

        var aTd = document.createElement("TD");
        aTr.appendChild(aTd);
        aTd.align = this.HAlignment;
        if (!IsEditing) aTd.vAlign = this.VAlignment;
        if (!this.WordWrap) aTd.noWrap = true;
        aTd.className = this.GetDefaultStyle(rowIndex);

        aTd.appendChild(this.FormCellTextContent(aTd, rowIndex, IsEditing));
  }
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        var Text = this.FormCellText(rowIndex);

        if (this.Grid.KeepRowHeight || !this.WordWrap) {
          var aDiv = document.createElement("DIV");
          aDiv.style.overflow = "hidden";
          aDiv.style.height = "100%";
          aDiv.style.width = this.Width - 1 - BorderCorrect;
          aDiv.appendChild(Text);
          return aDiv;
        }

        else return Text;
  }
  this.FormCellText = function(rowIndex) {
        var TextNode = document.createTextNode(this.GetRowDisplayText(rowIndex));
        if (TextNode.length == 0) TextNode.data = " ";
        return TextNode;
  }
}

function dx_TextColumn()
{
  this.inherit = dx_Column;
  this.inherit();
  this.inheritFormCellTextContent = this.FormCellTextContent;
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        if(IsEditing) {
                var input = document.createElement("INPUT");
                input.type = "text";
                input.id = this.Grid.Name + scxEditorID + this.Index;
                input.name = this.Grid.Name + scxEditorID + this.Index;
                input.style.width = this.Width - 1 - BorderCorrect;
                input.value = this.GetRowDisplayText(rowIndex);
                if(dxGrid.Inf.ie) input.onkeypress = eval(scxKeyPressHandler);
                return input;
        } else return this.inheritFormCellTextContent(ParentEl, rowIndex, IsEditing);
  }
}

function dx_HyperTextColumn()
{
  this.inherit = dx_TextColumn;
  this.inherit();
  this.inheritFormCellTextContent = this.FormCellTextContent;
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        if(!IsEditing) {
                var aHref = document.createElement("A");
                aHref.className = this.GetDefaultStyle(rowIndex);
                aHref.style.borderWidth = 0;
                aHref.href = this.GetRowHref(rowIndex);
                var Text = this.FormCellText(rowIndex);
                aHref.appendChild(Text);
                return aHref;
        } else return this.inheritFormCellTextContent(ParentEl, rowIndex, IsEditing);
  }
}

function dx_CheckColumn()
{
  this.inherit = dx_Column;
  this.inherit();
  this.CheckedValue = "";
  this.UncheckedValue = "";
  this.UncheckedIsDefault = true;
  this.InputNode = null;
  this.CancelEvent = function() { return false };

  this.inheritFormCellContent = this.FormCellContent;
  this.FormCellContent = function(ParentEl, rowIndex, IsEditing) {
        this.inheritFormCellContent(ParentEl, rowIndex, IsEditing);
        if (this.InputNode != null) {
          var displayText = this.GetRowDisplayText(rowIndex);
          if (typeof(displayText) == "bolean")
            this.InputNode.checked = displayText;
          else
            this.InputNode.checked = (displayText == "true" || displayText == this.CheckedValue) ||
               (!(displayText == "false" || displayText == this.UncheckedValue) && !this.UncheckedIsDefault);
          this.InputNode = null;
        }
  }
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        var input = document.createElement("INPUT");
        input.type = "checkbox";
        if (IsEditing) {
        	input.id = this.Grid.Name + scxEditorID + this.Index;
	        input.name = this.Grid.Name + scxEditorID + this.Index;
		}
        input.value = "1";
        var minCheckSize = 0;
        if (this.Grid.KeepRowHeight)
                minCheckSize = Math.min(this.Grid.RowHeight, this.Width);
        else minCheckSize = this.Width;
        if (minCheckSize > 13) minCheckSize = 13;
        input.style.width = minCheckSize;
        input.style.height = minCheckSize;
        if(dxGrid.Inf.ie) {
          if (IsEditing) input.onkeypress = eval(scxKeyPressHandler);
          else input.onclick = this.CancelEvent;
        }
        this.InputNode = input;
        return input;
  }
}

function dx_ListColumn()
{
  this.inherit = dx_Column;
  this.inherit();
  this.PossibleValues = new Array();
  this.AddPossibleValue = function(AText, AValue) {
        this.PossibleValues[this.PossibleValues.length] = new dx_PossibleValue(AText, AValue);
  }
  this.inheritFormCellTextContent = this.FormCellTextContent;
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        if(IsEditing) {
                var select = document.createElement("SELECT");
                select.id = this.Grid.Name + scxEditorID + this.Index;
                select.name = this.Grid.Name + scxEditorID + this.Index;
                select.size = 1;
                select.style.width = this.Width - 1 - BorderCorrect;
                if(dxGrid.Inf.ie) select.onkeypress = eval(scxKeyPressHandler);

                for(var i = 0; i < this.PossibleValues.length; i ++){
                        var option = document.createElement("OPTION");
                        select.appendChild(option);
                        option.value = this.PossibleValues[i].Value;
                        option.innerHTML = this.PossibleValues[i].Text;
                }
                select.selectedIndex = -1;
                for(var i = 0; i < select.options.length; i ++) {
                        if(this.GetRowDisplayText(rowIndex) == select.options[i].value) {
                                select.selectedIndex = i;
                                break;
                        }
                }
                return select;
        }  else return this.inheritFormCellTextContent(ParentEl, rowIndex, IsEditing);
  }
  this.FormCellText = function(rowIndex) {
  	var Text = this.GetRowDisplayText(rowIndex);
        for(var i = 0; i < this.PossibleValues.length; i ++) {
                if(Text == this.PossibleValues[i].Value) {
                        Text = this.PossibleValues[i].Text;
                        break;
                }
        }        
        var TextNode = document.createTextNode(Text);
        if (TextNode.length == 0) TextNode.data = " ";
        return TextNode;
  }
}

/* class */
function dx_Image(Img)
{
	this.fwidth = 0;
	this.fheight = 0;
        this.Width = function() {
          if (this.fwidth == 0)
            this.fwidth = this.Img.width;
          return this.fwidth;
        }
        this.Height = function() {
          if (this.fheight == 0)
            this.fheight = this.Img.height;
          return this.fheight;
        }
        this.Img = Img;
	return this;
}

function dx_ImageColumn()
{
  this.inherit = dx_Column;
  this.inherit();
  this.Images = [];

  this.AddImage = function(AURL) {
        var Image = new dx_Image(document.createElement("img"));
        Image.Img.src = AURL;
        Image.Img.style.position = "absolute";
        dxGrid.Obj.SetElementVisibility(Image.Img, false);
	this.Images[this.Images.length] = Image;
  }

  this.Initialize = function() {
	for(var i = 0; i < this.Images.length; i++) {
                if(!Exists(this.Images[i].Img.parentElement))
                        document.body.appendChild(this.Images[i].Img);
        }
  }
  this.Finalize = function() {
	for(var i = 0; i < this.Images.length; i++) {
                var Image = this.Images[i].Img;
                if(Exists(Image) && Exists(Image.parentElement))
                        Image.parentElement.removeChild(Image);
        }
  }
  this.inheritFormCellContent = this.FormCellContent;
  this.FormCellContent = function(ParentEl, rowIndex, IsEditing) {
        this.inheritFormCellContent(ParentEl, rowIndex, IsEditing);
        var Image = this.Images[this.Grid.DataController.GetRowRecord(rowIndex)];
        var Rel = Image.Width()/Image.Height();

        if (!Exists(Image)) return;
        Image.Img.style.height = Image.Height();
        Image.Img.style.width = Image.Width();
        if (IsEditing) {
          if (Image.Height() > this.Grid.RowHeight) {
            Image.Img.style.height = "100%";
            Image.Img.style.width = Image.Img.style.pixelHeight*Rel;
          }
        } else {
          if (this.Grid.KeepRowHeight) {
            Image.Img.style.height = this.Grid.RowHeight;
            Image.Img.style.width = this.Grid.RowHeight*Rel;
          }
          else
            if (Image.Width() > this.Width) {
              Image.Img.style.width = "100%";
              Image.Img.style.height = Image.Img.style.pixelWidth/Rel;
            }
        }
        dxGrid.Obj.SetElementVisibility(Image.Img, true);
  }
  this.FormCellTextContent = function(ParentEl, rowIndex, IsEditing) {
        var Image = this.Images[this.Grid.DataController.GetRowRecord(rowIndex)];

        var aDiv = document.createElement("DIV");
        aDiv.style.overflow = "hidden";
        if (IsEditing) aDiv.style.height = "100%";
        else if (this.Grid.KeepRowHeight && (Image.Height() > this.Grid.RowHeight))
          aDiv.style.height = this.Grid.RowHeight;
        aDiv.style.width = this.Width - BorderCorrect;

        if (Exists(Image)) {
          Image.Img.align = "absmiddle";
          Image.Img.hspace = 0;
          Image.Img.vspace = 0;
          Image.Img.style.position = "static";
          aDiv.appendChild(Image.Img);
        }
        return aDiv;
  }
}

function dx_DragObject()
{
  this.IsDragging = false;
  this.ColumnIndex = -1;
  this.SourceElement = null;
  this.CurrentX = 0;
  this.CurrentY = 0;
  this.IsMoved = false;
  this.IsGrouping = false;
  this.DragGroupIndex = -1;
  this.DragUngroupIndex = -1;
  this.Grid = null;

  this.Dragable = null;
  this.ArrowUp = null;
  this.ArrowDown = null;
  this.ArrowUpX = 0;
  this.ArrowDownX = 0;
  this.ArrowUpY = 0;
  this.ArrowDownY = 0;

  this.Clear = function() {
          this.IsDragging = false;
          this.ColumnIndex = -1;
          this.SourceElement = null;
          this.CurrentX = 0;
          this.CurrentY = 0;
          this.IsMoved = false;
          this.IsGrouping = false;
          this.HeaderPanelIndex = -1;
          this.GroupPanelIndex = -1;
          this.Grid = null;
  }
  this.Initialize = function() {
        this.Dragable = dxGrid.Obj.GetElementById(scxDragNodeID);
        this.ArrowUp = dxGrid.Obj.GetElementById(scxGroupUpImageID);
        this.ArrowDown = dxGrid.Obj.GetElementById(scxGroupDownImageID);
  }
}

function dx_GridManager()
{
  this.grids = [];

  this.Initialize = function() {
  	dxGrid.DragObj.Initialize();
	for(var i = 0; i < this.grids.length; i++) {
		this.grids[i].Initialize();
	}
	if(dxGrid.Inf.ns6) {
		dxGrid.Evt.Attach("window.document.onmousedown", function(e) { dxGrid.Mng.OnMouseDown(e); } );
		window.document.onmousedown = function(e) { dxGrid.Evt.Exec("window.document.onmousedown", e); }
	}
  }
  this.CreateGrid = function() {
  	var grid = dxGrid.Inf.ns4 ? new dx_GridNS4() : dxGrid.Inf.ns6 ? new dx_GridNS6() : dxGrid.Inf.op ? new dx_GridOpera() : new dx_Grid();
  	this.grids.Add(grid);
  	return grid;
  }
  this.CreateGridPainter = function(AGrid) {
  	var grid = dxGrid.Inf.ns4 ? new dx_GridPainterNS4(AGrid) :
          dxGrid.Inf.ns6 ? new dx_GridPainterNS6(AGrid) : dxGrid.Inf.op ? new dx_GridPainterOpera(AGrid) :
          new dx_GridPainter(AGrid);
  	return grid;
  }
  this.GetGrid = function(AName) {
	for(var i = 0; i < this.grids.length; i++)
		if(AName == this.grids[i].Name) return this.grids[i];
	return null;
  }
  this.OnMouseDown = function(evt){
	var handlerElement, Name, Index;
        evt = dxGrid.Inf.GetEvent(evt);
        var element = dxGrid.Inf.GetSrcElement(evt);
        handlerElement = GetHandlerElement(element, scxExpandBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxExpandBtnID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxExpandBtnID) + scxExpandBtnID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnExpandClick(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxInsertBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxInsertBtnID));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnInsertClick(evt);
		return;
	}
        handlerElement = GetHandlerElement(element, scxDeleteBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxDeleteBtnID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxDeleteBtnID) + scxDeleteBtnID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnDeleteClick(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxPostBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxPostBtnID));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnPostClick(evt);
		return;
	}
        handlerElement = GetHandlerElement(element, scxCancelBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxCancelBtnID));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnCancelClick(evt);
		return;
	}
        handlerElement = GetHandlerElement(element, scxNodeBtnID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxNodeBtnID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxNodeBtnID) + scxNodeBtnID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnNodeClick(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxNodeID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxNodeID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxNodeID) + scxNodeID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnSimleRowClick(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxGroupNodeID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxGroupNodeID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxGroupNodeID) + scxGroupNodeID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnGroupRowClick(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxHeaderNodeID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxHeaderNodeID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxHeaderNodeID) + scxHeaderNodeID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnHeaderMouseDown(evt, Index);
		return;
	}
        handlerElement = GetHandlerElement(element, scxGroupPanelNodeID);
	if(handlerElement)
	{
                Name = handlerElement.id.substr(0, handlerElement.id.indexOf(scxGroupPanelNodeID));
                Index = eval(handlerElement.id.substr(handlerElement.id.indexOf(scxGroupPanelNodeID) + scxGroupPanelNodeID.length));
                var grid = dxGrid.Mng.GetGrid(Name);
                if( Exists(grid) ) grid.OnGroupHeaderMouseDown(evt, Index);
		return;
	}
  }
  this.OnMouseMove = function(evt){
        if(dxGrid.Inf.ie || dxGrid.Inf.op) {
                if(Exists(dxGrid.DragObj.Grid)) dxGrid.DragObj.Grid.OnDragHeaderMouseMove(evt);
        }
  }
  this.OnSelectStart = function(evt){
        evt = dxGrid.Inf.GetEvent(evt);
        if(Exists(dxGrid.DragObj)) {
                if(dxGrid.DragObj.IsDragging) {
                        if(Exists(evt)) {
                                evt.cancelBubble = true;
                                evt.returnValue = false;
                        }
                        return false;
                }
        }
  }
}

function CreateGrid() {
	return dxGrid.Mng.CreateGrid();
}
function OnHMDown(evt, AName, AHeader) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var header = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxHeaderNodeID);
                if(Exists(header)) {
                        AName = header.id.substr(0, header.id.indexOf(scxHeaderNodeID));
                        AHeader = header.id.substr(header.id.indexOf(scxHeaderNodeID) + scxHeaderNodeID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnHeaderMouseDown(evt, AHeader);
        }
}
function OnGHMDown(evt, AName, AHeader) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var header = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxGroupPanelNodeID);
                if(Exists(header)) {
                        AName = header.id.substr(0, header.id.indexOf(scxGroupPanelNodeID));
                        AHeader = header.id.substr(header.id.indexOf(scxGroupPanelNodeID) + scxGroupPanelNodeID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnGroupHeaderMouseDown(evt, AHeader);
        }
}
function OnDHMMove(evt) {
        evt = dxGrid.Inf.GetEvent(evt);
        if(Exists(dxGrid.DragObj.Grid)) {
                dxGrid.DragObj.Grid.OnDragHeaderMouseMove(evt);
        }
}
function OnDHMUp(evt) {
        evt = dxGrid.Inf.GetEvent(evt);
        if(Exists(dxGrid.DragObj.Grid)) {
                dxGrid.DragObj.Grid.OnDragHeaderMouseUp(evt);
        }
}
function OnEBCl(evt, AName, ANode) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var expandButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxExpandBtnID);
                if(Exists(expandButton)) {
        		AName = expandButton.id.substr(0, expandButton.id.indexOf(scxExpandBtnID));
                        ANode = expandButton.id.substr(expandButton.id.indexOf(scxExpandBtnID) + scxExpandBtnID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnExpandClick(evt, ANode);
        }
}
function OnLBInsCl(evt, AName) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var insertButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxInsertBtnID);
                if(Exists(insertButton)) {
        		AName = insertButton.id.substr(0, insertButton.id.indexOf(scxInsertBtnID));
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnInsertClick(evt);
        }
}
function OnLBDelCl(evt, AName, ANode) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var deleteButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxDeleteBtnID);
                if(Exists(deleteButton)) {
        		AName = deleteButton.id.substr(0, deleteButton.id.indexOf(scxDeleteBtnID));
                        ANode = deleteButton.id.substr(deleteButton.id.indexOf(scxDeleteBtnID) + scxDeleteBtnID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnDeleteClick(evt, ANode);
        }
}
function OnLBOkCl(evt, AName) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var postButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxPostBtnID);
                if(Exists(postButton)) {
        		AName = postButton.id.substr(0, postButton.id.indexOf(scxPostBtnID));
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnPostClick(evt);
        }
}
function OnLBCancelCl(evt, AName){
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var cancelButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxCancelBtnID);
                if(Exists(cancelButton)) {
        		AName = cancelButton.id.substr(0, cancelButton.id.indexOf(scxCancelBtnID));
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnCancelClick(evt);
        }
}
function OnLBNodeCl(evt, AName, ANode) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var nodeButton = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxNodeBtnID);
                if(Exists(nodeButton)) {
        		AName = nodeButton.id.substr(0, nodeButton.id.indexOf(scxNodeBtnID));
                        ANode = nodeButton.id.substr(nodeButton.id.indexOf(scxNodeBtnID) + scxNodeBtnID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnNodeClick(evt, ANode);
        }
}
function OnTRCl(evt, AName, ANode) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var tr = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxNodeID);
                if(Exists(tr)) {
        		AName = tr.id.substr(0, tr.id.indexOf(scxNodeID));
                        ANode = tr.id.substr(tr.id.indexOf(scxNodeID) + scxNodeID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnSimleRowClick(evt, ANode);
        }
}
function OnGTRCl(evt, AName, ANode) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var tr = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxGroupNodeID);
                if(Exists(tr)) {
        		AName = tr.id.substr(0, tr.id.indexOf(scxGroupNodeID));
                        ANode = tr.id.substr(tr.id.indexOf(scxGroupNodeID) + scxGroupNodeID.length);
                }
	}
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnGroupRowClick(evt, ANode);
        }
}
function OnEKPrs(evt, AName) {
        evt = dxGrid.Inf.GetEvent(evt);
	if(!Exists(AName)) {
        	var editor = GetHandlerElement(dxGrid.Inf.GetSrcElement(evt), scxEditorID);
                AName = editor.id.substr(0, editor.id.indexOf(scxEditorID));
        }
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnEditorKeyPress(evt);
        }
}


function OnEBClNS4(AName, ANode) {
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnExpandClick(null, ANode);
        }
}
function OnLBOkClNS4(AName) {
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnPostClick(null);
        }
}
function OnLBCancelClNS4(AName){
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnCancelClick(null);
        }
}
function OnLBNodeClNS4(AName, ANode) {
	if(Exists(AName)) {
                var grid = dxGrid.Mng.GetGrid(AName);
                if( Exists(grid) ) grid.OnNodeClick(null, ANode);
        }
}


if(!dxGrid.Inf.ns4) {
  dxGrid.Evt.Attach("window.document.body.onselectstart", function(e) { dxGrid.Mng.OnSelectStart(e); } );
  window.document.body.onselectstart = function(e) { dxGrid.Evt.Exec("window.document.body.onselectstart", dxGrid.Inf.GetEvent(e)); }
}
dxGrid.Evt.Attach("window.document.onmousemove", function(e) { dxGrid.Mng.OnMouseMove(e); } );
window.document.onmousemove = function(e) { dxGrid.Evt.Exec("window.document.onmousemove", dxGrid.Inf.GetEvent(e)); }
dxGrid.Evt.Attach("window.onload", function() { dxGrid.Mng.Initialize(); } );
window.onload = function() { dxGrid.Evt.Exec("window.onload"); }
