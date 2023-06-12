package om.log;

#if sys

class FileTransport extends BaseTransport {

    public final file : String;
    public final maxFileSize : Null<Float>; // 1e+9
    //public final maxLines : Null<Float>;
    public var bytesWritten(default,null) : Int;

    var out : sys.io.FileOutput;

    public function new(file:String, ?maxFileSize:Int) {
        super();
        this.file = "om.log";
        this.maxFileSize = maxFileSize;
    }

    override function init() {
        bytesWritten = 0;
        if(FileSystem.exists(file)) {
            out = File.append(file);
        } else {
            out = File.write(file);
        }
    }

    override function dispose() {
        try {
            out.close();
        } catch(e) {
            trace(e);
        }
        bytesWritten = 0;
    }

    //public function changeFilePath

    function output(message:String) {
        try {
            out.writeString(message);
        } catch(e) {
            trace(e);
            return;
        }
        bytesWritten = message.length;
    }
}

#end
