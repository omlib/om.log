package om.log;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

class Logger {

    public var level : Null<Int>;
    public var format : Format;
    public var targets : Array<Target>;
    public var silent = false;

    public function new<T:Int>(level:T, ?targets: Array<Target>, ?format: Format) {
        this.level = level;
        this.format = format ?? cast new om.log.format.DefaultFormat();
        trace(this.format);
        this.targets = [];
        if(targets != null) for(t in targets) add(t);
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
        target.dispose();
        return true;
    }

    public function log(level:Int, message:String, ?meta: Dynamic) {
        if(silent || level > this.level)
            return;
        final _targets = targets.filter(t -> return !t.silent && enabledFor(level));
        if(_targets.length > 0) {
            final msg : om.log.Message = {
                level: level, // level.toString(),
                time: om.Time.now(),
                content: message,
                meta: meta,
            };
            var str = this.format.format(msg);
            /*
            var str : String = null;
            if(this.format != null) str = this.format.format(msg);
            */
            for(t in _targets) {
                //if(t.format != null) t.output(t.format.format(msg)); 
                //else if(str != null) t.output(str);
                t.output(str);
            }
        }
        //return this;
    }
    
    macro public function examine(ethis: Expr, rest: Array<Expr>) {
        var printer = new haxe.macro.Printer();
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

    public function enabledFor(level: Null<Int>) : Bool {
        return ((this.level == null) || (level == null)) ? true
            : cast(this.level, Int) >= cast(level, Int);
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

    #if macro

	static function joinArgExprs(rest: Array<Expr>) : ExprOf<String> {
		var msg: Expr = macro '';
		var sepExpr: Expr = {expr: EConst(CString(" ")), pos: haxe.macro.PositionTools.make({min: 0, max: 0, file: ""})};
		for(i in 0...rest.length) {
			var e = rest[i];
			msg = macro $msg + $e;
			if (i != rest.length - 1) msg = macro $msg + $sepExpr;
		}
		return msg;
	}

	#end
}
