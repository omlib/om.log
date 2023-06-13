package om.log.format;

class TemplateFormat implements om.log.Format {

    public var template(default,set) : String;
    inline function set_template(str) {
        tpl = new haxe.Template(str);
        return template = str;
    }

    public var tpl : haxe.Template;

    public function new(?template: String) {
        this.template = template ?? "::date:: ::level:: ::content:: ::if(meta!=null)::::meta::::end::\n";
    }

    public function format(msg:Message) : String {
        return tpl.execute({
            time: msg.time,
            content: msg.content,
            meta: msg.meta,
            level: msg.level.toString(),
            date: Date.fromTime(msg.time).toString(),
        });
    }
}
