package om.log.format;

import om.log.Logger;

using StringTools;

class DefaultFormat implements Format {
    public function new() {}
    public function format(msg:Message) : String {
        var date = Date.fromTime(msg.time);
        var out = '${date.toString()} ${msg.level} ${msg.content}';
        if(msg.meta != null) out += ' '+Std.string(msg.meta);
        return out;
    }
}
