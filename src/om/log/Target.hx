package om.log;

interface Target {
    //var level : Null<Level>;
    var silent : Bool;
    var format : Format;
    //function init(onReady:String->Void) : Void;
    function init() : Void;
    function dispose() : Void;
    function output(messge: String) : Void;
}
