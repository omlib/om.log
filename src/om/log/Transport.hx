package om.log;

interface Transport {
    var level : Null<Level>;
    private function init() : Void;
    private function dispose() : Void;
    function output(messge: String) : Void;
}
