/*
   ExpressWeb Framework by Developer Express
   ExpressWebCalendar

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
var dxCalendar = [];
dxCalendar["Inf"] = new dx_Info();
dxCalendar["Utl"] = new dx_Utils();
dxCalendar["Mng"] = new dx_CalendarManager();
dxCalendar["Obj"] = dxCalendar.Utl.CreateObjHelper();


// Class Calendar
function dx_Calendar()
{
  this.Name = "";
  this.Painter = new dx_CalendarPainter(this);

  this.Days = [];
  this.Monthes = [];
  this.Date = new Date();
  this.SelectedDayId = -1;
  this.SelectedDate = new Date();
  this.WeekStart = 0;
  this.WeekEnd = 6;
  this.ShowYear = false;
// Actions procedures
  this.SelectDateProc = "";
  this.ShiftMonthProc = "";
// Date format
  this.DateFormat = "";
  this.DateSeparator = "";
// Events
  this.OnSelectDay = null;
  this.OnShiftMonth = null;
  this.OnValidateEditText = null;
// Server events
  this.AssignOnSelectDay = true;
  this.AssignOnNextMonth = true;
  this.AssignOnPrevMonth = true;  
  
  this.GetSelectDateElement = function() {
  	return dxCalendar.Obj.GetElementById(this.Name + "__cxwebcalendar_selectedday");
  }
  this.GetControlDateElement = function() {
  	return dxCalendar.Obj.GetElementById(this.Name + "__cxwebcalendar_ctrlday");  	
  }
  this.FillSheet = function() { 
	var firstDate = this.GetFirstDateOfMonth(this.Date);
	var lastDate = this.GetLastDateOfMonth(this.Date);
	var firstDayOffset = firstDate.getDay();
	if(firstDayOffset < 0) firstDayOffset = 6;
	var lastDayOffset = lastDate.getDay();
	if(lastDayOffset < 0) lastDayOffset = 6;
	prevDate = new Date(this.Date);
	prevMonthDayCount = this.GetLastDateOfMonth(prevDate.setMonth(prevDate.getMonth() - 1)).getDate();

        this.Days = [];
        var i, ADateItem, AIsSelected, currentDate;
        this.SelectedDayId = -1;

	if(firstDayOffset != this.WeekStart) {
		for(i = 6; i >= 0; i --) {
		    if(firstDayOffset == this.WeekStart)  {
			    currentDate = new Date(firstDate);
                            currentDate.setDate(currentDate.getDate() - i - 1);
			    AIsSelected = this.CompareDates(this.SelectedDate, currentDate);
			    if(AIsSelected) this.SelectedDayId = this.Days.length;
			    ADateItem = new dx_CalendarDateItem(currentDate, (prevMonthDayCount - i), true, AIsSelected);
			    this.Days[this.Days.length] = ADateItem;
		    }
		    else firstDayOffset ++;
		    if(firstDayOffset > 6) firstDayOffset = 0;
		}
	}

        for(i = 1; i <= lastDate.getDate(); i ++) {
             currentDate = new Date(this.Date.getFullYear(), this.Date.getMonth(), i);
             AIsSelected = this.CompareDates(this.SelectedDate, currentDate);
             if(AIsSelected) this.SelectedDayId = this.Days.length;
             ADateItem = new dx_CalendarDateItem(currentDate, i, false, AIsSelected);
             this.Days[this.Days.length] = ADateItem;
        }


        if(lastDayOffset != this.WeekEnd) {
                for(i = 1; i < 7; i ++) {
                        currentDate = new Date(lastDate);
                        currentDate.setDate(currentDate.getDate() + i);
                        AIsSelected = this.CompareDates(this.SelectedDate, currentDate);
                        if(AIsSelected) this.SelectedDayId = this.Days.length;
                        ADateItem = new dx_CalendarDateItem(currentDate, i, true, AIsSelected);
                        this.Days[this.Days.length] = ADateItem;

                        lastDayOffset ++;
                        if(lastDayOffset > 6) lastDayOffset = 0;
                        if(lastDayOffset == this.WeekEnd) break;
                }
        }
  }
  this.SelectDate = function(date) {
        var AllowAction = true;
        if(this.OnSelectDay) {
        	AllowAction = this.OnSelectDay(this, date);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
        	if(this.AssignOnSelectDay) {
                	var DateStr = date.getFullYear() + ":" + eval(date.getMonth() + 1) + ":" + date.getDate();
			__doPostBack(this.Name, "SELECTDAY:" + DateStr);
        	} else {        	
	                this.SelectedDate.setTime(date);
	                this.Date.setTime(date);
	                this.FillSheet();
	                this.Painter.RerenderAll();
	                this.Painter.SetSelect();
	                var selectElement = this.GetSelectDateElement();
	                if( Exists(selectElement) ) {
	                	selectElement.value = this.Days[this.SelectedDayId].Date.getFullYear() + ":" + eval(this.Days[this.SelectedDayId].Date.getMonth() + 1) + ":" + this.Days[this.SelectedDayId].Date.getDate();
	                	var controlElement = this.GetControlDateElement();                    	
	                	if( Exists(controlElement) ) controlElement.value = selectElement.value;
	                }
		}	                
        }
  }
  this.SelectToday = function() {
        today = new Date();
	this.SelectDate(today);
  }
  this.SelectDay = function (id) {
        var AllowAction = true;
        if(this.OnSelectDay) {
        	AllowAction = this.OnSelectDay(this, this.Days[id].Date);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
        	if(this.AssignOnSelectDay) {
                	var DateStr = this.Days[id].Date.getFullYear() + ":" + eval(this.Days[id].Date.getMonth() + 1) + ":" + this.Days[id].Date.getDate();
			__doPostBack(this.Name, "SELECTDAY:" + DateStr);
        	} else {        	
	                if(!this.Days[id].IsOtherMonth)
	                {
	                        this.Painter.RemoveSelect();
	                        this.SelectedDayId = id;
	                        this.SelectedDate.setTime(this.Days[id].Date);
	                        this.Painter.SetSelect();
		                var selectElement = this.GetSelectDateElement();
	        	        if( Exists(selectElement) )
	                	{
	                		selectElement.value = this.Days[id].Date.getFullYear() + ":" + eval(this.Days[id].Date.getMonth() + 1) + ":" + this.Days[id].Date.getDate();
	        	        	var controlElement = this.GetControlDateElement();                    	
	                		if( Exists(controlElement) ) controlElement.value = selectElement.value;
		                }
	                }
	                else
	                {
	                        this.SelectedDate.setTime(this.Days[id].Date);
	                        var offset = (id <= 7)? -1 : 1;
	                	this.Date.setMonth(this.Date.getMonth() + offset);
	                	this.FillSheet();
	                	this.Painter.RerenderAll();
	                        this.Painter.SetSelect();
		                var selectElement = this.GetSelectDateElement();
	        	        if( Exists(selectElement) )
	                	{
	                        	selectElement.value = this.Days[this.SelectedDayId].Date.getFullYear() + ":" + eval(this.Days[this.SelectedDayId].Date.getMonth() + 1) + ":" + this.Days[this.SelectedDayId].Date.getDate();
	        	        	var controlElement = this.GetControlDateElement();                    	
	                		if( Exists(controlElement) ) controlElement.value = selectElement.value;
	                	}
	                }
	        }
        }
  }
  this.ShiftMonth = function(offset) {
        var AllowAction = true;
        if(this.OnShiftMonth) {
        	AllowAction = this.OnShiftMonth(this, offset);
		if(typeof AllowAction == "undefined") AllowAction = true;
	}
        if(AllowAction == true) {
        	if(this.AssignOnNextMonth && offset > 0) {
			__doPostBack(this.Name, "NEXTMONTH");
        	} else if(this.AssignOnPrevMonth && offset < 0) {
			__doPostBack(this.Name, "PREVMONTH");
		} else {        	
	        	this.Date.setMonth(this.Date.getMonth() + offset);
	                this.FillSheet();
	                this.Painter.RerenderAll();
	        	var controlElement = this.GetControlDateElement();                    	
	                if( Exists(controlElement) ) 
	                	controlElement.value = this.Date.getFullYear() + ":" + eval(this.Date.getMonth() + 1) + ":" + this.Date.getDate();
		}	       
        }
  }
  this.GetFirstDateOfMonth = function (d) {
	var td = new Date(d);
	while(td.getDate() > 1) td.setDate(td.getDate() - 1);
	return td;
  }
  this.GetLastDateOfMonth = function (d) {
	var td = new Date(d);
	do td.setDate(td.getDate() + 1);
	while(td.getDate() != 1);
	td.setDate(td.getDate() - 1);
	return td;
  }
  this.CompareDates = function (d1, d2) {
	return d1.getFullYear() == d2.getFullYear() ? d1.getMonth() == d2.getMonth() ? d1.getDate() == d2.getDate() : false : false;
  }
}

// Class CalendarDateItem
function dx_CalendarDateItem(aDate, aDay, aIsOtherMonth, aSelected)
{
  this.Date = aDate;
  this.Day = aDay;
  this.IsOtherMonth = aIsOtherMonth;
  this.Selected = aSelected;
}

// Class CalendarPainter
function dx_CalendarPainter(ACalendar)
{
  this.Calendar = ACalendar;
  this.MonthIDPostfix = "";
  this.SheetIDPostfix = "";
  this.DayIDPostfix = "";

  this.StartSheet = '<table border="0" cellspacing="0" cellpadding="0" width="100%">\r\n';
  this.EndSheet = '</table>\r\n';
  this.StartSelect = '<table bgcolor="red" cellpadding="1" cellspacing="0" width="100%" border="0"><tr><td align="center"><table border="0" bgcolor="white" cellpadding="0" cellspacing="0" width="100%"><tr><td align="center">\r\n';
  this.EndSelect = '</td></tr></table></td></tr></table>\r\n';
  this.DayStyleHTML = "";
  this.DayOtherStyleHTML = "";

  this.RenderMonth = function() {
	var year = this.Calendar.ShowYear ? "&nbsp;" + this.Calendar.Date.getFullYear() : "";
	dxCalendar.Obj.GetElementById(this.Calendar.Name + this.MonthIDPostfix).innerHTML = this.Calendar.Monthes[this.Calendar.Date.getMonth()] + year;
  }
  this.RerenderAll = function() {
	this.RenderMonth();
	this.RenderSheet();
  }
  this.RenderSheet = function() {
	var sheet = dxCalendar.Obj.GetElementById(this.Calendar.Name + this.SheetIDPostfix);
	var s = this.StartSheet;
	var selectPresent = false;

	for(var i = 0; i < this.Calendar.Days.length; i ++)
        {
		if(i % 7 == 0) s += "<tr>";
                if(this.Calendar.CompareDates(this.Calendar.SelectedDate, this.Calendar.Days[i].Date)) selectPresent = true;
                var style = this.Calendar.Days[i].IsOtherMonth ? this.DayOtherStyleHTML : this.DayStyleHTML;

                s += "<td align=\"center\" id="+ this.Calendar.Name + this.DayIDPostfix + i + "><a href=\"javascript:" + 
	                this.Calendar.SelectDateProc + "(&quot;" + this.Calendar.Name + "&quot;," + (i).toString() + ")" + 
        	        "\" style=\"" + style + "\">" + this.Calendar.Days[i].Day + "</a></td>\r\n";
		if((i + 1) % 7 == 0) s +="</tr>";
	}
	s += this.EndSheet;
	sheet.innerHTML = s;
	if(selectPresent) this.SetSelect();
  }
  this.RemoveSelect = function() {
	if(this.Calendar.SelectedDayId > -1) {
		var style = this.Calendar.Days[this.Calendar.SelectedDayId].IsOtherMonth ? this.DayOtherStyleHTML : this.DayStyleHTML;
		var Cell = dxCalendar.Obj.GetElementById(this.Calendar.Name + this.DayIDPostfix + this.Calendar.SelectedDayId);
		Cell.innerHTML = "<a href=\"javascript:" + this.Calendar.SelectDateProc + "(&quot;" + this.Calendar.Name + "&quot;, " + this.Calendar.SelectedDayId + ")\" style=\"" + style + "\">" + this.Calendar.SelectedDate.getDate() + "</a>";
	}
  }
  this.SetSelect = function() {
	if(this.Calendar.SelectedDayId > -1) {
                var style = this.DayStyleHTML;
		var Cell = dxCalendar.Obj.GetElementById(ACalendar.Name + this.DayIDPostfix + this.Calendar.SelectedDayId);
		Cell.innerHTML = this.StartSelect + "<a href=\"javascript:" + this.Calendar.SelectDateProc + "(&quot;" + this.Calendar.Name + "&quot;, " + this.Calendar.SelectedDayId + ")\" style=\"" + style + "\">" + this.Calendar.SelectedDate.getDate() + "</a>" + this.EndSelect;
	}
  }
}

// Class CalendarManager
function dx_CalendarManager()
{
  this.calendars = [];

  this.CreateCalendar = function() { 
  	var calendar = new dx_Calendar(); 
  	this.calendars.Add(calendar);
  	return calendar; 
  }
  this.GetCalendar = function(AName) {
	for(var i = 0; i < this.calendars.length; i++)
		if(AName == this.calendars[i].Name) return this.calendars[i];
	return null;
  }
}

function CreateCalendar() {
	return dxCalendar.Mng.CreateCalendar();
}
function CalendarSelectDate(name, date) {
	var calendar = dxCalendar.Mng.GetCalendar(name);
	if( Exists(calendar) ) calendar.SelectDate(date);
}
function CalendarSelectDay(name, id) {
	var calendar = dxCalendar.Mng.GetCalendar(name);
	if( Exists(calendar) ) calendar.SelectDay(id);
}
function CalendarSelectToday(name) {
	var calendar = dxCalendar.Mng.GetCalendar(name);
	if( Exists(calendar) ) calendar.SelectToday();
}
function CalendarShiftMonth(name, offset) {
	var calendar = dxCalendar.Mng.GetCalendar(name);
	if( Exists(calendar) ) calendar.ShiftMonth(offset);
}