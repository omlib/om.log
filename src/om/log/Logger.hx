package om.log;

import om.log.ConsoleTransport;
import om.log.Level;
import om.log.Transport;

using om.log.LevelTools;

private typedef Meta = Dynamic;
private typedef Callback = String->Level->String->Meta->Void;

/**
**/
@:access(om.log.Transport)
class Logger {

    public final on = new Emitter();

    public var level = Level.warn;
    public var format : String;

    var transports = new Array<Transport>();

    public function new(level=Level.warn, ?transports: Array<Transport>, ?format: String) {
        this.level = level;
        if(transports == null) transports = [new ConsoleTransport()];
        for(t in transports) add(t);
        this.format = format ?? "::date:: ::level:: ::message::\n";
    }

    public inline function iterator() : Iterator<Transport>
        return this.iterator();

    public function add(transport: Transport) {
        this.transports.push(transport);
        transport.init();
    }

    public function remove(transport: Transport) : Bool {
        if(!this.transports.remove(transport))
            return false;
        transport.dispose();
        return true;
    }

    //public function query() {

    //public function stream(start=0, handler: String->Void) {

    //public function clone() {}

    public inline function log(level=Level.info, message: String, ?meta: Dynamic, ?callback: Callback) {
        if(!this.enabledFor(level))
            return;
        final str = new haxe.Template(format).execute({
            level: level,
            message: message,
            date: Date.now().toString(),
            meta: meta
        });
        for(t in transports) {
            if(!t.enabledFor(level))
                continue;
            t.output(str);
        }
    }

    public inline function debug(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.debug, message, meta, callback);

    public inline function info(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.info, message, meta, callback);

    public inline function warn(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.warn, message, meta, callback);

    public inline function error(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.error, message, meta, callback);
}

