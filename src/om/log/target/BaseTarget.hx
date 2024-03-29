package om.log.target;

abstract class BaseTarget implements om.log.Target {

    //public var level : Null<Level>;
    public var silent = false;
    public var format : Format;

    public function new(?format: Format) {
        this.format = format;
    }

    //public function init(onReady:String->Void) {}
    public function init() {}
    public function dispose() {}

    abstract public function output(str: String) : Void;
}
