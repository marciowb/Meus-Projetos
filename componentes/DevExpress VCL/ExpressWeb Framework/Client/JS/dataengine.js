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

var soNone = 0
var soAscending = 1
var soDescending = 2
var itemRemoved = 0;
var itemChanged = 1;
var itemAdded = 2;

function SortingArrayItem()
{
  this.sortingIndex = -1;
  this.sortingOrder = soNone;
}

function dx_DataEngine(ADataController)
{
  this.DataController = ADataController;
  this.groupingArray = new Array();
  this.sortingArray = new Array();
  this.expandingArray = new Array();
  this.globalSortingArray = new Array();
  this.globalRowsArray = new Array();
  this.RestoreFocusing = function(oldFocusedRow) {
        if(!oldFocusedRow) return;
        for(var i = 0; i < this.DataController.RowCount; i ++) {
                if(this.DataController.Rows[i] == oldFocusedRow) {
                        this.DataController.FocusedRow = i;
                        this.DataController.SyncronizeFocusingInfo();
                        return;
                }
        }
        for(var i = 0; i < this.DataController.RowCount; i ++) {
                if(this.DataController.Rows[i].recordIndex == oldFocusedRow.recordIndex) {
                        this.DataController.FocusedRow = i;
                        this.DataController.SyncronizeFocusingInfo();
                        return;
                }
        }
  }
  this.GetSortingItemCount = function() {
        var sortingItemCount = 0;
        for(var i = 0; i < this.DataController.ItemCount; i ++) {
  		if (Exists(this.sortingArray[i])) {        	
                	if(this.sortingArray[i].sortingIndex != -1) sortingItemCount ++;
                }
        }
        return sortingItemCount;
  }
  this.GetItemSortIndex = function(AItemIndex) {
  	if (Exists(this.sortingArray[AItemIndex]))
        	return this.sortingArray[AItemIndex].sortingIndex;
        else 
        	return -1;
  }
  this.GetItemSortOrder = function(AItemIndex) {
  	if (Exists(this.sortingArray[AItemIndex]))
        	return this.sortingArray[AItemIndex].sortingOrder;
        else 
        	return soNone; 
  }
  this.GetSortingItemIndex = function(Index) {
        for(var i = 0; i < this.DataController.ItemCount; i ++) {
  		if (Exists(this.sortingArray[i])) {
                	if(this.sortingArray[i].sortingIndex == Index) return i;
                }
        }
        return -1;
  }
  this.ChangeSorting = function(SortingItem, SortingOrder) {
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        if(SortingOrder == soNone) {
                if(this.sortingArray[SortingItem].sortingIndex != -1 && this.groupingArray[SortingItem] == -1) {
                        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                if(this.sortingArray[i].sortingIndex > this.sortingArray[SortingItem].sortingIndex) {
                                        this.sortingArray[i].sortingIndex --;
                                }
                        }
                        this.sortingArray[SortingItem].sortingIndex = -1;
                        this.sortingArray[SortingItem].sortingOrder = SortingOrder;
                }
        } else {
                if(this.sortingArray[SortingItem].sortingIndex == -1)
                        this.sortingArray[SortingItem].sortingIndex = this.GetSortingItemCount();
                this.sortingArray[SortingItem].sortingOrder = SortingOrder;
        }

        this.UpdateRowInfo(true);
        this.RestoreFocusing(SavedFocusedRow);

        this.DataController.SyncronizeExpandingInfo();
        this.DataController.SyncronizeSortingInfo();
  }
  this.ClearSorting = function() {
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                if(this.groupingArray[i] == -1) {
                        this.sortingArray[i].sortingIndex = -1;
                        this.sortingArray[i].sortingOrder = soNone;
                }
        }
        this.UpdateRowInfo(true);
        this.RestoreFocusing(SavedFocusedRow);

        this.DataController.SyncronizeExpandingInfo();
        this.DataController.SyncronizeSortingInfo();
  }
  this.GetGroupingItemCount = function() {
        var groupingItemCount = 0;
        for(var i = 0; i < this.DataController.ItemCount; i ++) {
  		if (Exists(this.groupingArray[i])) {
                	if(this.groupingArray[i] != -1) groupingItemCount ++;
                }
        }
        return groupingItemCount;
  }
  this.GetItemGroupIndex = function(AItemIndex) {
  	if (Exists(this.groupingArray[AItemIndex]))
        	return this.groupingArray[AItemIndex];
        else
        	return -1;
  }
  this.GetGroupingItemIndex = function(Index) {
        for(var i = 0; i < this.DataController.ItemCount; i ++) {
  		if (Exists(this.groupingArray[i])) {
                	if(this.groupingArray[i] == Index) return i;
                }
        }
        return -1;
  }
  this.UpdateSortingArray = function(GroupingItem, operation) {
        if(operation == itemRemoved) {
                this.sortingArray[GroupingItem].sortingIndex = -1;
                for(var i = 0; i < this.DataController.ItemCount; i ++) {
                        if(this.groupingArray[i] != -1) this.sortingArray[i].sortingIndex = this.groupingArray[i];
                }
                for(var i = 0; i < this.DataController.ItemCount; i ++) {
                        if(this.groupingArray[i] == -1) {
                                if(this.sortingArray[i].sortingIndex != -1) this.sortingArray[i].sortingIndex --;
                        }
                }
        } else {
                if(operation == itemChanged) {
                        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                if(this.groupingArray[i] != -1) this.sortingArray[i].sortingIndex = this.groupingArray[i];
                        }
                } else {
                        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                if(this.groupingArray[i] == -1) {
                                        if(this.sortingArray[i].sortingIndex != -1) this.sortingArray[i].sortingIndex ++;
                                }
                        }
                        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                if(this.groupingArray[i] != -1) this.sortingArray[i].sortingIndex = this.groupingArray[i];
                        }
                }
        }
  }
  this.ChangeGrouping = function(GroupingItem, GroupingIndex) {
        if(this.GetGroupingItemCount() == this.DataController.ItemCount - 1 && GroupingIndex != -1) return;
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        if (GroupingIndex > this.GetGroupingItemCount()) GroupingIndex = this.GetGroupingItemCount();

        if(GroupingIndex == -1) {
                for(var i = 0; i < this.DataController.ItemCount; i ++) {
                        if(this.groupingArray[i] != -1) {
                                if(this.groupingArray[i] > this.groupingArray[GroupingItem]) this.groupingArray[i] --;
                        }
                }
                this.groupingArray[GroupingItem] = GroupingIndex;
                this.sortingArray[GroupingItem].sortingOrder = soNone;
                this.UpdateSortingArray(GroupingItem, itemRemoved);
        } else {
                if(this.groupingArray[GroupingItem] != -1) {
                        if (GroupingIndex >= this.GetGroupingItemCount()) GroupingIndex = this.GetGroupingItemCount() - 1;
                        var oldGroupingIndex = this.groupingArray[GroupingItem];
                        if((oldGroupingIndex - GroupingIndex) > 0) {
                                for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                        if(this.groupingArray[i] != -1) {
                                                if(this.groupingArray[i] < oldGroupingIndex && this.groupingArray[i] >= GroupingIndex) this.groupingArray[i] ++;
                                        }
                                }
                        }
                        if((oldGroupingIndex - GroupingIndex) < 0) {
                                for(i = 0; i < this.DataController.ItemCount; i ++) {
                                        if(this.groupingArray[i] != -1) {
                                                if(this.groupingArray[i] > oldGroupingIndex && this.groupingArray[i] <= GroupingIndex) this.groupingArray[i] --;
                                        }
                                }
                        }
                        this.groupingArray[GroupingItem] = GroupingIndex;
                        this.sortingArray[GroupingItem].sortingOrder = soAscending;                        
                        this.UpdateSortingArray(GroupingItem, itemChanged);
                } else {
                        if (GroupingIndex > this.GetGroupingItemCount()) GroupingIndex = this.GetGroupingItemCount();
                        for(var i = 0; i < this.DataController.ItemCount; i ++) {
                                if(this.groupingArray[i] != -1) {
                                        if(this.groupingArray[i] >= GroupingIndex) this.groupingArray[i] ++;
                                }
                        }
                        this.groupingArray[GroupingItem] = GroupingIndex;
                        this.sortingArray[GroupingItem].sortingOrder = soAscending;
                        this.UpdateSortingArray(GroupingItem, itemAdded);
                }
        }
        this.UpdateRowInfo(true);
        this.RestoreFocusing(SavedFocusedRow);

        this.DataController.SyncronizeExpandingInfo();
        this.DataController.SyncronizeGroupingInfo();
        this.DataController.SyncronizeSortingInfo();
  }
  this.ClearGrouping = function() {
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        for(var i = 0; i < this.DataController.ItemCount; i ++) this.groupingArray[i] = -1;
        this.UpdateRowInfo(true);
        this.RestoreFocusing(SavedFocusedRow);

        this.DataController.SyncronizeExpandingInfo();
        this.DataController.SyncronizeGroupingInfo();
        this.DataController.SyncronizeSortingInfo();
  }
  this.ChangeExpanding = function(rowIndex, AExpanded, ARecursive) {
        if(this.DataController.Rows[rowIndex].level == this.GetGroupingItemCount()) return;
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        var globalIndex = this.DataController.Rows[rowIndex].globalIndex;
        this.globalRowsArray[globalIndex].expanded = AExpanded;
        if(ARecursive) {
                var Level = this.globalRowsArray[globalIndex].level;
                for(var i = globalIndex + 1; i < this.globalRowsArray.length; i ++) {
                        if(this.globalRowsArray[i].level == Level) break;
                        if(this.globalRowsArray[i].level < this.GetGroupingItemCount())
                                this.globalRowsArray[i].expanded = AExpanded;
                }
        }
        this.UpdateRowInfo(false);
        this.RestoreFocusing(SavedFocusedRow);
        this.DataController.SyncronizeExpandingInfo();
  }
  this.FullExpand = function() {
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        for(var i = 0; i < this.globalRowsArray[i].length; i ++) {
                if(this.globalRowsArray[i].level < this.GetGroupingItemCount())
                        this.globalRowsArray[i].expanded = true;
        }
        this.UpdateRowInfo(false);
        this.RestoreFocusing(SavedFocusedRow);
        this.DataController.SyncronizeExpandingInfo();
  }
  this.FullCollapse = function() {
        var SavedFocusedRow = this.DataController.Rows[this.DataController.FocusedRow];
        for(var i = 0; i < this.globalRowsArray[i].length; i ++) {
                this.globalRowsArray[i].expanded = false;
        }
        this.UpdateRowInfo(false);
        this.RestoreFocusing(SavedFocusedRow);
        this.DataController.SyncronizeExpandingInfo();
  }
  this.GetDataRecordNumber = function(recordIndex) {
        for(var i = 0; i < this.DataController.RecordCount; i ++) {
                if(this.globalSortingArray[i] == recordIndex) return i;
        }
        return -1;
  }
  this.CompareRows = function(rowIndex1, rowIndex2) {
  	if (rowIndex1==rowIndex2) return 0;
  	var row1 = this.DataController.Values[rowIndex1];
	var row2 = this.DataController.Values[rowIndex2];
	for(var i = 0; i < this.GetSortingItemCount(); i ++) {
                var itemIndex = this.GetSortingItemIndex(i);
                var value1 = row1[itemIndex];
                var value2 = row2[itemIndex];
		var ret;                
		if(value1 == value2) continue;
		if(value1 == null) ret = -1;
		if(value2 == null) ret = 1;
		if(value1 < value2) ret = -1;
		if(value1 > value2) ret = 1;
		if(this.sortingArray[itemIndex].sortingOrder == soDescending) ret *= -1;
		return ret;
	}
	return (rowIndex1 > rowIndex2)?1:-1;
  }
  this.UpdateGlobalSortingArray = function() {
	this.globalSortingArray = [];
        if(this.DataController.RecordCount > 0) {
		var tempSortingArray = [];	
		for(var i = 0; i < this.DataController.RecordCount; i ++) {
			tempSortingArray[i] = i;
		}
        	while (tempSortingArray.length > 0) {
        		var maxIndex = 0;
			for(var i = 1; i < tempSortingArray.length; i ++) {
				if (this.CompareRows(tempSortingArray[maxIndex], tempSortingArray[i]) == 1)
					maxIndex = i;
			}
			this.globalSortingArray[this.globalSortingArray.length] = tempSortingArray[maxIndex];			
			tempSortingArray[maxIndex] = tempSortingArray[tempSortingArray.length - 1];
			tempSortingArray.length--;
        	}
        }
  }
  this.NeedGroupNode = function(Index, Level) {
        if(Index == 0) return true;
        for(var i = 0; i <= Level; i ++) {
                var ItemIndex = this.GetGroupingItemIndex(i);
                if(this.DataController.Values[this.globalSortingArray[Index]][ItemIndex] !=
                        this.DataController.Values[this.globalSortingArray[Index - 1]][ItemIndex])
                        return true;
        }
        return false;
  }
  this.UpdateGlobalRowsArray = function() {
        var globalRowCount = 0;
        this.globalRowsArray = [];
        for(var i = 0; i < this.DataController.RecordCount; i ++) {
                for(var j = 0; j < this.GetGroupingItemCount(); j ++) {
                        if(this.NeedGroupNode(i, j)) {
                                this.globalRowsArray[globalRowCount] = new dx_Row()
                                this.globalRowsArray[globalRowCount].expanded = false;
                                this.globalRowsArray[globalRowCount].level = j;
                                this.globalRowsArray[globalRowCount].recordIndex = this.globalSortingArray[i];
                                this.globalRowsArray[globalRowCount].globalIndex = globalRowCount;
                                globalRowCount ++;
                        }
                }
                this.globalRowsArray[globalRowCount] = new dx_Row()
                this.globalRowsArray[globalRowCount].expanded = false;
                this.globalRowsArray[globalRowCount].level = this.GetGroupingItemCount();
                this.globalRowsArray[globalRowCount].recordIndex = this.globalSortingArray[i];
                this.globalRowsArray[globalRowCount].globalIndex = globalRowCount;
                globalRowCount ++;
        }
  }
  this.UpdateRowInfo = function(UpdateAll) {
        if(UpdateAll) {
                this.UpdateGlobalSortingArray();
                this.UpdateGlobalRowsArray();
        }

        var Level = 0, RowCount = 0;
        this.DataController.Rows = [];
        for(var i = 0; i < this.globalRowsArray.length; i ++) {
                if(Level >= this.globalRowsArray[i].level)
                {
                        if(this.globalRowsArray[i].expanded == false) {
                                Level = this.globalRowsArray[i].level;
                        } else {
                                Level = this.globalRowsArray[i].level + 1;
                        }
                        this.DataController.Rows[RowCount] = new dx_Row();
                        this.DataController.Rows[RowCount] = this.globalRowsArray[i];
                        RowCount ++;
                }
        }
        this.DataController.RowCount = this.DataController.Rows.length;
  }
  this.LoadExpandingInfo = function() {
        for(var i = 0; i < this.expandingArray.length; i ++) {
                if(i >= this.DataController.RowCount) break;
                if(this.expandingArray[i])  {
                        if(this.DataController.Rows[i].level == this.GetGroupingItemCount()) continue;
                        var globalIndex = this.DataController.Rows[i].globalIndex;
                        this.globalRowsArray[globalIndex].expanded = true;
                        this.UpdateRowInfo(false);
                }
        }
  }
  this.SaveExpandingInfo = function() {
        this.expandingArray = [];
        for(var i = 0; i < this.DataController.Rows.length; i ++) {
                this.expandingArray[i] = this.DataController.Rows[i].expanding;
        }
  }
}
