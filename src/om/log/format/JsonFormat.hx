package om.log.format;

class JsonFormat implements om.log.Format {

    public var pretty : Bool;
    public var space : String;

    public function new(pretty=false, space= "  ") {
        this.pretty = pretty;
        this.space = space;
    }

    public function format(msg:Message) : String {
        final obj = {};
        for(f in Reflect.fields(msg)) {
            final v = Reflect.field(msg, f);
            if(v != null) Reflect.setField(obj, f, v);
        }
        return pretty ? haxe.format.JsonPrinter.print(obj, space) : haxe.Json.stringify(obj);
    }
}
