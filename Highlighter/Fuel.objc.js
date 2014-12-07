/*
---
description: Objective-C language fuel.

license: MIT-style

authors:
- Jose Prado

requires:
  core/1.2.4: '*'

provides: [Fuel.js]

...
*/
Fuel.objc = new Class({
	
	Extends: Fuel,
	language: 'objc',
	
	initialize: function(code, options) {
	
		// Keywords Rule Set
		this.keywords = new Hash({
			commonKeywords: {
				csv: "char, bool, BOOL, double, float, int, long, short, id, void, IBAction, IBOutlet, SEL, YES, NO, interface, property, readwrite, readonly, nonatomic,retain, assign, readonly, strong, getter, setter, nil, NULL,super, self, copy, break, case, catch, class, const, copy, __finally, __exception, __try, const_cast, continue, private, public, protected, __declspec, default, delete, deprecated, dllexport, dll,import, do, dynamic_cast, else, enum, explicit, extern, if, for, friend, goto, inline, mutable, naked, namespace, new, noinline, noreturn, nothrow, register, reinterpret_cast, return, selectany, sizeof, static, static_cast, struct, switch, template ,this, thread, throw, true, false, try, typedef, typeid, typename, union, using, uuid, virtual, volatile, whcar_t while, #",
				alias: 'kw1'
			},
			 langKeywords: {
			 	csv: "#",
			 	alias: 'kw2'
			},
			// windowKeywords: {
			// 	csv: "alert, back, blur, close, confirm, focus, forward, home, navigate, onblur, onerror, onfocus, onload, onmove, onresize, onunload, open, print, prompt, scroll, status, stop",
			// 	alias: 'kw3'
			// }
		});
		
		// RegEx Rule Set
		this.patterns = new Hash({
			'slashComments': {pattern: this.common.slashComments, alias: 'co1'},
			'multiComments': {pattern: this.common.multiComments, alias: 'co2'},
			'strings':       {pattern: this.common.strings,       alias: 'st0'},
			'methodCalls':   {pattern: this.common.properties,    alias: 'me0'},
			'brackets':      {pattern: this.common.brackets,      alias: 'br0'},
			'numbers':       {pattern: /\b((([0-9]+)?\.)?[0-9_]+([e][-+]?[0-9]+)?|0x[A-F0-9]+)\b/gi, alias: 'nu0'},
			'regex':         {pattern: this.delimToRegExp("/", "\\", "/", "g", "[gimy]*"), alias: 're0'},
			'symbols':       {pattern: /\+|-|\*|\/|%|!|@|&|\||\^|\<|\>|=|,|\.|;|\?|:/g,     alias: 'sy0'},
			//'objcClass':     {patterns: /[A-Z]([\w]+)\s*/g,     alias: 'kw3'},
			'systemVars':    {pattern: /(NS[A-Z]([\w]+)\s*|UI[A-Z]([\w]+)\s*|CG[A-Z]([\w]+)\s*|MK[A-Z]([\w]+)\s*)/g,     alias: 'co3'}
		});
		
		// Delimiters
		//this.delimiters = new Hash({
			//start: this.strictRegExp('<script type="text/javascript">', '<script language="javascript">'),
			//end:   this.strictRegExp('</script>')
		//});
		
		this.parent(code, options);
	}
});
