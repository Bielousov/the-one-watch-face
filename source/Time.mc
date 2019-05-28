using Toybox.Application;

using Toybox.WatchUi as Ui;

enum { HOURS, MINUTES }
enum { HOURS_COLOR, MINUTES_COLOR }

class Time extends Ui.Drawable {
	private var App = Application.getApp();

	private var Fonts = {
		HOURS => null, 
		MINUTES => null
	};
	
	private var Properties = {
		HOURS_COLOR => null, 
		MINUTES_COLOR => null
	};
	
	
	function initialize(params) {
		Drawable.initialize(params);
		
		Fonts[HOURS] = Ui.loadResource(Rez.Fonts.HoursFont);
		Fonts[MINUTES] = Ui.loadResource(Rez.Fonts.MinutesFont);
	}
	
	function draw(dc) {
		drawHoursMinutes(dc);
	}
	
	function drawHoursMinutes(dc) {
		var formattedTime = getFormattedTime();
		
		var hoursColor = App.getProperty("HoursColor");
        var minutesColor = App.getProperty("MinutesColor");
        var x = 40;
        
        // Draw hours
		dc.setColor(hoursColor, Graphics.COLOR_TRANSPARENT);
		dc.drawText(
			x,
			100,
			Fonts[HOURS],
			formattedTime[HOURS],
			Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
		);
		
		// Draw minutes
		dc.setColor(minutesColor, Graphics.COLOR_TRANSPARENT);
		dc.drawText(
			x + 44,
			100,
			Fonts[MINUTES],
			formattedTime[MINUTES],
			Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
		);
		
		x += 64;
	}
	
	function getFormattedTime() {
		var clockTime = System.getClockTime();
		
		// 24 or 12 hours format
        if (!System.getDeviceSettings().is24Hour) {
            if (clockTime.hour > 12) {
                clockTime.hour = clockTime.hour - 12;
            }
        }
        
        return {
        	HOURS => clockTime.hour,
        	MINUTES => clockTime.min.format("%02d")
        };
	}
}