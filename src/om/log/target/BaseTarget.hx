package om.log.target;

import om.log.Logger;

abstract class BaseTarget implements om.log.Target {
    //public var level : Null<Level>;
    public var silent = false;
    public var format : Format;
    public function new(format: Format) {
        this.format = format;
    }
    //public function init(onReady:String->Void) {}
    public function init() {}
    public function dispose() {}
    abstract public function output(message:String) : Void;
}
