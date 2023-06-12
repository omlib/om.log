package om.log;

class LevelTools {

    public static function enabledFor(logger: {level:Null<Level>}, level: Null<Level>) : Bool {
        return ((logger.level == null) || (level == null)) ? true
            : cast(logger.level, Int) >= cast(level, Int);
    }
}
