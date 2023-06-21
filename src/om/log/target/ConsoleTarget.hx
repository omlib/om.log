package om.log.target;

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

    public function new(?file=StdFile.out, ?format: Format) {
        super(format);
        this.file = file;
    }

    public function output(str: String) {
        final s = '$str\n';
        switch file {
        case err: Sys.stderr().writeString(s);
        case _: Sys.stdout().writeString(s);
        }
    }
}
