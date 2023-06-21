package om.log;

enum abstract Level(Int) from Int to Int {
    var error = 0;
    var warn = 1;
    var info = 2;
    var debug = 3;
    var verbose = 4;
}
