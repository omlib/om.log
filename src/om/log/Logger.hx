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
class CLogger {

    public final on = new Emitter();

    public var level = Level.warn;
    public var format : Format;
    public var silent = false;

    var transports = new Array<Transport>();

    public function new(level=Level.warn, ?transports: Array<Transport>, ?format: String) {
        this.level = level;
        if(transports == null) transports = [new ConsoleTransport()];
        for(t in transports) add(t);
        this.format = new om.log.format.AnsiFormat();
    }

    public inline function iterator() : Iterator<Transport>
        return this.iterator();

    public function add(transport: Transport) {
        if(transports.contains(transport))
            return false;
        try {
            transport.init();
        } catch(e) {
            trace(e);
            return false;
        }
        this.transports.push(transport);
        return true;
    }

    public function remove(transport: Transport) : Bool {
        if(!this.transports.remove(transport))
            return false;
        transport.dispose();
        return true;
    }

    public function dispose() {
        for(t in transports) t.dispose();
        transports = [];
    }

    //public function query() {

    //public function stream(start=0, handler: String->Void) {

    //public function clone() {}

    public inline function log(level=Level.info, message: String, ?meta: Dynamic, ?callback: Callback) {
        if(silent || !this.enabledFor(level))
            return;
        final msg : Message = {
            level: level.toString(),
            time: Date.now().getTime(),
            content: message,
            meta: meta,
        };
        final str = format.format(msg);
        for(t in transports) {
            if(t.silent || !t.enabledFor(level))
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

@:forward
abstract Logger(CLogger) {
    public inline function new(level=Level.warn, ?transports: Array<Transport>, ?format: String)
        this = new CLogger(level, transports, format);

}
