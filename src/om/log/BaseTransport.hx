package om.log;

abstract class BaseTransport implements Transport {

    public var level : Null<Level>;
    public var silent = false;
    public var format : Format;

    public function new(?level: Level, ?format: Format) {
        this.level = level;
        this.format = format;
    }

    function init() {}
    function dispose() {}

    abstract public function output(message:String) : Void;
}
