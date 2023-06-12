package om.log;

abstract class Transport {

    public var level : Null<Level>;

    public function new(?level: Level) {
        this.level = level;
    }

    function init() {}
    function dispose() {}

    abstract function output(message:String) : Void;
}
