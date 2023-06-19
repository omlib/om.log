package om.log.target;

import om.log.Logger;
#if sys
#else
import js.node.fs.WriteStream;
#end

using haxe.io.Path;

/**
    Log to file.
**/
class FileTarget extends BaseTarget {

    public final file : String;
    public final maxFileSize : Null<Float>; // 1e+9
    //public final maxHistory : Null<Float>;

    public var fileSize(default,null) : Int;
    public var bytesWritten(default,null) : Int;

    #if sys
    public var out : sys.io.FileOutput;
    #elseif nodejs
    public var out : WriteStream;
    #end

    public function new(?file="om.log", ?level: Int, ?format: Format, ?maxFileSize:Int) {
        //super(level, format);
        super(format);
        this.file =
            #if sys
            FileSystem.absolutePath(file);
            #elseif nodejs
            js.node.Path.resolve(file);
            #end
        this.maxFileSize = maxFileSize;
    }

    //override function init(onReady:String->Void) {
    override function init() {
        bytesWritten = 0;
        #if sys
        fileSize = FileSystem.exists(file) ? FileSystem.stat(file).size : 0;
        out = FileSystem.exists(file) ? File.append(file) : File.write(file);
        #elseif nodejs
        //TODO
        out = js.node.Fs.createWriteStream(file);
        #end
        //onReady(null);
    }

    function output(message:String) {
        #if sys
        try {
            out.writeString('$message\n');
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
        #elseif nodejs
        //TODO:
        out.write('$message\n');
        #end
    }

    override function dispose() {
        #if sys
        try out.close() catch(e) {
            trace(e);
        }
        #elseif nodejs
        out.end();
        #end
        bytesWritten = 0;
    }

    //public function changeFilePath
}

