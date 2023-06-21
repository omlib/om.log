import utest.Assert.*;
import om.log.Logger;
import om.log.format.*;

class TestFormat extends utest.Test {

    function test_format_json() {
        var f = new JsonFormat();
        notNull(f);
    }
}
