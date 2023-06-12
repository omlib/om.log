package om.log;

private enum StdFile {
    out;
    err;
    //level(l:Level)
}

class ConsoleTransport extends BaseTransport {
 
    public var file : StdFile;

    // var levelMapping = [
    //     debug => out,
    //     info => out,
    //     warn => out,
    //     error => err
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
