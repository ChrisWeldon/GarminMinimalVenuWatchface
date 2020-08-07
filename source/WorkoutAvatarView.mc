/*
 * Minimalist Watchface, Color Monkey Barrel Showcase project
 * Built for the Garmin Connect IQ challenge 2020.
 *
 * @author Christopher Evans
 * @Github www.github.com/ChrisWeldon
 * @email cwevans@umass.edu
 */

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

	var deviceSettings = System.getDeviceSettings();
    // sensors / status
    var battery = 0;
    var charging = false;
    var bluetooth = true;
    var hr = 0;
    var hr_zones;
	var hr_widths;

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
    
    
	// Palette Defenitions
	const hr_palette = Colors.createPaletteFromHex([
		{"resting" => 0xffffff},
		{"healthy" => 0x7bff82},
		{"weight" => 0x7bb5ff},
		{"aerobic" => 0xf5ff7b},
		{"threshold" => 0xffcd7b},
		{"redline" => 0xff7b7b}
	]);
	
	const day_palette = Colors.createPaletteFromHex([
		{"0_midnight" => 0x191469 },
		{"1_preastro" => 0x544eb4 },
		{"2_sunup" => 0xffc2b7 },
		{"3_preday" => 0x00a3f2 },
		{"4_midday" => 0x0081ff },
		{"5_precivil" => 0x2a96ff },
		{"6_sundown" => 0xff76a2 },
		{"7_prenight" => 0x544eb4 },
		
	]);
	
	const sun_palette = Colors.createPaletteFromHex([
		{"moonmid" => 0x41324a},
		{"moonend" => 0xdba7f9},
		{"sunstart" => 0xf3ff5e},
		{"sunend" => 0xf3ff5e},
		{"moonstart" => 0xdba7f9},
	]);
	
	const battery_palette = new Colors.Palette([
		{0 => Colors.valsToRGB(255, 0, 0)},
		{.25 => Colors.valsToRGB(255, 175, 0)},
		{.5 => Colors.valsToRGB(255, 255, 0)},
		{.75 => Colors.valsToRGB(0, 255, 0)},
	]);
	
	const theme = new Colors.Palette([
		{"dominant" => new Colors.rgb(0x4281a4)},
		{"accent0" => new Colors.rgb(0x9cafb7)},
		{"accent1" => new Colors.rgb(0xead2ac)},
		{"accent2" => new Colors.rgb(0x8a8b73)},
		{"accent3" => new Colors.rgb(0xdadaca)},
		{"standard-light" => new Colors.rgb(0xffffeb)},
		{"standard-dark" => new Colors.rgb(0x495867)},
		{"bluetooth" => new Colors.rgb(0x0077b6)}
	]);
	
	const week = [
		"Sunday",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday"
	];
	
	// Gradients
	var sun_grad;
	var watch_grad;
	var sky_grad;
	var hr_grad;
	var battery_grad;
	var bt_bitmap;
	
	
	// Note: Some gradients are calculated at different times to avoid triggering Watchdog
    function initialize() {
    	Ui.WatchFace.initialize();    	
    	
		hr_zones = UserProfile.getHeartRateZones(UserProfile.getCurrentSport());
		hr_widths = new [5];
		for(var i=0; i<5;i++){
			hr_widths[i] = hr_zones[i+1]-hr_zones[i];
		}
		
		sky_grad = Colors.createGradientFromPalette(day_palette, [15, 12, 13, 32, 32, 13, 12, 15] , true);
		hr_grad = Colors.createGradientFromPalette(hr_palette, hr_widths, false);
		
		bt_bitmap = new Gfx.BufferedBitmap({
			:height => 64,
			:width => 64,
			:bitmapResource => Ui.loadResource(Rez.Drawables.bluetooth)
		});
		
    }
   


    function onLayout(dc) {
		System.println("onLayout called");
		  
		self.sun_grad = Colors.createGradientFromPalette(sun_palette, [29, 4, 82, 4, 25], true);
		self.battery_grad = Colors.createGradientFromPalette(battery_palette, [33, 33, 34], false);
		self.bt_bitmap.setPalette([self.theme.get("standard-dark").toNumber(), -1]);  
		  
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
		
		// Get time info
		var clockTime = Sys.getClockTime();
		var date = Time.Gregorian.info(Time.now(),0);  
		hour = clockTime.hour;
		minute = clockTime.min;
		day = date.day;
		month = date.month;
		day_of_week = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT).day_of_week;
		month_str = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).month;
		min_tot = Math.floor((hour*60 + minute)/10);  
		
		// Get activity info
		self.hr = Activity.getActivityInfo().currentHeartRate;
		
		// Get battery info
		var stats = Sys.getSystemStats();
		var batteryRaw = stats.battery;
		battery = batteryRaw >= 100 ? 99 : batteryRaw.toNumber();
		charging = stats.charging;
		
		// Get bluetooth info
		bluetooth = deviceSettings.phoneConnected;      
		
		if((hour > 12 || hour == 0) && !deviceSettings.is24Hour) {
			if(hour == 0){
				hour = 12;
			}else {
				hour = hour - 12;
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
		
		// calculate sun's location
		var x = dw/2 + Math.cos( (Math.PI/2) + (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
		var y = dh/2 + Math.sin( (Math.PI/2) + (min_tot.toDouble()/144)*(Math.PI*2) ) * dw/2;
		var radius = (dh > dw) ? dh : dw;
		
		// build backdrop gradient from time of day
		watch_grad = new Colors.Gradient(self.sky_grad.get(min_tot), self.sun_grad.get(min_tot), dw);
		
		// Paint the gradient
		Colors.drawCurvedGradientRA(dc, x, y, radius, watch_grad);
		
		// Determine layout and color of heartrate
		if(self.hr && self.hr >= self.hr_zones[0]){
		
			// Colors of the heartrate typeface are determined by the users specific aerobic zones
			if(self.hr-self.hr_zones[0] >= self.hr_grad.size()){
				dc.setColor(self.hr_palette.get("redline").toNumber(), Gfx.COLOR_TRANSPARENT);
			}else if(self.hr >= self.hr_zones[0]){
				dc.setColor(self.hr_grad.get(self.hr-self.hr_zones[0]).toNumber(), Gfx.COLOR_TRANSPARENT);
			}else{
				dc.setColor(self.hr_palette.get("resting").toNumber(), Gfx.COLOR_TRANSPARENT);
			}
			
			// Draw text offset from center
			dc.drawText(dw/2,(dh/2)+(dc.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_THAI_HOT)/2)+(dc.getFontHeight(Gfx.FONT_SYSTEM_MEDIUM)/2),Gfx.FONT_SYSTEM_MEDIUM, hr ,Gfx.TEXT_JUSTIFY_CENTER);
		}

		// Use theme to help color the rest of the UI
		dc.setColor(self.theme.get("standard-light").toNumber(), Gfx.COLOR_TRANSPARENT);
		dc.drawText(dw/2,(dh/2)-(dc.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_THAI_HOT)/2)-(dc.getFontHeight(Gfx.FONT_TINY)/2),Gfx.FONT_SYSTEM_NUMBER_THAI_HOT,hour.toString() + ":" + minute.toString(),Gfx.TEXT_JUSTIFY_CENTER);
		
		// Allow for better visibility of typeface during sunset and sunrise.
		if((min_tot<48 && min_tot>27) || (min_tot<123 && min_tot>105)){
			dc.setColor(self.theme.get("accent2").toNumber(), Gfx.COLOR_TRANSPARENT);
		}else{
			dc.setColor(self.theme.get("accent3").toNumber(), Gfx.COLOR_TRANSPARENT);
		}
		dc.drawText(dw/2,(dh/2)+(dc.getFontHeight(Gfx.FONT_TINY)),Gfx.FONT_TINY, self.week[self.day_of_week.toNumber()-1] + ", " + self.month_str + " " + self.day ,Gfx.TEXT_JUSTIFY_CENTER);
		 
		 
		// Location of helper icons such as battery and bluetooth
		var rx = dw/2 - 18;
		var ry = dh-25;
		  
		if(bluetooth){
			dc.drawBitmap(rx-16, ry-6, bt_bitmap);
		  	rx = rx + 16;
		}
		  
		// draw battery
		dc.setColor((self.charging ? self.battery_palette.get(0.75).toNumber() : self.battery_grad.get(Math.floor(battery).toNumber()).toNumber()), Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(rx, ry, 2 + 29*(batteryRaw/100), 15);
		  
		// Icon color determined by theme, fill color determined by remaining charge
		dc.setColor(self.theme.get("standard-dark").toNumber(), Gfx.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
		dc.drawRoundedRectangle(rx, ry , 32, 16, 2);
		dc.drawRoundedRectangle(rx + 31, ry + 2 , 4, 12, 4);
		dc.setPenWidth(1);
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
