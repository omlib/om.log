package om.log;

interface Format {
    function format(msg: Message) : String;
}
