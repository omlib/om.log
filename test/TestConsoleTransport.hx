import utest.Assert.*;
import om.log.Level;

class TestConsoleTransport extends utest.Test {

    function test_transport_console() {
        var t = new om.log.ConsoleTransport();
        notNull(t);


    }
}
