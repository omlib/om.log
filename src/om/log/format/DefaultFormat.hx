package om.log.format;

class DefaultFormat implements om.log.Format {

    public var separator : String;

    public function new(separator=" ") {
      this.separator = separator;
    }

    public function format(msg: om.log.Message) : String {
        var time = Std.int(msg.time * 1000) / 1000;
        var arr = [Std.string(time), Std.string(msg.level), msg.content];
        if(msg.meta != null) arr.push(Std.string(msg.meta));
        return arr.join(separator);
    }
}
