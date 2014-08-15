/*
   ExpressWeb Framework by Developer Express
   ExpressWebDateEdit

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
var dxDateEdit = [];
dxDateEdit["Inf"] = new dx_Info();
dxDateEdit["Utl"] = new dx_Utils();
dxDateEdit["Mng"] = new dx_DateEditManager();
dxDateEdit["Obj"] = dxDateEdit.Utl.CreateObjHelper();
dxDateEdit["Evt"] = new dx_EventManager();

// Class dx_DateEdit
function dx_DateEdit()
{
  this.inherit = dx_Calendar;
  this.inherit();

  this.CalendarSelectDate = this.SelectDate;
  this.CalendarSelectDay = this.SelectDay;  
  this.CalendarSelectToday = this.SelectToday;
  this.CalendarShiftMonth = this.ShiftMonth;    

  this.GetCalendarElement = function() {
  	return dxDateEdit.Obj.GetElementById(this.Name + "Calendar");
  }
  this.GetEditorElement = function() {
  	return dxDateEdit.Obj.GetElementById(this.Name + "Editor");
  }
  this.ShowCalendar = function() {
	var calendar = this.GetCalendarElement();
	if( Exists (calendar) )	dxDateEdit.Obj.SetElementVisibility(calendar, true);
  }
  this.HideCalendar = function(){
	var calendar = this.GetCalendarElement();
	if( Exists (calendar) )	dxDateEdit.Obj.SetElementVisibility(calendar, false);
  }
  this.Toggle = function () {
	var calendar = this.GetCalendarElement();
  	if( Exists(calendar) ) {
		if(dxCalendar.Obj.IsElementVisible(calendar)) this.HideCalendar();
		else this.ShowCalendar();
	}
  }
  this.SetDateElement = function (aChar, aValue, aDate) {
        if(aChar.indexOf("M") > -1 || aChar.indexOf("m") > -1)
                aDate.setMonth(aValue - 1);
        else if (aChar.indexOf("D") > -1 || aChar.indexOf("d") > -1)
                aDate.setDate(aValue);
        else if (aChar.indexOf("YYYY") > -1 || aChar.indexOf("yyyy") > -1)
                aDate.setFullYear(aValue);
        else if (aChar.indexOf("YY") > -1 || aChar.indexOf("yy") > -1)
                aDate.setYear(aValue);
  }
  this.GetEditorValue = function() {
  	var editor = this.GetEditorElement();
        if( Exists(editor) ) {
        	var newDate = new Date();
                var aDate = editor.value;
		if(this.OnValidateEditText) {
        		aDate = this.OnValidateEditText(this, aDate);
			if(typeof AllowAction != "string") aDate = editor.value;
		}
                var number, day, month, year;
                var format = this.DateFormat;
                dateChar = format.substring(0, format.indexOf(this.DateSeparator));
                number = aDate.substring(0, aDate.indexOf(this.DateSeparator));
                this.SetDateElement(dateChar, number, newDate);
                format = format.substring(format.indexOf(this.DateSeparator) + 1);
                aDate = aDate.substring(aDate.indexOf(this.DateSeparator) + 1);
                dateChar = format.substring(0, format.indexOf(this.DateSeparator));
                number = aDate.substring(0, aDate.indexOf(this.DateSeparator));
                this.SetDateElement(dateChar, number, newDate);
                format = format.substring(format.indexOf(this.DateSeparator) + 1);
                aDate = aDate.substring(aDate.indexOf(this.DateSeparator) + 1);
                this.SetDateElement(format, aDate, newDate);
                if(!isNaN(newDate)) {
                	this.SelectDate(newDate)
                } else {
                	alert("Invalid date format !!!");
                        this.SetEditorValue();
                }
  	}
  }
  this.GetDateElement = function (aChar, aDate) {
        var date = new Date(aDate);
        if(aChar.indexOf("M") > -1 || aChar.indexOf("m") > -1)
                return eval(date.getMonth() + 1);
        else if (aChar.indexOf("D") > -1 || aChar.indexOf("d") > -1)
                return date.getDate();
        else if (aChar.indexOf("YYYY") > -1 || aChar.indexOf("yyyy") > -1)
                return date.getFullYear();
        else if (aChar.indexOf("YY") > -1 || aChar.indexOf("yy") > -1)
                return date.getYear().toString().substr(2, 2);
        return "";
  }
  this.SetEditorValue = function() {
        var format, dateChar, aDate;
        format = this.DateFormat;
        dateChar = format.substring(0, format.indexOf(this.DateSeparator));
        aDate = this.GetDateElement(dateChar, this.SelectedDate) + this.DateSeparator;
        format = format.substring(format.indexOf(this.DateSeparator) + 1);
        dateChar = format.substring(0, format.indexOf(this.DateSeparator));
        aDate += this.GetDateElement(dateChar, this.SelectedDate) + this.DateSeparator;
        format = format.substring(format.indexOf(this.DateSeparator) + 1);
        aDate += this.GetDateElement(format, this.SelectedDate);

        var editor = this.GetEditorElement();
        if( Exists(editor) ) editor.value = aDate;
  }
  this.SelectDate = function(date) {
	this.CalendarSelectDate(date);
        this.SetEditorValue();
        this.HideCalendar();
  }
  this.SelectToday = function() {
        today = new Date();
	this.SelectDate(today);
  }
  this.SelectDay = function (id) {
        this.CalendarSelectDay(id);
        this.SetEditorValue();
        this.HideCalendar();
  }
  this.ShiftMonth = function(offset) {
  	this.CalendarShiftMonth(offset)
  }
  this.OnKeyPress = function(e) {
        var editor = this.GetEditorElement();
        if( Exists(editor) ) {
                switch(e.keyCode) {
                        case 27:  {
                                this.HideCalendar();
                                this.SetEditorValue();
                                editor.blur();                                
                                editor.select();
                                break;
                        }
                        case 13:  {
                                this.HideCalendar();
                                this.GetEditorValue();
                                editor.blur();                                
                                editor.select();
                                break;
                        }
                }
                return false;
        }
  }
}

// Class DateEditNS4
function dx_DateEditNS4() 
{
  this.inherit = dx_DateEdit;
  this.inherit();
  
  this.ShowCalendar = function () {
	var calendar = this.GetCalendarElement();
	if( Exists (calendar) )	{
		var posImg = dxDateEdit.Obj.GetElementById(this.Name + "PosImage");
		if( Exists(posImg) ) {
                        calendar.left = posImg.x;
                        calendar.top = posImg.y;
		}
		dxDateEdit.Obj.SetElementVisibility(calendar, true);
	}
  }
}

// Class DateEditManager
function dx_DateEditManager()
{
  this.dateedits = [];

  this.CreateDateEdit = function() { 
  	var dateedit = dxDateEdit.Inf.ns4 ? new dx_DateEditNS4() : new dx_DateEdit(); 
  	this.dateedits.Add(dateedit);
  	return dateedit; 
  }
  this.GetDateEdit = function(AName) {
	for(var i = 0; i < this.dateedits.length; i++)
		if(AName == this.dateedits[i].Name) return this.dateedits[i];
	return null;
  }
  this.HideCalendar = function(AName) {
  	var dateedit = this.GetCalendar(AName);
  	if( Exists(dateedit) ) dateedit.HideCalendar();
  }
  this.OnMouseDown = function(e) {
	for(var i = 0; i < this.dateedits.length; i++) {
		if( !Exists(dxDateEdit.Obj.GetParentById(dxDateEdit.Inf.GetSrcElement(e), this.dateedits[i].Name))) 
			this.dateedits[i].HideCalendar();
	}
  }
  this.OnResize = function() {
	for(var i = 0; i < this.dateedits.length; i++) this.dateedits[i].HideCalendar();
  }
}

function CreateDateEdit() {
	return dxDateEdit.Mng.CreateDateEdit();
}
function DateEditSelectDate(name, date) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.SelectDate(date);
}
function DateEditSelectDay(name, id) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.SelectDay(id);
}
function DateEditSelectToday(name) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.SelectToday();
}
function DateEditShiftMonth(name, offset) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.ShiftMonth(offset);
}
function DateEditButtonClick(name) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.Toggle();
}
function DataEditKeyPress(name, e) {
	var dateedit = dxDateEdit.Mng.GetDateEdit(name);
	if( Exists(dateedit) ) dateedit.OnKeyPress(e);
}

dxDateEdit.Evt.Attach("window.onresize", function() { dxDateEdit.Mng.OnResize(); } );
window.onresize = function() { dxDateEdit.Evt.Exec("window.onresize"); }

dxDateEdit.Evt.Attach("window.document.onmousedown", function(e) { dxDateEdit.Mng.OnMouseDown(e); } );
window.document.onmousedown = function(e) { dxDateEdit.Evt.Exec("window.document.onmousedown", e); }

