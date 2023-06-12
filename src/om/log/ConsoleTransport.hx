package om.log;

private enum StdFile {
    out;
    err;
    //level(l:Level)
}

class ConsoleTransport extends Transport {
 
    public var file : StdFile;

    // var levelMapping = [
    //     debug => Out,
    //     info => Out,
    //     warn => Out,
    //     error => Err
    // ];

    public function new(?file=StdFile.out, ?level: Level) {
        super(level);
        this.file = file;
    }

    public function output(message:String) {
        switch file {
        case err: Sys.stderr().writeString(message);
        case _: Sys.stdout().writeString(message);
        }
    }
}
