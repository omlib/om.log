package om.log;

interface Format {
    function format(msg: om.log.Message) : String;
}
