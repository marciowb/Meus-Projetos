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
var dxDataControls = [];
dxDataControls["Inf"] = new dx_Info();
dxDataControls["Mng"] = new dx_DataControlsManager();
dxDataControls["Utl"] = new dx_Utils();
dxDataControls["Obj"] = dxDataControls.Utl.CreateObjHelper();
dxDataControls["Evt"] = new dx_EventManager();

function dx_DataControl()
{
  this.Name = "";
  this.DataControllerName = "";
  this.DataController = null;
  this.FieldIndex = -1;
  this.FirstVisibleRow = 0;
  this.PageSize = 0;
  this.Update = function() {}
  this.NeedUpdate = function(ANewFocusedRow) {
        return (ANewFocusedRow < this.FirstVisibleRow || ANewFocusedRow >= this.FirstVisibleRow + this.PageSize)
  }
  this.Initialize = function() {
        this.DataController = dxDataController.Mng.GetDataController(this.DataControllerName);
        if(Exists(this.DataController)) this.DataController.RegisterClient(this);
  }
}

function dx_DBLabel()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var Label = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(Label)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                if(dxDataControls.Inf.ie) {
                        Label.innerText = displayText;
                } else {
                        Label.innerHTML = displayText;
                }
        }
  }
}

function dx_DBEdit()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var Edit = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(Edit)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                Edit.value = displayText;
        }
  }
}

function dx_DBMemo()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var Memo = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(Memo)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var value = this.DataController.GetValue(recordIndex, this.FieldIndex);
                Memo.value = value;
        }
  }
}

function dx_DBListBox()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.StoreByValues = false;

  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var ListBox = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(ListBox)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                ListBox.selectedIndex = -1;
                for(var i = 0; i < ListBox.options.length; i ++) {
                        var Value = this.StoreByValues ? ListBox.options[i].value : ListBox.options[i].text;
                        if(Value == displayText) {
                                ListBox.selectedIndex = i;
                                break;
                        }
                }
        }
  }
}

function dx_DBComboBox()
{
  this.inherit = dx_DBListBox;
  this.inherit();
}

function dx_DBCheckBox()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.CheckedValue = "";
  this.UncheckedValue = "";
  this.UncheckedIsDefault = true;

  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var CheckBox = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(CheckBox)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                if(displayText == true || displayText == "true" || displayText == this.CheckedValue)
                        CheckBox.checked = true;
                else if(displayText == false || displayText == "false" || displayText == this.UncheckedValue)
                        CheckBox.checked = false;
                else if(this.UncheckedIsDefault)
                        CheckBox.checked = false;
                else CheckBox.checked = true;
        }
  }
}

function dx_DBRadioGroup()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                var RadioGroupItem = dxDataControls.Obj.GetElementById(this.Name + "_" + displayText);
                if(!RadioGroupItem) return;
                RadioGroupItem.checked = true;
        }
  }
}

function dx_DBCalendar()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var value = this.DataController.GetValue(recordIndex, this.FieldIndex);
                CalendarSelectDate(this.Name, value);
        }
  }
}

function dx_DBDateEdit()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var value = this.DataController.GetValue(recordIndex, this.FieldIndex);
                DateEditSelectDate(this.Name, value);
        }
  }
}

function dx_DBImage()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var Image = dxDataControls.Obj.GetElementById(this.Name + "_" + recordIndex);
                if (Exists(Image)) {
                        for(var i = 0; i < this.DataController.RecordCount; i ++) {
                                var ImagesItem = dxDataControls.Obj.GetElementById(this.Name + "_" + i);
                                if (Exists(ImagesItem)) {
                                        if (Image != ImagesItem) {
                                                dxDataControls.Obj.SetElementVisibility(ImagesItem, false);
                                        }
                                }
                        }
                        dxDataControls.Obj.SetElementVisibility(Image, true);
                }
        }
  }
}

function dx_DBLookup()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var Lookup = dxDataControls.Obj.GetElementById(this.Name);
                if(!Exists(Lookup)) return;
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
                Lookup.selectedIndex = -1;
                for(var i = 0; i < Lookup.options.length; i ++) {
                        if(Lookup.options[i].value == displayText) {
                                Lookup.selectedIndex = i;
                                break;
                        }
                }
        }
  }
}

function dx_DBExtLookup()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        if(this.DataController.LoadAllRecords) {
                var recordIndex = this.DataController.GetRowRecord(this.DataController.FocusedRow);
                var displayText = this.DataController.GetDisplayText(recordIndex, this.FieldIndex);
        	SetLookupItem(this.Name, displayText);
        }
  }
}

function dx_DBDataNavigator()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.NeedUpdate = function() { return false; }
  this.Initialize = function() {
        this.DataController = dxDataController.Mng.GetDataController(this.DataControllerName);
        if(Exists(this.DataController)) this.DataController.RegisterClient(this);
        var navigator = dxDataNavigator.Mng.GetDataNavigator(this.Name);
        if(Exists(navigator)) navigator.Initialize();
  }
}

function dx_DBGrid()
{
  this.inherit = dx_DataControl;
  this.inherit();
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        var Grid = dxGrid.Mng.GetGrid(this.Name);
        if(Exists(Grid)) {
                var Painter = dxGrid.Mng.CreateGridPainter(Grid);
                if(Exists(Painter)) Painter.Update();
        }
  }
  this.Initialize = function() {
        this.DataController = dxDataController.Mng.GetDataController(this.DataControllerName);
        if(Exists(this.DataController)) this.DataController.RegisterClient(this);
        var grid = dxGrid.Mng.GetGrid(this.Name);
        if(Exists(grid)) grid.Initialize();
  }
}

function dx_DataControlsManager()
{
  this.datacontrols = [];

  this.Initialize = function() {
	for(var i = 0; i < this.datacontrols.length; i++) {
		this.datacontrols[i].Initialize();
	}
  }
  this.CreateDBLabel = function() {
  	var control = new dx_DBLabel();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBEdit = function() {
  	var control = new dx_DBEdit();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBMemo = function() {
  	var control = new dx_DBMemo();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBListBox = function() {
  	var control = new dx_DBListBox();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBComboBox = function() {
  	var control = new dx_DBComboBox();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBCheckBox = function() {
  	var control = new dx_DBCheckBox();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBRadioGroup = function() {
  	var control = new dx_DBRadioGroup();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBCalendar = function() {
  	var control = new dx_DBCalendar();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBDateEdit = function() {
  	var control = new dx_DBDateEdit();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBImage = function() {
  	var control = new dx_DBImage();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBLookup = function() {
  	var control = new dx_DBLookup();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBExtLookup = function() {
  	var control = new dx_DBExtLookup();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBDataNavigator = function() {
  	var control = new dx_DBDataNavigator();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.CreateDBGrid = function() {
  	var control = new dx_DBGrid();
  	this.datacontrols.Add(control);
  	return control;
  }
  this.GetDataControl = function(AName) {
	for(var i = 0; i < this.datacontrols.length; i++)
		if(AName == this.datacontrols[i].Name) return this.datacontrols[i];
	return null;
  }
}

function CreateDBLabel() {
        return dxDataControls.Mng.CreateDBLabel();
}
function CreateDBEdit() {
        return dxDataControls.Mng.CreateDBEdit();
}
function CreateDBMemo() {
        return dxDataControls.Mng.CreateDBMemo();
}
function CreateDBListBox() {
        return dxDataControls.Mng.CreateDBListBox();
}
function CreateDBComboBox() {
        return dxDataControls.Mng.CreateDBComboBox();
}
function CreateDBCheckBox() {
        return dxDataControls.Mng.CreateDBCheckBox();
}
function CreateDBRadioGroup() {
        return dxDataControls.Mng.CreateDBRadioGroup();
}
function CreateDBCalendar() {
        return dxDataControls.Mng.CreateDBCalendar();
}
function CreateDBDateEdit() {
        return dxDataControls.Mng.CreateDBDateEdit();
}
function CreateDBImage() {
        return dxDataControls.Mng.CreateDBImage();
}
function CreateDBLookup() {
        return dxDataControls.Mng.CreateDBLookup();
}
function CreateDBExtLookup() {
        return dxDataControls.Mng.CreateDBExtLookup();
}
function CreateDBDataNavigator() {
        return dxDataControls.Mng.CreateDBDataNavigator();
}
function CreateDBGrid() {
        return dxDataControls.Mng.CreateDBGrid();
}


