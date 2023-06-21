package om.log.level;

enum abstract Facility(Int) to Int {

    /**
        Kernel messages.
    **/
    var kern;

    /**
        User-level messages.
    **/
    var user;

    /**
        Mail system.
    **/
    var mail;

    /**
        System daemons.
    **/
    var daemon;

    /**
        Security/authentication messages.
    **/
    var auth;

    /**
        Messages generated internally by syslogd
    **/
    var syslog;

    /**
        Line printer subsystem.
    **/
    var lpr;

    /**
        Network news subsystem.
    **/
    var news;

    /**
        UUCP subsystem.
    **/
    var uucp;

    /**
        Cron subsystem.
    **/
    var cron;

    /**
        Security/authentication messages.
    **/
    var authpriv;

    /**
       FTP daemon. 
    **/
    var ftp;

    /**
       NTP daemon. 
    **/
    var ntp;

    /**
        Log audit.
    **/
    var security;

    /**
        Log alert.
    **/
    var console;

    /**
        Scheduling daemon.
    **/
    var solaris_cron;

    /**
        Locally used facilities.
    **/
    var local0;

    /**
        Locally used facilities.
    **/
    var local1;

    /**
        Locally used facilities.
    **/
    var local2;

    /**
        Locally used facilities.
    **/
    var local3;

    /**
        Locally used facilities.
    **/
    var local4;

    /**
        Locally used facilities.
    **/
    var local5;

    /**
        Locally used facilities.
    **/
    var local6;

    /**
        Locally used facilities.
    **/
    var local7;
}

/**
    Severity level.
**/
enum abstract Level(Int) to Int {

    /**
        Emergency.

        Description: System is unusable.
        Condition: A panic condition.
    **/
    var emerg;

    /**
        Description: Action must be taken immediately.
        Condition: A condition that should be corrected immediately, such as a corrupted system database.    
    **/
    var alert;

    /**
        Description: Critical conditions.
        Condition: Hard device errors.
    **/
    var crit;

    /**
        Description: Error conditions.
    **/
    var err;

    /**
        Description: Warning conditions.
    **/
    var warning;

    /**
        Description: Normal but significant conditions. 
        Condition: Conditions that are not error conditions, but that may require special handling.
    **/
    var notice;

    /**
        Description: Informational messages. 
        Condition: Confirmation that the program is working as expected.
    **/
    var info;

    /**
        Description: Debug-level messages. 
        Condition: Messages that contain information normally of use only when debugging a program.
    **/
    var debug;
}

