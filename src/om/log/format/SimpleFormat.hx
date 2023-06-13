package om.log.format;

class SimpleFormat implements om.log.Format {
    public function new() {}
    public function format(msg:Message) : String {
        var date = Date.fromTime(msg.time);
        var out = '${date.toString()} ${msg.level} ${msg.content}';
        if(msg.meta != null) out += ' '+Std.string(msg.meta);
        return out;
    }
}
