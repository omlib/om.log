package om.log;

#if sys

using haxe.io.Path;

class FileTransport extends BaseTransport {

    public final file : String;
    public final maxFileSize : Null<Float>; // 1e+9
    //public final maxHistory : Null<Float>;

    public var fileSize(default,null) : Int;
    public var bytesWritten(default,null) : Int;

    var out : sys.io.FileOutput;

    public function new(file="om.log", ?maxFileSize:Int) {
        super();
        this.file = FileSystem.absolutePath(file);
        this.maxFileSize = maxFileSize;
        fileSize = FileSystem.stat(file).size;
    }

    override function init() {
        bytesWritten = 0;
        if(FileSystem.exists(file)) {
            out = File.append(file);
        } else {
            out = File.write(file);
        }
    }

    function output(message:String) {
        try {
            out.writeString(message);
        } catch(e) {
            trace(e);
            return;
        }
        bytesWritten += message.length;
        if(maxFileSize != null && (fileSize + bytesWritten) >= maxFileSize) {
            //trace('max file size not implemented', (fileSize+bytesWritten) );
            final name = file.withoutDirectory();
            final reg = new EReg("^"+name+".([0-9]+)$", "");
            var lastLogFileIndex : Null<Int> = null;
            for(f in FileSystem.readDirectory(file.directory())) {
                if(reg.match(f)) {
                    final i = Std.parseInt(reg.matched(1));
                    if(lastLogFileIndex == null)
                        lastLogFileIndex = i;
                    else if(i > lastLogFileIndex)
                        lastLogFileIndex = i;
                }
            }
            out.close();
            final index = (lastLogFileIndex == null) ? 1 : lastLogFileIndex+1;
            FileSystem.rename(this.file, '${this.file}.$index');
            out = File.write(this.file);
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

}

#end
