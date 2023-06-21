import utest.Assert.*;
import om.log.target.ConsoleTarget;

class TestConsoleTarget extends utest.Test {

    function test_console_target() {
        var t = new ConsoleTarget();
        notNull(t);
    }
}
