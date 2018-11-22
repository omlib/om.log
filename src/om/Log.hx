package om;

import haxe.EnumTools;
import haxe.PosInfos;
#if js
import js.Browser.console;
#end

@:enum abstract LogLevel(Int) from Int to Int {
	//var Off = 0;
	var Debug = 1;
	var Info = 2;
	var Warn = 3;
	var Error = 4;
}

typedef LogHandler = LogLevel->Dynamic->PosInfos->Void;

class Log {

	public var name : String;
	public var handlers : Array<LogHandler>;
	public var level : LogLevel;

	public function new( ?name : String, ?level : LogLevel, ?handlers : Array<LogHandler> ) {
		this.name = name;
		this.level = level;
		this.handlers = (handlers == null) ? [getDefaultHandler()] : handlers;
	}

	public function debug( v : Dynamic, ?pos : PosInfos ) {
		log( Debug, v, pos );
	}

	public function info( v : Dynamic, ?pos : PosInfos ) {
		log( Info, v, pos );
	}

	public function warn( v : Dynamic, ?pos : PosInfos ) {
		log( Warn, v, pos );
	}

	public function error( v : Dynamic, ?pos : PosInfos ) {
		log( Error, v, pos );
	}

	public function log( ?level : LogLevel, v : Dynamic, ?pos : PosInfos ) {
		if( level != null && this.level != null ) {
			var a : Int = this.level;
			var b : Int = level;
			if( b < a )
				return;
		}
		for( h in handlers ) h( level, v, pos  );
	}

	function formatMessage( v : Dynamic, ?pos : PosInfos ) {
		var str = '';
		if( name != null ) str += '[$name] ';
		str += pos.fileName + ':' + pos.lineNumber;
		str += ': '+v;
		return str;
	}

	public static function getDefaultHandler() : LogHandler {

		return function( level : LogLevel, v : Dynamic, pos : PosInfos ) {

			#if sys
			Sys.println(v);

			#elseif js
			switch level {
			case Debug: console.debug(v);
			case Info: console.info(v);
			case Warn: console.warn(v);
			case Error: console.error(v);
			default: console.log(v);
			}

			#end
		};
	}

}
