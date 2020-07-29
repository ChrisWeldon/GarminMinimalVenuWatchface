using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.Timer as Timer;
using Toybox.Activity as Activity;
using Toybox.UserProfile as UserProfile;

using Colors;
using HeartRateTarget;

// TODO get sunset sunrise
// TODO calcuate day gradient based on sunset and sunrise
// TODO calculate sun gradient based on sunset and sunrise

class WorkoutAvatarView extends Ui.WatchFace {
    // globals
    var debug = false;

	var deviceSettings = System.getDeviceSettings();
    // sensors / status
    var battery = 0;
    var bluetooth = true;
    var heartrate = 0;
    var heartrate_zones = null;

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
	
	var hr_palette = Colors.createPaletteFromHex([
		{"healthy" => 0x7bff82},
		{"weight" => 0x7bb5ff},
		{"aerobic" => 0xf5ff7b},
		{"threshold" => 0xffcd7b},
		{"redline" => 0xff7b7b}
	]);
	
	var day_palette = Colors.createPaletteFromHex([
		{"0_midnight" => 0x191469 },
		{"1_preastro" => 0x544eb4 },
		{"2_sunup" => 0xb7ecff },
		{"3_preday" => 0x00a3f2 },
		{"4_midday" => 0x0081ff },
		{"5_precivil" => 0x2a96ff },
		{"6_sundown" => 0xb176ff },
		{"7_prenight" => 0x544eb4 },
		
	]);
	
	var sun_palette = Colors.createPaletteFromHex([
		{"moonmid" => 0xdba7f9},
		{"moonend" => 0xdba7f9},
		{"sunstart" => 0xf3ff5e},
		{"sunend" => 0xf3ff5e},
		{"moonstart" => 0xdba7f9},
	]);
	
	var theme = new Colors.Palette([
		{"dominant" => new Colors.rgb(0x4281a4)},
		{"accent0" => new Colors.rgb(0x9cafb7)},
		{"accent1" => new Colors.rgb(0xead2ac)},
		{"accent2" => new Colors.rgb(0xe6b89c)},
		{"accent3" => new Colors.rgb(0xfe938c)},
		{"standard-light" => new Colors.rgb(0xecf8f8)},
		{"standard-dark" => new Colors.rgb(0x495867)},
		{"bluetooth" => new Colors.rgb(0x0077b6)}
	]);
	
	var sun_gradient;
	var watch_gradient;
	var h_grad;
	var heartrate_gradient;
	var hr_zones;
	// make concat return copy;
    function initialize() {
    	Ui.WatchFace.initialize();    	
    	
		hr_zones = UserProfile.getHeartRateZones(UserProfile.getCurrentSport());
		var hr_widths = new [5];
		for(var i=0; i<5;i++){
			hr_widths[i] = hr_zones[i+1]-hr_zones[i];
		}
		h_grad = Colors.createGradientFromPalette(day_palette, [15, 12, 13, 32, 32, 13, 12, 15] , true); // Widths add up to 144 for 144 10-minute intervals in the day
		heartrate_gradient = Colors.createGradientFromPalette(hr_palette, hr_widths, false);
		self.hr_palette.put("resting", 0xffffff); 
		
    }
   


    function onLayout(dc) {
      System.println("onLayout called");
      self.sun_gradient = Colors.createGradientFromPalette(sun_palette, [30, 2, 84, 2, 26], true);
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
      
      // get activity information
      heartrate = Activity.getActivityInfo().currentHeartRate;
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

      var x = dw/2 + Math.cos( (Math.PI/2) + (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
      var y = dh/2 + Math.sin( (Math.PI/2) + (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
      var radius = (dh > dw) ? dh : dw;
      
      watch_gradient = new Colors.Gradient(self.h_grad.get(min_tot), self.sun_gradient.get(min_tot), dw);
      
      Colors.drawCurvedGradientRA(dc, x, y, radius, watch_gradient);
      

      
      if(self.heartrate && self.heartrate >=self.hr_zones[0] && self.heartrate < self.hr_zones[5]){
      	dc.setColor(self.heartrate_gradient.get(self.heartrate-self.hr_zones[0]).toNumber(), Gfx.COLOR_TRANSPARENT);
      	dc.drawText(dw/2,(dh/2)+(dc.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_THAI_HOT)/2)-(dc.getFontHeight(Gfx.FONT_SYSTEM_MEDIUM)/2),Gfx.FONT_SYSTEM_MEDIUM, heartrate ,Gfx.TEXT_JUSTIFY_CENTER);
      }

      dc.setColor(self.theme.get("standard-dark").toNumber(), Gfx.COLOR_TRANSPARENT);
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
