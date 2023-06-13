package om.log;

enum abstract Level(Int) from Int to Int {
    var error;
    var warn;
    var info;
    var debug;
    var verbose;
    var all;
    // public inline function equals(l:Level): Bool {
    //     return this >= cast(l, Int);
    // }
    
    
    @:to public function toString() : String {
        return switch this {
            case debug: "debug";
            case info: "info";
            case warn: "warn";
            case error: "error";
            case _: null;
        }
    }

    @:from public static function fromString(s:String) : Null<Level> {
        return switch s {
            case "error": error;
            case "warn": warn;
            case "info": info;
            case "debug": debug;
            case _: null;
        }
    }
}
