package om.log;

class FileTransport extends Transport {

    public final file : String;
    public final maxSize : Null<Float>; // 1e+9

    var out : sys.io.FileOutput;

    //public function new(?file:String, maxSize=1024*1024*1024) {
    public function new(file:String, ?maxSize:Int) {
        super();
        this.file = "om.log";
        this.maxSize = maxSize;
    }

    override function init() {
        if(FileSystem.exists(file)) {
            out = File.append(file);
        } else {
            out = File.write(file);
        }
    }

    override function dispose() {
        out.close();
    }

    function output(message:String) {
        out.writeString(message);
    }

}
