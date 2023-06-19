package om.log.target;

import om.log.Logger;

private enum StdFile {
    out;
    err;
    //level(l:Level)
}

/**
    Log to stdout/stderr.
**/
class ConsoleTarget extends BaseTarget {
 
    public var file : StdFile;

    // var levelMapping = [
    //     debug => out,
    //     info => out,
    //     warn => out,
    //     error => err
    // ];

    public function new(?file=StdFile.out, ?format: Format) {
        super(format);
        this.file = file;
    }

    public function output(message:String) {
        final str = '$message\n';
        switch file {
        case err: Sys.stderr().writeString(str);
        case _: Sys.stdout().writeString(str);
        }
    }
}
