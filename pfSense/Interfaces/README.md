I run multiple networks on my pfSense box
WAN - Internet IPv4
LAN - Local Home 
Crypto_Net - Miners and Nodes (internet only access)
Automations - IoT (Can only access internet (some devices) and other devices on its own network)
Guests - ... Self explanitory (no access to internal devices)
Untagged - required to set lagg mtu greater than 1500 (not really needed and can cause issues on some networks (jumbo frames are a pain)
SYNC - Used to ESXI and Storage data exchange
Fireball_Home_Vlan - Portable pfsense router/esxi network for long "trips overseas"
Family_VPN - Old OpenVPN since migrated users to Wireguard - OpenVPN Server
Family_WG - New Family VPN to connect iphones and mobile devices
Management - to manage the network
Servers - acts like a dmz for self hosted services
TORGUARD_VPN_SLC - TorGuard VPN connection (Salt lake city) - OpenVPN Client
ProtonVPN_Free_USA - Proton VPN Connection (San Fransico) - OpenVPN Client
WorkVPN - Work connection - OpenVPN Client
Peach_Tea_VPN - Connection to Self hosted MSP network  - OpenVPN Server
Mesh_WG - Wireguard Mesh implementation to several nodes
TORGUARD_VPN_CHI - TorGuard VPN connection (Chicago) - OpenVPN Client
TORGUARD_VPN_DAL - TorGuard VPN connection (Dallas) - OpenVPN Client
TORGUARD_VPN_LV - TorGuard VPN connection (Las Vegas) - OpenVPN Client
Routing_Vlan - Used to exchange ospf between local devices
Backup - used to directly connect to pfsense in case i lock myself out.... this happens often.
Riverbed_PEP - Vlan to Policy route TCP to Virtual riverbed appliance
WAN_V6 - Internet IPv6
WWAN_IPHONE_TETHER - Utilized in internet outages to get access to the internet via teathered iphone (wireless usb connection)

Here are a few snippits of my interfaces.

WAN is facing the internet
![WAN](https://user-images.githubusercontent.com/12887622/134784845-61c99b7d-2b96-4b42-8214-e9421c5917dc.JPG)


LAN is facing Internal
![LAN](https://user-images.githubusercontent.com/12887622/134784847-1a48067d-c852-4f05-a78b-0a069dace79e.JPG)


Family_WG is what my cellphone connects to (Wireguard)
![Family_WG](https://user-images.githubusercontent.com/12887622/134784857-38ca0196-9e93-4feb-bbfb-160377b23995.JPG)


TORGUARD is a template for the whole home VPN interface
![TORGUARD_SLC](https://user-images.githubusercontent.com/12887622/134784861-953fea09-5fe9-46ab-89fd-96be14531431.JPG)


VLANS are setup to traverse a LAGG connection
![VLANS](https://user-images.githubusercontent.com/12887622/134784866-642ea5f4-bd8f-4a1a-b95b-da297e09cba5.JPG)


GIF setup for IPv6 access (see pfsense cookbook for exact config)
![GIFs](https://user-images.githubusercontent.com/12887622/134784874-2919b665-2218-4fc2-9940-2496bd558c67.JPG)


LAGG is used to Aggrigate two 10G connections for redundancy and throughput
![LAGG](https://user-images.githubusercontent.com/12887622/134784895-8334da4b-331f-40a2-a110-c441bc131c2f.JPG)


I run multiple networks on my pfSense box
