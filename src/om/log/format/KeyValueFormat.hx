package om.log.format;

class KeyValueFormat implements om.log.Format {

    public var separator : String;
    public var equalSign : String;
    public var outputNullValues : Bool;
    public var quoteStrings : Bool;

    public function new(separator= " ", equalSign="=", outputNullValues=false, quoteStrings=true) {
        this.separator = separator;
        this.equalSign = equalSign;
        this.outputNullValues = outputNullValues;
        this.quoteStrings = quoteStrings;
    }

    public function format(msg: om.log.Message) : String {
        final arr = new Array<String>();
        for(k in Reflect.fields(msg)) {
            final v : Null<Any> = Reflect.field(msg, k);
            if(v != null || outputNullValues) {
                final vstr = switch Type.typeof(v) {
                    case TClass(String): quoteStrings ? '"'+v+'"' : v;
                    case _: Std.string(v);
                    }
                arr.push('$k$equalSign'+vstr);
            }
        }
        return arr.join(separator);
    }
}
