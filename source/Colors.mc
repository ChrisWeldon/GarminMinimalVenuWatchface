/*
 * Color Monkey Barrel
 * Built for the Garmin Connect IQ challenge 2020.
 *
 * @author Christopher Evans
 * @Github www.github.com/ChrisWeldon
 * @email cwevans@umass.edu
 */


using Toybox.Lang as Lang;
using Toybox.Math as Math; 
using Toybox.Graphics as Graphics;
using Toybox.System as Sys;
using Toybox.Test as Test;

module Colors{

/**
 *	A type to represent and minipulate colors for the individul values of Red, Green, and Blue
 */
class rgb extends Lang.Number{

	protected var r, g, b;
	protected var hex;
	
	/**
	 * Constructor
	 * @param a hex value for the desired color
	 */
	function initialize(hex) {
		Number.initialize();
		
    	self.r = (hex & 0xFF0000)>>16;
    	self.g = (hex & 0x00FF00)>>8;
    	self.b = (hex & 0x0000FF);
    	self.hex = hex;
	}	

	/**
	 * @returns (Toybox:Lang:String)	a readable string of the rgb values
	 */
	function toString() {
		return ("rgb(" + self.r + ", " + self.g + ", " + self.b + ")");
	}
	
	/**
	 * @returns (Toybox:Lang:Number)	a number representation of the instance
	 */
	function toNumber() {
		return self.hex.toNumber();
	}
	
	/**
	 * @params val (Toybox:Lang:Number)	set Red to from [0, 255] inclusive
	 * @returns (Colors:rgb)		returns self
	 */
	function setR(val) {
		self.r = val;
		// Update hexadecimal Red val and concat with old Green Blue vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) << 16 | (self.hex.toLong() & 0x00FFFF);
		return self;
	}
	
	/**
	 * @params val (Toybox:Lang:Number)	set Green to from [0, 255] inclusive
	 * @returns (Colors:rgb)		returns self	
	 */
	function setG(val) {
		self.g = val;
		// Update hexadecimal Green val and concat with old Red Blue vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) << 8 | (self.hex.toLong() & 0xFF00FF);
		return self;
	}
	
	/**
	 * @params val (Toybox:Lang:Number)	set Blue to from [0, 255] inclusive
	 * @returns (Colors:rgb)		returns self
	 */
	function setB(val) {
		self.b = val;
		// Update hexadecimal Blue val and concat with old Red Green vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) | (self.hex.toLong() & 0xFFFF00);
		return self;
	}
	
	/**
	 * @params r (Toybox:Lang:Number)	a Number to set Red to from [0, 255] inclusive
	 * @params g (Toybox:Lang:Number)	a Number to set Green to from [0, 255] inclusive
	 * @params b (Toybox:Lang:Number)	a Number to set Blue to from [0, 255] inclusive
	 * @returns (Colors:rgb)		returns self
	 */
	function setRGB(r, g, b){
		self.r = r;
		self.g = g;
		self.b = b;

		self.hex = r.toLong() & 0x0000FF << 16 | g.toLong() & 0x0000FF << 8 | b.toLong() & 0x0000FF;
		return self;
	}
	
	/*
	 * @returns (Toybox:Lang:Number)
	 */	
	function getR(){
		return self.r;
	}
	
	/*
	 * @returns (Toybox:Lang:Number)
	 */
	function getG(){
		return self.g;
	}
	
	/*
	 * @returns (Toybox:Lang:Number)
	 */
	function getB(){
		return self.b;
	}
	
	/*
	 * @returns (Toybox:Lang:Dictionary)	returns dictionary with keys "r", "g", "b" each associating with a Toybox:Lang:Number
	 */
	function getRGB(){
		return {
			'r' => self.r,
			'g' => self.g,
			'b' => self.b		
		};
	}
	
	/*
	 * @param c (Colors:rgb)	the color to add to self
	 * @returns (Colors:rgb)	the	result color after addition
	 */
	function add(c){
		return new rgb(self.toNumber() + c.toNumber());
	}
	
	/*
	 * @param c (Colors:rgb)	the color to subtract to self
	 * @returns (Colors:rgb)	the	result color after subtract
	 */
	function subtract(c){
		return new rgb(self.toNumber() - c.toNumber());
	}
	
	/*
	 * @returns (Color:rgb)	a duplicate of self
	 */
	function copy(){
		return new rgb(hex);
	}
}

/**
 * A helper function to allow for creation of rgb object through individual r g b values
 *
 * @param r (Toybox:Lang:Number)	the value from [0, 255] inclusive for Red
 * @param g (Toybox:Lang:Number)	the value from [0, 255] inclusive for Green
 * @param b (Toybox:Lang:Number)	the value from [0, 255] inclusive for Blue
 * @returns (Colors:rgb)	the	result color after creation
 */
function valsToRGB(r, g, b){
	return new rgb(0x000000).setRGB(Math.round(r), Math.round(g), Math.round(b));
}

// TODO

/**
 * A helper function to create a random rgb value
 * 
 * @returns (Colors:rgb)
 */
function randRGB(){
	return new rgb(0xFFFFFF & Math.rand());
}

/**
 * A class to represent a collection of grading colors
 *
 * Gradient implments iterator-esque methods to allow easier creation of drawing methods
 */
class Gradient {

	protected var outer;
	protected var inner;
	protected var scale;
		
	protected var r_step;
	protected var g_step;
	protected var b_step;
	
	protected var step_count;
	protected var multi;
	
	protected var rgb;
	
	protected var grad;
	
	
	// TODO: implement array of colors
	// TODO: gradient inflection param
	// TODO: step function param
	/*
	 * Gradient Constructor
	 * @param outer (Colors:rgb)	left boundry of gradient
	 * @param inner (Colors:rgb)	right boundry of gradient
	 * @param w (Toybox:Lang:Number)	the number of steps for the gradient
	 */
	function initialize(outer, inner, w) {
		scale = w;
		
		var inner_vals = inner.getRGB();
		var outer_vals = outer.getRGB();
		
		r_step = (inner_vals['r']-outer_vals['r']).toDouble()/scale;
    	g_step = (inner_vals['g']-outer_vals['g']).toDouble()/scale;
    	b_step = (inner_vals['b']-outer_vals['b']).toDouble()/scale;
    	
    	self.outer = outer;
    	self.inner = inner;
    	
    	multi = 1;
    	step_count = 0;
    	
    	grad = new [w];
    	
    	for(var i=0;i<w;i++){
    		var r = (outer_vals['r']+r_step*i).toDouble();
			var g = (outer_vals['g']+g_step*i).toDouble();
			var b = (outer_vals['b']+b_step*i).toDouble();
			self.grad[i] =  Colors.valsToRGB(r, g, b);
    	}
    	
	}
	
	/*
	 * Combines gradients on end to create a compound gradient.
	 * This function mutates the instance
	 * 
	 * @param (Colors:Gradient)	gradient to added
	 * @returns (Colors:Gradient)	returns self
	 */
	function concat(gradient){
		self.grad.addAll(gradient.toArray());
		self.scale = self.scale + gradient.size();
		return self;
	}
    	
	/*
	 * @returns (Toybox:Lang:Boolean)	if another color exists after current
	 */
	function hasNext() {
		return step_count < scale-1;
	}
	
	/*
	 * @returns (Toybox:Lang:Boolean)	if another color exists prior to current
	 */
	function hasPrev() {
		return step_count > 0;
	}
	
	/*
	 * @returns (Colors:rgb)	returns next color in gradient
	 */
	function next() {
		step_count++; // Incrementing step prior to access to prepare for potential prev() call
		return self.grad[step_count];
	}
	
	/*
	 * @returns (Colors:rgb)	returns previous color in gradient
	 */
	function prev() {
		step_count--; // Decrementing step prior to access to prepare for potential next() call
		return self.grad[step_count];
	}
	
	/*
	 * @returns (Toybox:Lang:Number)	returns index of current color
	 */
	function getStep(){
		return step_count;
	}
	
	/*
	 * @returns (Toybox:Lang:Number)	returns number of total colors in gradient
	 */
	function size(){
		return self.scale;
	}
	
	/*
	 * @param i	(Toybox:Lang:Number)	index of desired color
	 * @returns (Colors:rgb)	returns rgb at index i
	 */
	function get(i){
		// Allows for gradient shifting and looping. Also protects from need for assertions.
		if(i>=scale){
			i = i-scale;
		}
		if(i<0){
			i = scale+i;
		}
		return grad[i];
	}
	
	function toArray(){
		return self.grad;
	}
	
}
/*
 * An object to represent an ordered collection of rgb colors
 */
class Palette extends Lang.Array{
	var keys = [];
	var values = [];
	
	/*
	 * @param array (Toybox:Lang:Array<Toybox:Lang:Dictionary>) an array of dictionaries
	 *    	  eg:	[
	 *					{:symbol => (Colors:rgb)}
	 *				]
	 * Note: the odd parameter format is to preserve the visually simple dictionary
	         definition while also allowing for ordered elements. Still exploring alternatives. 
	 */
	function initialize(array){
		Array.initialize();
		for(var i=0; i<array.size(); i++){
			keys.add(array[i].keys()[0]);
			values.add(array[i].values()[0]);
		}
	}
	
	/*
	 * @returns (Toybox:Lang:String)	A readable string representation of the palette colors
	 */
	function toString(){
		var ret = "PALETTE: ";
		for(var i=0; i<self.keys.size(); i++ ){
			ret = ret + self.keys[i].toString() + "=>" + self.values[i].toString()  + (i<self.keys.size()-1 ? ", " : "") ;
		}
		
		return ret;
	}
	
	/*
	 * @returns (Toybox:Lang:Array) returns an array of the instances values
	 */
	function getValues(){
		return self.values;
	}
	
	/*
	 * @returns (Toybox:Lang:Array)	returns and array of the instances keys
	 */
	function getKeys(){
		return self.keys;
	}
	
	/*
	 * @param name (Toybox:Lang:Symbol)	the key of requested value
	 * @returns (Colors:rgb)	the color coorosponding to the requested value
	 */
	function get(name){
		// FIXME: make constant time implementation
		for(var i=0; i<keys.size(); i++){
			if(name.equals(keys[i])){
				return values[i];
			}
		}
		return null;
	}
	
	/*
	 * @param key (Toybox:Lang:Symbol)	the key to be added, or changed if existing
	 * @param val (Color:rgb)	the value to be indexed
	 * @returns (Colors:Palette)	self
	 */
	function put(key, val){
		//TODO update existing values
		self.keys.add(key);
		self.values.add(val);
		return self;
	}
	
}

/*
 * A helper function to build a Colors:Palette from an array of dictionaries containing Hex (Toybox:Lang:Number)
 * 	values instead of rgb values (Colors:rgb)
 *
 * @param array (Toybox:Lang:array) an array of dictionaries
 *    	  eg:	[
 *					{:symbol => (Toybox:Lang:Number)}
 *				]
 * @returns (Colors:Palette)
 */
function createPaletteFromHex(array){
	var p = new Palette([]);
	
	for(var i=0; i<array.size(); i++ ){
		p.put(array[i].keys()[0], new rgb(array[i].values()[0]));
	}
	
	return p;
	
}

/**
 * A helper function to build a Colors:Gradient from a Colors:Palette
 * 
 * @param palette (Colors:Palette)	a palette containing the (Colors:rgb) which will be compiled into a gradient
 * @param widths (Toybox:Lang:Array) an array of (Toybox:Lang:Numbers) determining the width of the grade between 
 * 									 each palette color. width.size() == palette.size()-1
 * @param circular (Toybox:Land:Boolean)	true concats gradient of last palette color to first. If true
 *											widths.size() == palette.size()
 * @returns (Colors:Gradient)
 */
function createGradientFromPalette(palette, widths, circular){

 	var colors = palette.getValues();
	var grad = new Colors.Gradient(colors[0], colors[1], widths[0]);
	
	for(var i=1; i<colors.size()-1; i++){
		grad.concat(new Colors.Gradient(colors[i], colors[i+1], widths[i]));
	}
	
	if(circular){
		grad.concat(new Colors.Gradient(colors[colors.size()-1], colors[0], widths[colors.size()-1]));
	}
	
	return grad;
}

/*
 * A helper function to draw a circular gradient
 *
 * @param dc (Toybox:Graphics:Dc)	the device context
 * @param x (Toybox:Lang:Number)	the x coord for the circular gradient center
 * @param y (Toybox:Lang:Number)	the y coord for the cicular gradient center
 * @param r (Toybox:Lang:Number)	the radius for the circular gradient
 * @param gradient (Colors:Gradient)	the gradient to draw
 */
function drawCurvedGradient(dc, x, y, r, gradient){
	while(gradient.hasNext()) {
		dc.setColor(gradient.next().toNumber(), Graphics.COLOR_BLACK);
		dc.fillCircle(x, y, r-gradient.getStep()+2);
	}
}

/*
 * A helper function to draw a circular gradient
 * An alternative implementation to drawCurvedGradient() using indexing to help avoid triggering Watchdog
 *
 * @param dc (Toybox:Graphics:Dc)	the device context
 * @param x (Toybox:Lang:Number)	the x coord for the center of the circular gradient center
 * @param y (Toybox:Lang:Number)	the y coord for the center of the cicular gradient center
 * @param r (Toybox:Lang:Number)	the radius for the circular gradient
 * @param gradient (Colors:Gradient)	the gradient to draw
 */
function drawCurvedGradientRA(dc, x, y, r, gradient){
	for(var i=0; i<gradient.size(); i++) {
		dc.setColor(gradient.get(i).toNumber(), Graphics.COLOR_BLACK);
		dc.fillCircle(x, y, r-i+2);
	}	
}

/*
 * A helper function to draw a rectangular gradient
 *
 * @param dc (Toybox:Graphics:Dc)	the device context
 * @param x (Toybox:Lang:Number)	the x coord for the upper left corner of the gradient
 * @param y (Toybox:Lang:Number)	the y coord for the upper left corner of the gradient 
 * @param width (Toybox:Lang:Number)	width of the gradient
 * @param height (Toybox:Lang:Number)	height of the gradient
 * @param gradient (Colors:Gradient)	the gradient to draw
 * @param vertical (Toybox:Lang:Boolean)	the orientation of the gradient. the value of 
 *											true will draw a vertical gradient
 */
function drawRectGradient(dc, x, y, width, height, gradient, vertical){
	if(vertical){
		var bandwidth = height.toDouble()/gradient.size().toDouble();
		for(var i=0; i<gradient.size(); i++){
			dc.setColor(gradient.get(i).toNumber(), Graphics.COLOR_BLACK);
			dc.fillRectangle(x, y + bandwidth*i, width, (bandwidth<1 ? 1 : bandwidth));
		}
	}
	else{
		var bandwidth = width.toDouble()/gradient.size().toDouble();
		for(var i=0; i<gradient.size(); i++){
			dc.setColor(gradient.get(i).toNumber(), Graphics.COLOR_BLACK);
			dc.fillRectangle(x + bandwidth*i, y, (bandwidth<1 ? 1 : bandwidth), height);
		}
	}

}

}