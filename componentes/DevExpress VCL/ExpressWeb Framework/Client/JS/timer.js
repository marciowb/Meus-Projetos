/*
   ExpressWeb Framework by Developer Express
   ExpressWebTimer

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
var dxTimer = [];
dxTimer["Mng"] = new dx_TimerManager();
dxTimer["Evt"] = new dx_EventManager();

// Class Timer
function dx_Timer()
{
  this.Name = "";
  this.Enabled = true;	
  this.Interval = 0;
  this.AssignOnTimer = false;
  this.TimerID = 0;
// Events
  this.OnTimer = null;
}

// Class TimerManager
function dx_TimerManager()
{
  this.timers = [];

  this.Initialize = function() {
	for(var i = 0; i < this.timers.length; i++) {
		this.timers[i].TimerID = window.setTimeout("dxTimer.Mng.DoTimerEvent('" + this.timers[i].Name + "')", this.timers[i].Interval);	                
	}
  }
  this.CreateTimer = function() { 
  	var timer = new dx_Timer(); 
  	this.timers.Add(timer);
  	return timer; 
  }
  this.GetTimer = function(AName) {
	for(var i = 0; i < this.timers.length; i++)
		if(AName == this.timers[i].Name) return this.timers[i];
	return null;
  }
  this.DoTimerEvent = function(AName) {
	var timer = dxTimer.Mng.GetTimer(AName);
	if( Exists(timer) ) {
		window.clearTimeout(timer.TimerID);
		if(timer.Enabled) {
			if( Exists(timer.OnTimer) ) timer.OnTimer();
			if(timer.AssignOnTimer) __doPostBack(timer.Name, "TIMER");
		}
		timer.TimerID = window.setTimeout("dxTimer.Mng.DoTimerEvent('" + timer.Name + "')", timer.Interval);	
	}
  }
}

function CreateTimer() {
	return dxTimer.Mng.CreateTimer();
}

dxTimer.Evt.Attach("window.onload", function() { dxTimer.Mng.Initialize(); } );
window.onload = function() { dxTimer.Evt.Exec("window.onload"); }
