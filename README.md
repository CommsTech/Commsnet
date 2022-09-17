# **COMMSNET**
## This repo has been replaced with [my wiki](https://wiki.commsnet.org
===============

My journey to the fastest Internet. I am constantly learning new tactics and attempting to implement them into my Home Lab network. This project is a collection of my lessons learned as well as thing that can be done successfully to speed up your network. Enjoy

Problem set. Most home internet providers have async upload and download speeds. but for you to unlock the true potential of the internet you need synchronous download and upload speeds. This will allow you to both stream a movie on Netflix while uploading that latest video to your fav social media site. The problem is that you cannot accomplish this on the 20 Mbps upload that your ISP offers without buffering. the way TCP works is not a one-way lane. It requires both requests and offers from both ends of the connection. I currently have 1Gbps download and 20 Mbps upload. I want to proxy, secure, and deduplicate anything I send out of my network to reduce my utilization of my uplink. 

I am a Network Engineer with more than 15 years in the business. I hold several certifications but I’m still learning and some of this information could be wrong or not complete. Please if you find something incorrect or that could be done better, please let me know. I’m all about making this setup better. If you like this collection and want to see more please donate to BTC 32qLDFgfwNct8M52qnV2rSxCbFn5LgbUW7  

The Layout:
---------------	
![Commsnet](https://user-images.githubusercontent.com/12887622/134783754-95b977ae-c3ea-4e61-8fd9-6a4edc3579c2.jpg)

My Equipment in order top to bottom:
- 25U Startech Rack containing:
- 1U TRENDnet 24-Port Blank Keystone Shielded 1U Patch Panel, TC-KP24S
- 1U Cisco 3850 48 PoE+
- 1U Dell 210ii rebranded as Riverbed EX560's
- 1U 4x raspberry pi (3x 3b and 1x 2b)
- 1U Dell 210ii rebranded as Riverbed EX560's
- 1U Dell 210ii rebranded as Riverbed EX560's
- 1U Dell 210ii rebranded as Riverbed EX560's
- 1U Dell R420
- 1U Blank
- 1U Blank
- 1U Unifi US-16-XG
- 2U Rackmountable systems server
- 2U Netapp server
- 4U (not rack mountable but modified rails) desktop pc running Plex with 2x P2000
- on the bottom a 1000 APC UPS, 2x fans and a cable modem arris S33


![Rack](https://user-images.githubusercontent.com/12887622/134785694-fcdd0c10-428b-4bcd-99a7-ca7d28501cba.jpg)


Table Of Contents
---------------	
- [Additional VMs](https://github.com/CommsTech/Commsnet/tree/main/additional%20VMs)
	- [HomeAssistant](https://github.com/CommsTech/Commsnet/tree/main/additional%20VMs/Homeassistant)
	- [KASM](https://github.com/CommsTech/Commsnet/tree/main/additional%20VMs/KASM)
	- [Ubuntu Server](https://github.com/CommsTech/Commsnet/tree/main/additional%20VMs/Ubuntu_Server)
	- [Unifi Controller](https://github.com/CommsTech/Commsnet/tree/main/additional%20VMs/Unifi_Controller)

- [Cloudflare](https://github.com/CommsTech/Commsnet/tree/main/Cloudflare)

- [Docker Swarm](https://github.com/CommsTech/Commsnet/tree/main/Docker%20Swarm)

- [ESXi](https://github.com/CommsTech/Commsnet/tree/main/ESXi)

- [iPhone and ios](https://github.com/CommsTech/Commsnet/tree/main/iPhone%20and%20ios)

- [Media Management](https://github.com/CommsTech/Commsnet/tree/main/Media%20Management)

- [Networking](https://github.com/CommsTech/Commsnet/tree/main/Networking)
	- [Cisco](https://github.com/CommsTech/Commsnet/tree/main/Networking/Cisco)
	- [Unifi](https://github.com/CommsTech/Commsnet/tree/main/Networking/Unifi)
	- [pfSense](https://github.com/CommsTech/Commsnet/tree/main/Networking/pfSense)
		- [Firewall](https://github.com/CommsTech/Commsnet/tree/main/Networking/pfSense/Firewall)
		- [Interfaces](https://github.com/CommsTech/Commsnet/tree/main/Networking/pfSense/Interfaces)
		- [Services](https://github.com/CommsTech/Commsnet/tree/main/Networking/pfSense/Services/)
			- [Squid](https://github.com/CommsTech/Commsnet/tree/main/Networking/pfSense/Services/Squid)
	
- [Bandwidth and Privacy Conservation](https://github.com/CommsTech/Commsnet/tree/main/Privacy%20and%20Bandwith%20Conservation)

- [Security](https://github.com/CommsTech/Commsnet/tree/main/Security)

- [SIEMs](https://github.com/CommsTech/Commsnet/tree/main/SIEMs)

- [Troubleshooting](https://github.com/CommsTech/Commsnet/tree/main/Troubleshooting)


References:
---------------	
Firewall/Routers
- https://www.pfsense.org/download/

Firewall Recipes
- add ipv6
	- https://docs.netgate.com/pfsense/en/latest/recipes/ipv6-tunnel-broker.html
- add some old school cache
	- https://docs.netgate.com/pfsense/en/latest/recipes/http-client-proxy-transparent.html
- Snort for IPS/IDS
	- https://docs.netgate.com/pfsense/en/latest/packages/snort/setup.html?highlight=snort
- HaProxy for some revese proxy (I tried both Squid and HA and had less issues with HA, Probably me tho)
	- https://docs.netgate.com/pfsense/en/latest/packages/haproxy.html
  

Cloudflare Backbone Connections
- add Railgun (careful make sure your site supports this before implementation)
	- https://github.com/VostroNet/docker-cloudflare-railgun
- Cloudflared In a Docker
	- https://github.com/judge2020/docker-cloudflared
- Cloudflared
	- https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation

Wireguard VPNs
- Cloudflare WARP WG (I added to Pfsense as a Client)
	- https://github.com/ViRb3/wgcf


Other VPNs (OpenVPN)
- ProtonVPN (I added to Pfsense as a Client)
	- https://protonvpn.com/
- TorGuard (I added to Pfsense as a Client)
	- https://torguard.net/

Docker and Docker Swarms
- Swarmpit (where I started to learn Swarms But have since migrated off to Protainer, I do still like this project tho)
	- https://swarmpit.io/
- Portainer
	- https://www.portainer.io/

Docker Images / Guides
- Amazing guide to setup pihole and cloudflared on a docker swarm
	- https://mroach.com/2020/08/pi-hole-and-cloudflared-with-docker/


MPTCP
- https://www.openmptcprouter.com/
- https://github.com/suyuan168/openmptcprouter-vps
- https://github.com/Ysurac/openmptcprouter-vps

Network Drawings
- Draw.io
