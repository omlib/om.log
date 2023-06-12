package om.log;

abstract class BaseTransport implements Transport {

    public var level : Null<Level>;

    public function new(?level: Level) {
        this.level = level;
    }

    function init() {}
    function dispose() {}

    abstract public function output(message:String) : Void;
}
