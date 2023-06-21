package om.log;

import om.log.target.ConsoleTarget;

typedef Logger = TypedLogger<om.log.Level>;

class TypedLogger<T:Int> {

    public var level : Null<T>;
    public var defaultLevel = 1;
    public var format : Format;
    public var targets : Array<Target> = []; 
    public var silent = false;

    var counts : Map<String,Int>;

    public function new(level: T, ?targets: Array<Target>, ?format: Format) {
        this.level = level;
        this.format = format ?? cast new om.log.format.DefaultFormat();
        if(targets == null || targets.length == 0) add(new ConsoleTarget());
        else for(t in targets) add(t);
    }

    public inline function iterator() : Iterator<Target>
        return this.iterator();

    public function add(target: Target) {
        // if(transports.contains(transport))
        //     return false;
        // target.init(error->{
        //     if(error!= null) trace(error) else {
        //         this.targets.push(target);
        //     }
        //
        // });
        try target.init() catch(e) {
            trace(e);
            return false;
        }
        this.targets.push(target);
        return true;
    }

    public function remove(target: Target) : Bool {
        if(!this.targets.remove(target))
            return false;
        try target.dispose() catch(e) {}
        return true;
    }

    macro public function log(ethis: Expr, rest: Array<Expr>) {
        return switch rest.length {
        case 0:
            Context.error('invalid arguments', Context.currentPos());
            macro null;
        case 1:
            var expr = rest[0];
            macro $ethis.doLog($ethis.defaultLevel, $expr);
        case _:
            macro $ethis.doLog(${rest.shift()}, ${joinArgExprs(rest)});
        }
    }

    public function doLog(level:Int, message: Dynamic, ?meta: Dynamic) {
        if(silent || level > this.level)
            return;
        final _targets = targets.filter(t -> return !t.silent && enabledFor(level));
        if(_targets.length > 0) {
            final msg : om.log.Message = {
                level: level, // level.toString(),
                time: om.Time.now(),
                content: Std.string(message),
                meta: meta,
            };
            var str : String = null;
            if(this.format != null) str = this.format.format(msg);
            for(t in _targets) {
                if(t.format != null) t.output(t.format.format(msg)); 
                else if(str != null) t.output(str);
            }
        }
    }

    public function enabledFor(level: Null<Int>) : Bool {
        return ((this.level == null) || (level == null)) ? true
            : cast(this.level, Int) >= cast(level, Int);
    }

    macro public function examine(ethis: Expr, rest: Array<Expr>) {
        final printer = new haxe.macro.Printer();
        var namedArgs = rest.map(e->{
            return switch e.expr {
            case EConst(CInt(_) | CFloat(_)): macro '$e';
            case EConst(CString(_)): macro '$e';
            case _:
                var estr = printer.printExpr(e);
                return macro $v{estr};
            }
        });
        return macro $ethis.log(-1, ${joinArgExprs(namedArgs)});
    }

    public function count(id: String, ?pos: haxe.PosInfos) : Int {
        var key = '${pos.fileName}:${pos.lineNumber}';
        var count = if(counts == null) {
            counts = [];
            1;
        } else counts.get(key) + 1;
        trace("COUNT:L:"+count);
        counts.set(key, count);
        log(0, '$id: $count');
        return count;
    }

    /*
    public function redirectTraces(defaultLevel:Int) {
        haxe.Log.trace = (v:Dynamic, ?infos: haxe.PosInfos) -> {
            var level : Null<Int> = null;
            if(infos != null) {
                if(infos.customParams != null) {
                    //level = Level.fromString(infos.customParams[0]);
                }
            }
            if(level == null) level = defaultLevel;
            log(level, v, infos);
        }
    }
    */

    public function dispose() {
        for(t in targets) t.dispose();
        targets = [];
    }

    macro public static function create(?config:Expr, ?defaultLevel: Expr) {
        var typeName = config.toString();
        if(typeName == "null") {
            trace('no type specified, using defualt');
            typeName = "om.log.Level";
        }
        var type = Context.getType(typeName);
        switch type {
		case TAbstract(_.get() => ab,_) if(ab.meta.has(":enum")):
            var fields = ab.impl.get().statics.get();
            //for(f in fields) trace(f);
            if(defaultLevel.toString() == "null") {
                defaultLevel = macro $v{fields.length - 1};
            }
        case _:
			throw type.toString() + " should be enum abstract";
        }
        return macro new om.log.Logger($defaultLevel);
    }

    #if macro

    // static function build() {
    //     /*
    //     trace("build");
    //     var lt = Context.getLocalType();
    //     //trace(lt);
    //     trace(lt.extractMetaParam("level"));
    //     */
    //     var fields = Context.getBuildFields();
    //     return fields;
    // }

    static function joinArgExprs(rest: Array<Expr>) : ExprOf<String> {
        final sep = " ";
		final sep: Expr = {
            expr: EConst(CString(sep)),
            pos: PositionTools.make({min: 0, max: 0, file: ""})
        };
        var msg: Expr = macro '';
        for(i in 0...rest.length) {
			var e = rest[i];
			msg = macro $msg + $e;
			if(i != rest.length - 1) msg = macro $msg + $sep;
		}
		return msg;
    }

	#end
}
