import utest.Assert.*;
import om.log.target.FileTarget;

class TestFileTarget extends utest.Test {

    function test_file_target() {
        var t = new FileTarget("om.log");
        notNull(t);
    }
}
