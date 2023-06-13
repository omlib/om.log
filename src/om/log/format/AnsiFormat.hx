package om.log.format;

private typedef Theme = {
    var content : Array<Int>;
    var date : Array<Int>;
    var meta : Array<Int>;
    var level : {
        error: Array<Int>,
        warn: Array<Int>,
        info: Array<Int>,
        debug: Array<Int>,
    };
}

class AnsiFormat implements om.log.Format {

    public var theme : Theme;

    public function new(?theme:Theme) {
        this.theme = theme ?? {
            date: [37],
            content: [],
            meta: [37],
            level: {
                error: [41],
                warn: [45],
                info: [44],
                debug: [47],
            }
        };
    }

    public function format(msg:Message) : String {
        var out = ansify(Date.fromTime(msg.time).toString(), theme.date);
        var levelAnsi : Array<Int> = if(msg.level != null) Reflect.field(theme.level, msg.level) else null;
        out += " "+ansify(std.StringTools.rpad(" "+msg.level.toUpperCase()+" ", " ", 7), levelAnsi);
        out += " "+ansify(msg.content, theme.content);
        if(msg.meta != null)
            out += " "+ansify(Std.string(msg.meta), theme.meta);
        return out;
    }

    static function ansify(str: String, codes: Array<Int>) {
        if(codes == null || codes.length == 0)
            return str;
        return '\x1B['+codes.join(";")+'m'+str+'\x1B[0m';
    }
}
