import om.log.target.ConsoleTarget;
import utest.Assert.*;
import om.log.Logger;

class TestLogger extends utest.Test {

	function test_logger_construct() {
        var logger = new Logger(0);
        equals(0, logger.level);
        equals(1, logger.targets.length);
        isTrue(Std.is(logger.targets[0], ConsoleTarget));
        notNull(logger.format);
	}
	
    function test_logger_log() {
        var logger = new Logger(0);
        equals(0, logger.level);
        notNull(logger.format);
        logger.log("test");
        logger.log(0, "test");
    }

    // function test_logger_examine() {
    //     var logger = new Logger(0);
    //     logger.examine(1, 2, 3);
    // }
}
