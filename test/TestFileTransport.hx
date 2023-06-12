import utest.Assert.*;
import om.log.Level;

class TestFileTransport extends utest.Test {

    function test_transport_file() {
        var t = new om.log.FileTransport("om.log");
        notNull(t);
    }
}
