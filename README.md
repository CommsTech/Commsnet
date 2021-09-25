# Commsnet
My Journey to the fastest Internet



Firewall/Routers
- https://www.pfsense.org/download/

Firewall Recipes
- add ipv6
  https://docs.netgate.com/pfsense/en/latest/recipes/ipv6-tunnel-broker.html
- add some old school cache
  https://docs.netgate.com/pfsense/en/latest/recipes/http-client-proxy-transparent.html
- Snort for IPS/IDS
  https://docs.netgate.com/pfsense/en/latest/packages/snort/setup.html?highlight=snort
- HaProxy for some revese proxy (I tried both Squid and HA and had less issues with HA, Probably me tho)
  https://docs.netgate.com/pfsense/en/latest/packages/haproxy.html
  

Cloudflare Backbone Connections
- add Railgun
https://github.com/VostroNet/docker-cloudflare-railgun
- Cloudflared In a Docker
https://github.com/judge2020/docker-cloudflared
- Cloudflared
https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation

Wireguard VPNs
- Cloudflare WARP WG (I added to Pfsense as a Client)
https://github.com/ViRb3/wgcf


Other VPNs (OpenVPN)
- ProtonVPN (I added to Pfsense as a Client)
https://protonvpn.com/
- TorGuard (I added to Pfsense as a Client)
https://torguard.net/

Docker and Docker Swarms
- Swarmpit (where I started to learn Swarms But have since migrated off to Protainer, I do still like this project tho)
https://swarmpit.io/
- Portainer
https://www.portainer.io/

Docker Images / Guides
- Amazing guide to setup pihole and cloudflared on a docker swarm
https://mroach.com/2020/08/pi-hole-and-cloudflared-with-docker/


MPTCP
https://github.com/suyuan168/openmptcprouter-vps
https://github.com/Ysurac/openmptcprouter-vps
