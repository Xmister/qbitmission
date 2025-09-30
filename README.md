# qBitmission
A docker container with qBittorrent with Transmission API wrapper

The image is based on [linuxserver/qbittorrent](https://hub.docker.com/r/linuxserver/qbittorrent) with one extra: a Transmission API wrapper, called [Reflection](https://github.com/Xmister/Reflection)

An example of usage can be seen in run-example.sh. You can learn more at [linuxserver/qbittorrent](https://hub.docker.com/r/linuxserver/qbittorrent).

## Race Condition Fix

This version includes a fix for a race condition that would cause transmission clients to crash when multiple clients tried to connect simultaneously. The original Reflection code used a global connection variable that was shared across all requests, leading to authentication conflicts and data corruption.

The fix eliminates this global variable and creates a separate connection instance for each HTTP request, ensuring that multiple transmission clients can connect concurrently without interfering with each other.

See `reflection-patches/README.md` for technical details about the fix.
