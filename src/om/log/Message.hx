package om.log;

@:structInit class Message {

    public var level : Null<Int>;
    public var content: String;
    public var time: Float;
    public var meta : Dynamic;

    public function new(level: Null<Int>, content: String, time: Float, ?meta: Dynamic) {
        this.level = level;
        this.content = content;
        this.time = time;
        this.meta = meta;
    }
}
