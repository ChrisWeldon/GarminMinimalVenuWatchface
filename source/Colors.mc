using Toybox.Lang as Lang;
using Toybox.Math as Math; 
using Toybox.Graphics as Graphics;
using Toybox.System as Sys;
using Toybox.Test as Test;

module Colors{

// HELP: How do I extend the number class properly so it is recognized as number
// HELP: Contructor overloading?
// HELP: Operator overloading?
// HELP: Venu Watchface constraints
// HELP: default paramters
// HELP: Assertions

// TODO: Implement Dithering
// TODO: Extend Number class and implement comparable methods
// TODO: write assertions for parameters
// TODO: write assertions for watch capabilities
// TODO: Convert to monkey barrel


class rgb extends Lang.Number{

	protected var r, g, b;
	protected var hex;
	
	function initialize(hex) {
		// HEX code initialize
		
		Number.initialize();
		
    	self.r = (hex & 0xFF0000)>>16;
    	self.g = (hex & 0x00FF00)>>8;
    	self.b = (hex & 0x0000FF);
    	
    	self.hex = hex;
	}	

	function toString() {
		return ("rgb(" + self.r + ", " + self.g + ", " + self.b + ")");
	}
	
	function toNumber() {
		return self.hex.toNumber();
	}
	
	function setR(val) {
		self.r = val;
		// Create hexadecimal Red val and concat with old Green Blue vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) << 16 | (self.hex.toLong() & 0x00FFFF);
		return self;
	}
	
	function setG(val) {
		self.g = val;
		// Create hexadecimal Green val and concat with old Red Blue vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) << 8 | (self.hex.toLong() & 0xFF00FF);
		return self;
	}
	
	function setB(val) {
		self.b = val;
		// Create hexadecimal Blue val and concat with old Red Green vals masked from Hex
		self.hex = (val.toLong() & 0x0000FF) | (self.hex.toLong() & 0xFFFF00);
		return self;
	}
	
	function setRGB(r, g, b){
		self.r = r;
		self.g = g;
		self.b = b;

		self.hex = r.toLong() & 0x0000FF << 16 | g.toLong() & 0x0000FF << 8 | b.toLong() & 0x0000FF;
		return self;
	}
	
	function getR(){
		return self.r;
	}
	
	function getG(){
		return self.g;
	}
	
	function getB(){
		return self.b;
	}
	
	function getRGB(){
		return {
			'r' => self.r,
			'g' => self.g,
			'b' => self.b		
		};
	}
	
	function add(c){
		return new rgb(self.toNumber() + c.toNumber());
	}
	
	function subtract(c){
		return new rgb(self.toNumber() - c.toNumber());
	}
	
	function copy(){
		return new rgb(hex);
	}
}

// Should be obsolete after constructor overloading...Whenever I figure out how to do that
function valsToRGB(r, g, b){
	return new rgb(0x000000).setRGB(Math.round(r), Math.round(g), Math.round(b));
}

function randRGB(){
	return new rgb(0xFFFFFF & Math.rand());
}

// TODO: fleshout constraints and asserts
// TODO: dithering
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
	// TODO: band_width
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
	
	function concat(gradient){
		self.grad.addAll(gradient.getArray());
		self.scale = self.scale + gradient.size();
		return self;
	}
    	
	
	function hasNext() {
		return step_count < scale-1;
	}
	
	function hasPrev() {
		return step_count > 0;
	}
	
	function next() {
		step_count++; // Incrementing step prior to access to prepare for potential prev() call
		return self.grad[step_count];
	}
	
	function prev() {
		step_count--; // Decrementing step prior to access to prepare for potential next() call
		return self.grad[step_count];
	}
	
	function getStep(){
		return step_count;
	}
	
	function size(){
		return self.scale;
	}
	
	function get(i){
		// Allows for gradient shifting and looping
		if(i>=scale){
			i = i-scale;
		}
		if(i<0){
			i = scale+i;
		}
		return grad[i];
	}
	
	function getArray(){
		return self.grad;
	}
	
}

class Palette {
	var keys = [];
	var values = [];
	
	function initialize(array){
		for(var i=0; i<array.size(); i++){
			keys.add(array[i].keys()[0]);
			values.add(array[i].values()[0]);
		}
	}
	
	function toString(){
		var ret = "PALETTE: ";
		for(var i=0; i<self.keys.size(); i++ ){
			ret = ret + self.keys[i].toString() + "=>" + self.values[i].toString()  + (i<self.keys.size()-1 ? ", " : "") ;
		}
		
		return ret;
	}
	
	function getValues(){
		return self.values;
	}
	
	function getKeys(){
		return self.keys;
	}
	
	// TODO: fix to constant time implementation
	function get(name){
		for(var i=0; i<keys.size(); i++){
			if(name.equals(keys[i])){
				return values[i];
			}
		}
		return null;
	}
	
	function put(key, val){
		self.keys.add(key);
		self.values.add(val);
	}
	
}


function createPaletteFromHex(array){
	var p = new Palette([]);
	
	for(var i=0; i<array.size(); i++ ){
		p.put(array[i].keys()[0], new rgb(array[i].values()[0]));
	}
	
	return p;
	
}

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


function drawCurvedGradient(dc, x, y, r, gradient){
	while(gradient.hasNext()) {
		dc.setColor(gradient.next().toNumber(), Graphics.COLOR_BLACK);
		dc.fillCircle(x, y, r-gradient.getStep()+2);
	}
}

function drawCurvedGradientRA(dc, x, y, r, gradient){
	for(var i=0; i<gradient.size(); i++) {
		dc.setColor(gradient.get(i).toNumber(), Graphics.COLOR_BLACK);
		dc.fillCircle(x, y, r-i+2);
	}	
}

}