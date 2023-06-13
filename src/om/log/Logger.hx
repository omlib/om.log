package om.log;

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

    public function new(level=Level.debug, ?transports: Array<Transport>, ?format: String) {
        this.level = level;
        if(transports != null)
            for(t in transports) add(t);
        this.format = new om.log.format.SimpleFormat();
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

    public inline function log(level: Level, message: String, ?meta: Dynamic, ?callback: Callback) {
        if(silent || !this.enabledFor(level))
            return;
        final _transports = transports.filter(t -> return !t.silent && t.enabledFor(level));
        if(_transports.length > 0) {
            final msg : Message = {
                level: level.toString(),
                time: Date.now().getTime(),
                content: message,
                meta: meta,
            };
            final str = format.format(msg);
            for(t in _transports) {
                if(t.silent || !t.enabledFor(level))
                    continue;
                t.output((t.format == null) ? str : t.format.format(msg));
            }
        }
    }

    //public function trace() {

    public inline function debug(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.debug, message, meta, callback);

    public inline function info(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.info, message, meta, callback);

    public inline function warn(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.warn, message, meta, callback);

    public inline function error(message: String, ?meta: Dynamic, ?callback: Callback)
        log(Level.error, message, meta, callback);

    public function redirectTraces(defaultLevel=Level.debug) {
        haxe.Log.trace = (v:Dynamic, ?infos: haxe.PosInfos) -> {
            var level : Null<Level> = null;
            if(infos != null) {
                if(infos.customParams != null) {
                    level = Level.fromString(infos.customParams[0]);
                }
            }
            if(level == null) level = defaultLevel;
            log(level, v, infos);
        }
    }
}

@:forward
abstract Logger(CLogger) {
    public inline function new(level=Level.warn, ?transports: Array<Transport>, ?format: String)
        this = new CLogger(level, transports, format);

}
