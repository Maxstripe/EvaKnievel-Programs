EvaKnievel
=====

*locationservice*: Keeps a track of the current location by overriding the robot move methods
*logger*:Logs errors in OpenOS by copying all output sent to stderr to /var/log/stderr, lib will be added in later versions to allow programs to create more detail logs in later versions
*applicationconf*:Reads application.conf using an altered version of kilobyte's configparser, package contains the default application.conf which can be overridden