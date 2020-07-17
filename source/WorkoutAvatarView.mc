using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.Timer as Timer;

using Design;

class WorkoutAvatarView extends Ui.WatchFace {
    // globals
    var debug = false;

    // sensors / status
    var battery = 0;
    var bluetooth = true;

    // time
    var hour = null;
    var minute = null;
    var day = null;
    var day_of_week = null;
    var month_str = null;
    var month = null;
    var min_tot = 0;

    // layout
    var dh = 0;
    var dw = 0;

    // settings
    var set_leading_zero = false;
    
	var rgb_night = new Design.rgb(0x16057d);
	var rgb_twi = new Design.rgb(0xbd89a3);
	var rgb_morn = new Design.rgb(0xfafec6);
	var rgb_day = new Design.rgb(0xaedfff);
	var rgb_noon = new Design.rgb(0x77bdff);
	var rgb_afternoon = new Design.rgb(0xf9814b);
	var rgb_dusk = new Design.rgb(0xff6363);
	
	
	var rgb_sun = new Design.rgb(0xffec77);
	var rgb_moon = new Design.rgb(0x3a3162);
	
	// Gradient Defenitions
	var night_grad = new Design.Gradient(rgb_night, rgb_twi, 36);
	var twi_grad = new Design.Gradient(rgb_twi, rgb_morn, 21); 
	var morn_grad = new Design.Gradient(rgb_morn, rgb_day, 15);
	var day_grad = new Design.Gradient(rgb_day, rgb_noon, 15);
	var noon_grad = new Design.Gradient(rgb_noon, rgb_afternoon, 12);
	var afternoon_grad = new Design.Gradient(rgb_afternoon, rgb_dusk, 21);
	var dusk_grad = new Design.Gradient(rgb_dusk, rgb_night, 24);
	
	var h_grad = night_grad.concat(twi_grad);
	
	var sun_gradient;
	
	var watch_gradient;
	// make concat return copy;
    function initialize() {
    	Ui.WatchFace.initialize();
    	
    	h_grad.concat(morn_grad);
		h_grad.concat(day_grad);
		h_grad.concat(noon_grad);
		h_grad.concat(afternoon_grad);
		h_grad.concat(dusk_grad);
    }


    function onLayout(dc) {
      System.println("onLayout called");
      self.sun_gradient = new Design.Gradient(rgb_sun, rgb_moon, 144);
      
      // w,h of canvas
      dw = dc.getWidth();
      dh = dc.getHeight();
      
    }


    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }
    


    //! Update the view
    function onUpdate(dc) {

      // grab time objects
      var clockTime = Sys.getClockTime();
      var date = Time.Gregorian.info(Time.now(),0);

      // define time, day, month variables
      hour = clockTime.hour;
      minute = clockTime.min;
      day = date.day;
      month = date.month;
      day_of_week = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).day_of_week;
      month_str = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).month;
      
      min_tot = Math.floor((hour*60 + minute)/10);
      
      // battery
      var stats = Sys.getSystemStats();
      var batteryRaw = stats.battery;
      battery = batteryRaw > batteryRaw.toNumber() ? (batteryRaw + 1).toNumber() : batteryRaw.toNumber();

      // bluetooth
      var deviceSettings = Sys.getDeviceSettings();
      bluetooth = deviceSettings.phoneConnected;
      
      if (hour > 12 || hour == 0) {
          if (!deviceSettings.is24Hour)
              {
              if (hour == 0)
                  {
                  hour = 12;
                  }
              else
                  {
                  hour = hour - 12;
                  }
              }
      }

      // add padding to units if required
      if( minute < 10 ) {
          minute = "0" + minute;
      }

      if( hour < 10 && set_leading_zero) {
          hour = "0" + hour;
      }

      if( day < 10 ) {
          day = "0" + day;
      }

      if( month < 10 ) {
          month = "0" + month;
      }


      // clear the screen
      dc.setColor(Gfx.COLOR_DK_BLUE, Gfx.COLOR_BLACK);
      dc.clear();

      // w,h of canvas

      var x = dw/2 + Math.cos( (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
      var y = dh/2 + Math.sin( (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
      var radius = (dh > dw) ? dh : dw;
      
      System.println(x + " " + y);
      
      
      watch_gradient = new Design.Gradient(self.h_grad.get(min_tot), self.rgb_sun, dw);
      
      Design.drawCurvedGradientRA(dc, x, y, radius, watch_gradient);
      
      dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
      dc.drawText(dw/2,(dh/2)-(dc.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_THAI_HOT)/2),Gfx.FONT_SYSTEM_NUMBER_THAI_HOT,hour.toString() + ":" + minute.toString(),Gfx.TEXT_JUSTIFY_CENTER);

    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
	  System.println("Exiting Sleep");

    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
      System.println("Entering Sleep");
    }
    

}
