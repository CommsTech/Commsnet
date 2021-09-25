# Commsnet
My Journey to the fastest Internet. I am constantly learning new tatics and attempting to implement them into my Home Lab network. This project is a colletion of my lessons learned as well as thing that can be done sucessfully to speed up your network. Enjoy

Problem set. Most home internet providers have async upload and download speeds. but for you to unlock the true potential of the internet you need syncronus download and upload speeds. This will allow you to both stream a movie on netflix while uploading that latest video to your fav social media site. The problem is that you cannot accomlish this on the 20 Mbps upload that your ISP offers without buffering. the way TCP works is not a one way lane. It requires both requests and offers from both ends of the connection. I currently have 1Gbps download and 20 Mbps upload. I want to proxy, secure, and deduplicate anything I send out of my network to reduce my utilization of my uplink. 

The Layout:
![Commsnet](https://user-images.githubusercontent.com/12887622/134783754-95b977ae-c3ea-4e61-8fd9-6a4edc3579c2.jpg)


Refrences:
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
