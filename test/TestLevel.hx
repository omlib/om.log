import utest.Assert.*;
import om.log.Level;

class TestLevel extends utest.Test {

    function test_values() {
        equals(0, Level.error);
        equals(1, Level.warn);
        equals(2, Level.info);
        equals(3, Level.debug);
        equals(4, Level.verbose);
        equals(5, Level.all);
    }
}
