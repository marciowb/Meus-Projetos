/*
   ExpressWeb Framework by Developer Express
   ExpressWebDataSource

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
var dxDataController = [];
dxDataController["Inf"] = new dx_Info();
dxDataController["Mng"] = new dx_DataControllerManager();
dxDataController["Utl"] = new dx_Utils();
dxDataController["Obj"] = dxDataController.Utl.CreateObjHelper();
dxDataController["Evt"] = new dx_EventManager();

var scxUndefinedAction = 'UNDEFINED';
var scxSortingAction = 'SORT';
var scxGroupingAction = 'GROUP';
var scxUnGroupingAction = 'UNGROUP';
var scxExpandingAction = 'EXPAND';
var scxDeleteAction = 'DELETE';
var scxStartEditAction = 'STARTEDIT';
var scxPostEditAction = 'POSTEDIT';
var scxCancelEditAction = 'CANCELEDIT';
var scxInsertAction = 'INSERT';
var scxRefreshAction = 'REFRESH';
var scxMoveToAction = 'MOVETO';
var scxMoveByAction = 'MOVEBY';

function dx_Key(AValue, ALevel)
{
  this.Value = AValue;
  this.Level = ALevel;
}

function dx_Data(AValue, ADislayText)
{
  this.Value = AValue;
  this.DisplayText = Exists(ADislayText) ? ADislayText : AValue;
}

function dx_Row()
{
  this.expanded = false;
  this.level = 0;
  this.recordIndex = -1;
  this.globalIndex = 0;
}

function dx_DataController()
{
  this.DataEngine = new dx_DataEngine(this);

  this.Name = "";
  this.LoadAllRecords = false;
  this.FocusedRow = 0;
  this.ItemCount = 0;
  this.Ready = false;
// Data
  this.DisplayTexts = new Array();
  this.Values = new Array();
  this.RecordCount = 0;
  this.Rows = new Array();
  this.RowCount = 0;
  this.AddRecord = function(AKey, ARecord) {
        var recordNumber = this.Values.length;
        this.Values[recordNumber] = new Array(this.ItemCount);
        this.DisplayTexts[recordNumber] = new Array(this.ItemCount);
        this.Keys[this.Keys.length] = AKey;
        for(var i = 0; i < this.ItemCount; i ++) {
                switch(ARecord[i].length) {
                        case 0: {
                                this.Values[recordNumber][i] = null;
                                this.DisplayTexts[recordNumber][i] = "";
                                break;
                        }
                        case 1: {
                                this.Values[recordNumber][i] = ARecord[i][0];
                                this.DisplayTexts[recordNumber][i] = (ARecord[i][0] == null) ? "" : ARecord[i][0];
                                break;
                        }
                        default: {
                                this.Values[recordNumber][i] = ARecord[i][0];
                                this.DisplayTexts[recordNumber][i] = (ARecord[i][1] == null) ? "" : ARecord[i][1];
                                break;
                        }
                }
        }
        this.RecordCount = this.Values.length;
  }
  this.GroupingItemCount = 0;
  this.SortingItemCount = 0;
// Keys layout
  this.KeyField = -1;
  this.KeyValue = "";
  this.KeyLevel = 0;
  this.Keys = new Array();
  this.AddKey = function(ARowIndex, AValue, ALevel) {
        this.Keys[ARowIndex] = new dx_Key(AValue, ALevel);
  }
  this.UpdateKeyValues = function(ARowIndex) {
        if(this.LoadAllRecords) {
                if(Exists(this.Rows[ARowIndex])) {
                        this.KeyValue = this.Keys[this.GetRowRecord(ARowIndex)];
                        this.KeyLevel = this.Rows[ARowIndex].level;
                }
        } else {
                if(Exists(this.Keys[ARowIndex])) {
                        this.KeyValue = this.Keys[ARowIndex].Value;
                        this.KeyLevel = this.Keys[ARowIndex].Level;
                }
        }
  }
// Clients layout
  this.clients = [];
  this.RegisterClient = function(AClient) {
        this.clients[this.clients.length] = AClient;
  }
  this.NeedUpdate = function(ANewFocusedRow) {
        for(var i = 0; i < this.clients.length; i ++) {
                var client = this.clients[i];
                if(Exists(client.NeedUpdate)) {
                        var Result = client.NeedUpdate(ANewFocusedRow);
                        if(Result == true) return true;
                }
        }
        return false;
  }
  this.UpdateClients = function() {
  	if(0 > this.FocusedRow || this.FocusedRow >= this.RowCount) return;
        for(var i = 0; i < this.clients.length; i ++) {
                var client = this.clients[i];
                if(Exists(client.Update)) client.Update();
        }
  }


  this.AllowEditing = true;
  this.AllowGrouping = true;
  this.AllowSorting = true;
  this.AllowExpanding = true;
// Sever events
  this.AssignOnChangeFocus = true;
  this.AssignOnGroup = true;
  this.AssignOnUnGroup = true;
  this.AssignOnSort = true;
  this.AssignOnExpand = true;
  this.AssignOnEdit = true;
  this.AssignOnCancelEdit = true;

  this.GetIsEditingElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "IsEditing");
  }
  this.GetIsInsertingElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "IsInserting");
  }
  this.GetFocusingInfoElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "FocusedRow");
  }
  this.GetExpandingInfoElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "ExpandingInfo");
  }
  this.GetGroupingInfoElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "GroupingInfo");
  }
  this.GetSortingInfoElement = function() {
  	return dxDataController.Obj.GetElementById(this.Name + "SortingInfo");
  }
  this.LoadFocusingInfo = function() {
  	var element = this.GetFocusingInfoElement();
  	if( Exists(element) ) this.FocusedRow = + element.value;
  }
  this.LoadExpandingInfo = function() {
  	var element = this.GetExpandingInfoElement();
        if(Exists(element) && this.AllowExpanding) {
                  S = element.value;
                  while(true) {
                          this.DataEngine.expandingArray[this.DataEngine.expandingArray.length] = (eval(S.substring(0, S.indexOf(";"))) == 1);
                          S = S.substr(S.indexOf(";") + 1);
                          if(S == "") break;
                  }
          } else {
                  for(var i = 0; i < this.RowCount; i ++) {
                          this.DataEngine.expandingArray[i] = false;
                  }
          }
  }
  this.LoadGroupingInfo = function() {
  	var element = this.GetGroupingInfoElement();
        if(Exists(element) && this.AllowGrouping) {
                S = element.value;
                for(var i = 0; i < this.ItemCount; i ++) {
                        this.DataEngine.groupingArray[i] = eval(S.substring(0, S.indexOf(";")));
                        S = S.substr(S.indexOf(";") + 1);
                }
        } else {
                for(var i = 0; i < this.ItemCount; i ++) {
                        this.DataEngine.groupingArray[i] = -1;
                }
        }
  }
  this.LoadSortingInfo = function() {
  	var element = this.GetSortingInfoElement();
        if(Exists(element) && this.AllowSorting) {
                var S = element.value;
                for(var i = 0; i < this.ItemCount; i ++) {
                        this.DataEngine.sortingArray[i] = new SortingArrayItem();
                        this.DataEngine.sortingArray[i].sortingIndex = eval(S.substring(0, S.indexOf(";")));
                        S = S.substr(S.indexOf(";") + 1);
                        this.DataEngine.sortingArray[i].sortingOrder = eval(S.substring(0, S.indexOf(";")));
                        S = S.substr(S.indexOf(";") + 1);
                }
        } else {
                for(var i = 0; i < this.ItemCount; i ++) {
                        this.DataEngine.sortingArray[i] = new SortingArrayItem();
                        this.DataEngine.sortingArray[i].sortingIndex = -1;
                        this.DataEngine.sortingArray[i].sortingOrder = soNone;
                }
        }
  }

  this.Initialize = function() {
        var element = this.GetIsEditingElement();
        if(Exists(element)) if(element.value == "true") this.ActionName = scxStartEditAction;
        var element = this.GetIsInsertingElement();
        if(Exists(element)) if(element.value == "true") this.ActionName = scxInsertAction;
	this.LoadFocusingInfo();
        if(this.LoadAllRecords) {
		this.LoadSortingInfo();
		this.LoadGroupingInfo();
		this.LoadExpandingInfo();

                this.DataEngine.UpdateGlobalSortingArray();
                this.DataEngine.UpdateRowInfo(true);
                this.DataEngine.LoadExpandingInfo();
        }
  	if(!this.LoadAllRecords || !this.IsEditing())
          this.UpdateClients();
        this.Ready = true;
  }
  this.SyncronizeFocusingInfo = function() {
  	var element = this.GetFocusingInfoElement();
  	if( Exists(element) ) element.value = this.FocusedRow;
  }
  this.SyncronizeExpandingInfo = function() {
        if(!this.AllowExpanding) return;
  	var element = this.GetExpandingInfoElement();
        if( Exists(element) ) {
	        this.DataEngine.SaveExpandingInfo();
        	var S = "";
        	for(var i = 0; i < this.RowCount; i ++) {
                	if(this.Rows[i].expanded == true) S += "1;";
                	else S += "0;";
        	}
	        element.value = S;
	}
  }
  this.SyncronizeGroupingInfo = function() {
        if(!this.AllowGrouping) return;
  	var element = this.GetGroupingInfoElement();
        if( Exists(element) ) {
        	var S = "";
        	for(var i = 0; i < this.ItemCount; i ++) S += this.DataEngine.GetItemGroupIndex(i) + ";"
	        element.value = S;
	}
  }
  this.SyncronizeSortingInfo = function() {
        if(!this.AllowSorting) return;
  	var element = this.GetSortingInfoElement();
        if( Exists(element) ) {
        	var S = "";
        	for(var i = 0; i < this.ItemCount; i ++) {
	                S += this.DataEngine.GetItemSortIndex(i) + ";"
        	        S += this.DataEngine.GetItemSortOrder(i) + ";"
		}
        	element.value = S;
        }
  }
  this.CheckFocusedRow = function() {
        if(this.FocusedRow < 0) this.FocusedRow = 0;
        if(this.FocusedRow >= this.RowCount) this.FocusedRow = this.RowCount - 1;
  }
// Events
  this.OnAfterSort = null;
  this.OnAfterGroup = null;
  this.OnAfterUngroup = null;
  this.OnAfterExpand = null;
  this.OnAfterMove = null;
  this.OnBeforeSort = null;
  this.OnBeforeGroup = null;
  this.OnBeforeUngroup = null;
  this.OnBeforeExpand = null;
  this.OnBeforeMove = null;
  this.OnBeforeDelete = null;
  this.OnBeforeInsert = null;
  this.OnBeforeStartEdit = null;
  this.OnBeforePostEdit = null;
  this.OnBeforeCancelEdit = null;
  this.OnBeforeRefresh = null;

// Data operations
  this.Sort = function(evt, ASortIndex) {
        if(!this.Ready) return;
        if(!this.AllowSorting) return;
        if(this.IsEditing()) this.CancelEdit(false);

        var AllowAction = true;
        if(this.OnBeforeSort) {
        	AllowAction = this.OnBeforeSort(this, ASortIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}

        if(AllowAction == true) {
		if(this.LoadAllRecords && !this.AssignOnSort) {
	                this.ActionName = scxSortingAction;
	                if(dxDataController.Inf.GetCtrlState(evt)) {
	                        this.DataEngine.ChangeSorting(ASortIndex, 0);
	                } else {
	                        var sortingOrder = this.DataEngine.GetItemSortOrder(ASortIndex);
	                        var newSortingOrder = (sortingOrder == soAscending) ? soDescending : soAscending;
	                        if(!dxDataController.Inf.GetShiftState(evt)) this.DataEngine.ClearSorting();
	                        this.DataEngine.ChangeSorting(ASortIndex, newSortingOrder);
	                }
	                this.CheckFocusedRow();
	                this.UpdateClients();
		} else {
			__doAdvancedPostBack(evt, this.Name, scxSortingAction + ":" + ASortIndex);
			return;
		}
	        if(this.OnAfterSort) this.OnAfterSort(this, ASortIndex);
	}
  }
  this.Group = function(AGroupItemIndex, AItemGroupIndex) {
        if(!this.Ready) return;
        if(!this.AllowGrouping) return;
        if(this.IsEditing()) this.CancelEdit(false);

        var AllowAction = true;
        if(this.OnBeforeGroup) {
        	AllowAction = this.OnBeforeGroup(this, AGroupItemIndex, AItemGroupIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
		if(this.LoadAllRecords && !this.AssignOnGroup) {
	                this.ActionName = scxGroupingAction;
	                this.DataEngine.ChangeGrouping(AGroupItemIndex, AItemGroupIndex);
	                this.CheckFocusedRow();
	                this.UpdateClients();
		} else {
	                __doPostBack(this.Name, scxGroupingAction + ":" + AGroupItemIndex + ":" + AItemGroupIndex);
	                return;
		}
	        if(this.OnAfterGroup) this.OnAfterGroup(this, AGroupItemIndex, AItemGroupIndex);
	}
  }
  this.UnGroup = function(AGroupItemIndex) {
        if(!this.Ready) return;
        if(!this.AllowGrouping) return;
        if(this.IsEditing()) this.CancelEdit(false);

        var AllowAction = true;
        if(this.OnBeforeUnGroup) {
        	AllowAction = this.OnBeforeUnGroup(this, AGroupItemIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
	if(AllowAction == true)	{
		if(this.LoadAllRecords && !this.AssignOnUnGroup) {
	                this.ActionName = scxUnGroupingAction;
	                this.DataEngine.ChangeGrouping(AGroupItemIndex, -1);
	                this.CheckFocusedRow();
	                this.UpdateClients();
		} else {
	                __doPostBack(this.Name, scxUnGroupingAction + ":" + AGroupItemIndex);
	                return;
		}
	        if(this.OnAfterUnGroup) this.OnAfterUnGroup(this, AGroupItemIndex);
	}
  }
  this.Expand = function(evt, ARowIndex) {
        if(!this.Ready) return;
        if(!this.AllowExpanding) return;
        if(this.IsEditing()) this.CancelEdit(false);

        var AllowAction = true;
        if(this.OnBeforeExpand) {
        	AllowAction = this.OnBeforeExpand(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
		if(this.LoadAllRecords  && !this.AssignOnExpand) {
	                this.ActionName = scxExpandingAction;
	                this.DataEngine.ChangeExpanding(ARowIndex, !this.Rows[ARowIndex].expanded, dxDataController.Inf.GetShiftState(evt));
	                this.CheckFocusedRow();
	                this.UpdateClients();
		} else {
	                this.UpdateKeyValues(ARowIndex);
	                __doAdvancedPostBack(evt, this.Name, scxExpandingAction + ":" + ARowIndex +
	                    ":" + this.KeyValue + ":" + this.KeyLevel);
	                return;
		}
	        if(this.OnAfterExpand) this.OnAfterExpand(this, ARowIndex);
	}
  }
  this.Delete = function(ARowIndex) {
        if(!this.Ready) return;
        if(!this.AllowEditing) return;
        if(this.IsEditing()) this.CancelEdit(false);

        var AllowAction = true;
        if(this.OnBeforeDelete) {
        	AllowAction = this.OnBeforeDelete(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
	        if(confirm(scxDeleteConfirmText)) {
	                this.UpdateKeyValues(ARowIndex);
	                __doPostBack(this.Name, scxDeleteAction + ":" + ARowIndex +
	                    ":" + this.KeyValue + ":" + this.KeyLevel);
	        }
	}
  }
  this.StartEdit = function(ARowIndex) {
        if(!this.Ready) return;
        if(!this.AllowEditing) return;
        if(this.LoadAllRecords) {
                if(this.Rows[ARowIndex].level != this.DataEngine.GetGroupingItemCount()) {
                        this.Expand(ARowIndex);
                        return;
                }
        }
        if(this.IsEditing()) this.CancelEdit(true);
        var AllowAction = true;
        if(this.OnBeforeStartEdit) {
        	AllowAction = this.OnBeforeStartEdit(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
		if(this.LoadAllRecords && !this.AssignOnEdit) {
	                this.ActionName = scxStartEditAction;
	                this.UpdateClients();
                        var element = this.GetIsEditingElement();
                        if(Exists(element)) element.value = true;
		} else {
	                this.UpdateKeyValues(ARowIndex);
	                __doPostBack(this.Name, scxStartEditAction + ":" + ARowIndex +
	                    ":" + this.KeyValue + ":" + this.KeyLevel);
		}
	}
  }
  this.CancelEdit = function(processAction) {
        if(!this.Ready) return;
        var AllowAction = true;
        if(this.OnBeforeCancelEdit) {
        	AllowAction = this.OnBeforeCancelEdit(this);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
	        if(this.IsEditing()) {
	                var IsInserting = this.IsInserting();
	                if(this.LoadAllRecords && !this.AssignOnCancelEdit && !IsInserting)
	                {
	                        this.ActionName = scxCancelEditAction;
	                        this.UpdateClients();
                                var element = this.GetIsEditingElement();
                                if(Exists(element)) element.value = false;
	                } else {
		                if(IsInserting || processAction) __doPostBack(this.Name, scxCancelEditAction);
	                }
	        }
	        return true;
	}
  }
  this.PostEdit = function(AControlName) {
        if(!this.Ready) return;
        if(!this.AllowEditing) return;
        this.ActionName = scxPostEditAction;
        var AllowAction = true;
        if(this.OnBeforePostEdit) {
        	AllowAction = this.OnBeforePostEdit(this);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
	        this.UpdateKeyValues(this.FocusedRow);
        	__doPostBack(this.Name, scxPostEditAction + ":" + AControlName +
                	    ":" + this.KeyValue + ":" + this.KeyLevel);
	}
  }
  this.Insert = function(ARowIndex) {
        if(!this.Ready) return;
        if(!this.AllowEditing) return;
        if(this.IsEditing()) this.CancelEdit(false);
        this.ActionName = scxInsertAction;

        var AllowAction = true;
        if(this.OnBeforeInsert) {
        	AllowAction = this.OnBeforeInsert(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
	        this.UpdateKeyValues(ARowIndex);
	       	__doPostBack(this.Name, scxInsertAction + ":" + ARowIndex +
	                    ":" + this.KeyValue + ":" + this.KeyLevel);
	}
  }
  this.Refresh = function() {
        if(!this.Ready) return;
        var AllowAction = true;
        if(this.OnBeforeRefresh) {
        	AllowAction = this.OnBeforeRefresh(this);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) __doPostBack(this.Name, scxRefreshAction);
  }
  this.MoveTo = function(ARowIndex) {
        if(!this.Ready) return;
        var IsEditing = this.IsEditing();
        if(IsEditing) this.CancelEdit(false);
        this.ActionName = scxMoveToAction;

        var AllowAction = true;
        if(this.OnBeforeMove) {
        	AllowAction = this.OnBeforeMove(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
		if(this.LoadAllRecords && !this.AssignOnChangeFocus) {
	                this.FocusedRow = ARowIndex;
                        this.CheckFocusedRow();
	                this.SyncronizeFocusingInfo();
	                this.UpdateClients();
		} else	{
	                if(IsEditing || this.NeedUpdate(ARowIndex) || this.AssignOnChangeFocus) {
			        __doPostBack(this.Name, scxMoveToAction + ":" + ARowIndex);
			        return;
	                } else {
	                        this.FocusedRow = ARowIndex;
	                        this.CheckFocusedRow();
	                        this.SyncronizeFocusingInfo();
	                        this.UpdateClients();
	                }
		}
        	if(this.OnAfterMove) this.OnAfterMove(this, ARowIndex);
	}
  }
  this.MoveBy = function(ADelta) {
        if(!this.Ready) return;
        var IsEditing = this.IsEditing();
        if(IsEditing) this.CancelEdit(false);
        this.ActionName = scxMoveByAction;
        var ARowIndex = eval(+this.FocusedRow + ADelta);

        var AllowAction = true;
        if(this.OnBeforeMove) {
	        AllowAction = this.OnBeforeMove(this, ARowIndex);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
		if(this.LoadAllRecords && !this.AssignOnChangeFocus) {
	                this.FocusedRow = ARowIndex;
	                this.CheckFocusedRow();
	                this.SyncronizeFocusingInfo();
	                this.UpdateClients();
		} else {
	                if(IsEditing || this.NeedUpdate(ARowIndex) || this.AssignOnChangeFocus) {
	        		__doPostBack(this.Name, scxMoveByAction + ":" + ADelta);
	        		return;
	                } else {
	                        this.FocusedRow = ARowIndex;
	                        this.CheckFocusedRow();
	                        this.SyncronizeFocusingInfo();
	                        this.UpdateClients();
	                }
		}
        	if(this.OnAfterMove) this.OnAfterMove(this, ARowIndex);
	}
  }
  this.IsEditing = function() {
        return (this.ActionName == scxStartEditAction || this.ActionName == scxInsertAction);
  }
  this.IsInserting = function() {
        return (this.ActionName == scxInsertAction);
  }
  this.GetRowDisplayText = function(rowIndex, itemIndex) {
  	if(0 > rowIndex || rowIndex >= this.RowCount) return "";
        return  (this.Rows[rowIndex].level == this.GetGroupingItemCount()) ?
                this.DisplayTexts[this.GetRowRecord(rowIndex)][itemIndex] :
                this.DisplayTexts[this.GetRowRecord(rowIndex)][this.GetGroupingItemIndex(this.GetRowLevel(rowIndex))];
  }
  this.GetRowValue = function(rowIndex, itemIndex) {
  	if(0 > rowIndex || rowIndex >= this.RowCount) return null;
        return  (this.Rows[rowIndex].level == this.GetGroupingItemCount()) ?
                this.Values[this.GetRowRecord(rowIndex)][itemIndex] :
                this.Values[this.GetRowRecord(rowIndex)][this.GetGroupingItemIndex(this.GetRowLevel(rowIndex))];
  }
  this.GetDisplayText = function(recordIndex, itemIndex) {
  	if(0 > recordIndex || recordIndex >= this.RecordCount) return "";  
        return this.DisplayTexts[recordIndex][itemIndex];
  }
  this.GetValue = function(recordIndex, itemIndex) {
  	if(0 > recordIndex || recordIndex >= this.RecordCount) return null;  
        return this.Values[recordIndex][itemIndex];
  }
  this.GetSortingItemCount = function() {
        if(this.LoadAllRecords)
                return this.DataEngine.GetSortingItemCount();
        else
                return this.SortingItemCount;
  }
  this.GetItemSortIndex = function(AItemIndex) {
        return this.DataEngine.GetItemSortIndex(AItemIndex);
  }
  this.GetItemSortOrder = function(AItemIndex) {
        return this.DataEngine.GetItemSortOrder(AItemIndex);
  }
  this.GetSortingItemIndex = function(Index) {
        return this.DataEngine.GetSortingItemIndex(Index);
  }
  this.GetGroupingItemCount = function() {
        if(this.LoadAllRecords)
                return this.DataEngine.GetGroupingItemCount();
        else
                return this.GroupingItemCount;
  }
  this.GetItemGroupIndex = function(AItemIndex) {
        return this.DataEngine.GetItemGroupIndex(AItemIndex);
  }
  this.GetGroupingItemIndex = function(Index) {
        return this.DataEngine.GetGroupingItemIndex(Index)
  }
  this.GetRowRecord = function(rowIndex) {
  	if(0 > rowIndex || rowIndex >= this.RowCount) return -1;
        return this.Rows[rowIndex].recordIndex;
  }
  this.GetRowLevel = function(rowIndex) {
  	if(0 > rowIndex || rowIndex >= this.RowCount) return 0;
        return this.Rows[rowIndex].level;
  }
  this.GetRowExpanded = function(rowIndex) {
  	if(0 > rowIndex || rowIndex >= this.RowCount) return false;
        return this.Rows[rowIndex].expanded;
  }
}

function dx_DataControllerManager()
{
  this.datacontrollers = [];

  this.Initialize = function() {
        dxDataControls.Mng.Initialize();  
	for(var i = 0; i < this.datacontrollers.length; i++) {
		this.datacontrollers[i].Initialize();
	}
  }
  this.CreateDataController = function() {
  	var datacontroller = new dx_DataController();
  	this.datacontrollers.Add(datacontroller);
  	return datacontroller;
  }
  this.GetDataController = function(AName) {
	for(var i = 0; i < this.datacontrollers.length; i++)
		if(AName == this.datacontrollers[i].Name) return this.datacontrollers[i];
	return null;
  }
}

function CreateDataController() {
  	return dxDataController.Mng.CreateDataController();
}

dxDataController.Evt.Attach("window.onload", function() { dxDataController.Mng.Initialize(); } );
window.onload = function() { dxDataController.Evt.Exec("window.onload"); }
