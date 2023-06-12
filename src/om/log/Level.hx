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
    /*
    @:to public function toString() : String {
        return switch this {
            case debug: "DEBUG";
            case info: "INF0";
            case warn: "WARN";
            case error: "ERROR";
            case _: null;
        }
    }
    */
}

/*
// npm logging levels:
{ error: 0, warn: 1, info: 2, verbose: 3, debug: 4, silly: 5 }

//The Syslog Protocol ()https://www.rfc-editor.org/rfc/rfc5424:
{ emerg: 0, alert: 1, crit: 2, error: 3, warning: 4, notice: 5, info: 6, debug: 7 }
*/

