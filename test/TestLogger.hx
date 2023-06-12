import utest.Assert.*;
import om.log.Logger;
import om.log.Level;
using om.log.LevelTools;

class TestLogger extends utest.Test {

	function test_logger() {
        var logger = new Logger();
        equals(warn, logger.level);
        //equals(1, logger.transports.length);
        notNull(logger.format);
        isTrue(logger.enabledFor(error));
        isTrue(logger.enabledFor(warn));
        isFalse(logger.enabledFor(info));
        isFalse(logger.enabledFor(debug));
        isFalse(logger.enabledFor(verbose));
        isFalse(logger.enabledFor(all));
	}
}
