package om.log;

interface Transport {
    var level : Null<Level>;
    var silent : Bool;
    private function init() : Void;
    private function dispose() : Void;
    function output(messge: String) : Void;
}
