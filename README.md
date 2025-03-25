# The issue
Under some unknown circumstances the echo frameworks c.RealIp() function returns `host:port` instead of `host`.
When I tried to reproduce the issue on the 24.03.25 I saw the code behave differently on two different machines, one of the main differences were thier CPU architecture (ARM and X86_64). As I can not reproduce the issue right now I suspect that the cpu architecture is not the cause of this.
# My setup
I use a alpine docker container to build the binary, then I copy the binary into a new docker container with no base ([from scratch](https://hub.docker.com/_/scratch)), I copy the SSL authorities and the /etc/passwd file to the deployment container.

I setup a docker compose file that defines a ipv6 network, with a Caddy reverse proxy, this proxy binds ports in a host mode and forwards the traffic to the application.
