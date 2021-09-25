version 16.12
no service pad
service tcp-keepalives-in
service tcp-keepalives-out
service timestamps debug uptime
service timestamps log uptime
service password-encryption
no platform punt-keepalive disable-kernel-core
!
hostname Home_Switch
!
!
vrf definition Mgmt-vrf
 !
 address-family ipv4
 exit-address-family
 !
 address-family ipv6
 exit-address-family
!
enable secret 9 SUPER_SECRET_HASH_HERE
!
aaa new-model
!
!
aaa group server radius pfSense
 server name pfSense_MGMT
!
aaa authentication dot1x default group pfSense
aaa authorization network default group pfSense none 
aaa accounting dot1x default start-stop group pfSense
!
!
!
!
!
!
aaa session-id common
switch 1 provision ws-c3850-48p
cisp enable
!
!
!
!         
no ip source-route
!
!
!
!
!
ip admission watch-list expiry-time 0
ip multicast multipath
ip domain lookup source-interface Vlan15
ip domain name Real.fancy.domain.name
!
!
!
ip dhcp snooping vlan 1-999,1001-4094
ip dhcp snooping information option allow-untrusted
no ip dhcp snooping information option
ip dhcp snooping database flash:DHCP_SNOOPING_DB.txt
ip dhcp snooping
login block-for 100 attempts 3 within 100
login delay 10
login on-success log
!
!
!
!
!
authentication mac-move permit
authentication logging verbose
authentication critical recovery delay 2000
mab request format attribute 32 vlan access-vlan
mab logging verbose
no device-tracking logging theft
device-tracking policy IP_TRACKING
 no protocol ndp
 no protocol dhcp6
 no protocol udp
 tracking enable
!
device-tracking policy NO_IP_TRACKING
 trusted-port
 device-role switch
 no protocol ndp
 no protocol dhcp6
 no protocol arp
 no protocol dhcp4
 no protocol udp
!
password encryption aes
!
crypto pki trustpoint SLA-TrustPoint
 enrollment pkcs12
 revocation-check crl
!
crypto pki trustpoint TP-self-signed
 enrollment selfsigned
 subject-name cn=IOS-Self-Signed-Certificate
 revocation-check none
 rsakeypair TP-self-signed
!
!
crypto pki certificate chain SLA-TrustPoint
 certificate ca 01
CERT HASH
        quit
crypto pki certificate chain TP-self-signed
 certificate self-signed 01
 CERT HASH
        quit
!
!
port-channel load-balance src-dst-mac
dot1x system-auth-control
dot1x guest-vlan supplicant
dot1x critical eapol
system mtu 9198
license boot level ipbasek9
!
!
diagnostic bootup level minimal
!
spanning-tree mode mst
spanning-tree extend system-id
!
spanning-tree mst configuration
 name HOME_MST
 revision 3
!
spanning-tree mst 1 priority 24576
memory free low-watermark processor 79475
!
errdisable recovery cause psecure-violation
lacp system-priority 200
username commstech privilege 15 password 7 FANCY_PASSWORD
!
redundancy
 mode sso
!
!
!
!
!
transceiver type all
 monitoring
!
!
class-map match-any system-cpp-police-topology-control
  description Topology control
class-map match-any system-cpp-police-sw-forward
  description Sw forwarding, L2 LVX data, LOGGING
class-map match-any system-cpp-default
  description EWLC control, EWLC data, Inter FED 
class-map match-any system-cpp-police-sys-data
  description Learning cache ovfl, High Rate App, Exception, EGR Exception, NFL SAMPLED DATA, RPF Failed
class-map match-any system-cpp-police-punt-webauth
  description Punt Webauth
class-map match-any system-cpp-police-l2lvx-control
  description L2 LVX control packets
class-map match-any system-cpp-police-forus
  description Forus Address resolution and Forus traffic
class-map match-any system-cpp-police-multicast-end-station
  description MCAST END STATION
class-map match-any system-cpp-police-multicast
  description Transit Traffic and MCAST Data
class-map match-any system-cpp-police-l2-control
  description L2 control
class-map match-any system-cpp-police-dot1x-auth
  description DOT1X Auth
class-map match-any system-cpp-police-data
  description ICMP redirect, ICMP_GEN and BROADCAST
class-map match-any system-cpp-police-stackwise-virt-control
  description Stackwise Virtual
class-map match-any non-client-nrt-class
class-map match-any system-cpp-police-routing-control
  description Routing control and Low Latency
class-map match-any system-cpp-police-protocol-snooping
  description Protocol snooping
class-map match-any system-cpp-police-dhcp-snooping
  description DHCP snooping
class-map match-any system-cpp-police-system-critical
  description System Critical and Gold Pkt
!
policy-map system-cpp-policy
!
! 
!
!
!
!
!
!
!
!
!
template ACCESS_DEFAULT
 dot1x pae authenticator
 spanning-tree portfast
 spanning-tree bpdufilter enable
 spanning-tree bpduguard enable
 spanning-tree link-type point-to-point
 switchport mode access
 mab eap
!
template ACCESS_PORT
 dot1x pae authenticator
 spanning-tree portfast
 spanning-tree bpdufilter enable
 spanning-tree bpduguard enable
 switchport mode access
 mab eap
!
!
interface Port-channel1
 description to Garage
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport mode trunk
 spanning-tree guard root
!
interface Port-channel2
 description BlackRifle
 switchport access vlan 255
 switchport mode access
!
interface Port-channel3
 description BlackRifle_Storage
 switchport access vlan 250
 switchport mode access
!
interface Port-channel4
 description to 10G agg switch
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 ip dhcp snooping trust
! 
 interface GigabitEthernet0/0
 vrf forwarding Mgmt-vrf
 no ip address
 no ip route-cache
 shutdown
 negotiation auto
!
interface GigabitEthernet1/0/1
 description to cable model (ISP)
 switchport access vlan 1000
 power inline never
 no cdp enable
 no lldp transmit
 no lldp receive
 no lldp med-tlv-select power-management
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/2
 description to UniFi AP SWX-UAP
 switchport trunk native vlan 2
 switchport trunk allowed vlan 2,13,15
 switchport mode trunk
 spanning-tree portfast trunk
!
interface GigabitEthernet1/0/3
 description to APC Smart-UPS (PP2)
 switchport access vlan 15
 switchport mode access
!
interface GigabitEthernet1/0/4
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport mode trunk
 power inline never
 channel-protocol lacp
 channel-group 1 mode active
 spanning-tree portfast trunk
!
interface GigabitEthernet1/0/5
 description to Blizzard (NETAPP MGMT A)
 switchport access vlan 15
 switchport mode access
!
interface GigabitEthernet1/0/6
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport mode trunk
 power inline never
 channel-protocol lacp
 channel-group 1 mode active
 spanning-tree portfast trunk
!
interface GigabitEthernet1/0/7
 description to Blizzard (NETAPP MGMT B) (PP4)
 switchport access vlan 15
 switchport mode access
!
interface GigabitEthernet1/0/8
 switchport access vlan 7
 switchport mode access
!
interface GigabitEthernet1/0/9
 description to Blizzard (NETAPP e0a controller A) (PP5)
 switchport access vlan 250
 switchport mode access
 spanning-tree link-type point-to-point
!
interface GigabitEthernet1/0/10
 description unicorn3
 switchport access vlan 255
 switchport mode access
 power inline never
!
interface GigabitEthernet1/0/11
 description to Blizzard (NETAPP e0a Controller B) (PP6)
 switchport access vlan 250
 switchport mode access
 spanning-tree link-type point-to-point
!
interface GigabitEthernet1/0/12
 description to UniFi AP setup
 switchport trunk native vlan 2
 switchport trunk allowed vlan 2,7,12,13,15
 switchport mode trunk
 spanning-tree portfast trunk
!
interface GigabitEthernet1/0/13
 description ESXi .6 VMNIC 1 (PP7)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,250,1000
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/14
 description Raspberry pi 3b (Left) #1
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/15
 description ESXi .2 VMNIC 1 (PP8)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/16
 description Raspberry pi 3b (second from Left) #2
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/17
 description ESXi .3 VMNIC 1 (PP9)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/18
 description Raspberry pi 3b (second from Right) #3
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/19
 description ESXi .4 VMNIC 1 (PP10)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/20
 description Raspberry pi 2 (far right) #4
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/21
 description esxi .7 vmnic (PP11)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/22
 description UniCorn_1
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/23
 description ESXi .6 VMNIC 0 (PP12)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,250,1000
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/24
 description UniCorn_2
 switchport access vlan 255
 switchport mode access
!
interface GigabitEthernet1/0/25
 description ESXi .2 VMNIC 0 (PP13)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/26
 description to TravelTAB
 switchport access vlan 2
 switchport mode access
!
interface GigabitEthernet1/0/27
 description ESXi .3 VMNIC 0 (PP14)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/28
 description TRAVELtab MGMT Network
 switchport access vlan 15
!
interface GigabitEthernet1/0/29
 description ESXi .4 VMNIC 0 (PP15)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/30
!
interface GigabitEthernet1/0/31
 description ESXi .7 VMNIC 0 (PP16)
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/32
!
interface GigabitEthernet1/0/33
 description idrac .6 (.16) (PP17)
 switchport access vlan 250
 switchport mode access
!
interface GigabitEthernet1/0/34
 description esxi .7 vmnic1
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,250,1000
 switchport mode trunk
 power inline never
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface GigabitEthernet1/0/35
 description idrac .2 (.12) (PP18)
 switchport access vlan 250
 switchport mode access
!
interface GigabitEthernet1/0/36
 description to UniFi AP NanoBeamAC GEN2
 switchport trunk allowed vlan 2,7,12,13,15
 switchport mode trunk
!
interface GigabitEthernet1/0/37
 description idrac .3 (.13) (PP 19)
 switchport access vlan 250
 switchport mode access
!
interface GigabitEthernet1/0/38
 description to WAN
 switchport access vlan 1001
 switchport mode access
 no cdp enable
 no lldp transmit
 no lldp receive
 no lldp tlv-select power-management
 no lldp tlv-select 4-wire-power-management
 no lldp med-tlv-select network-policy
 no lldp med-tlv-select power-management
 no lldp med-tlv-select location
 no lldp med-tlv-select inventory-management
!
interface GigabitEthernet1/0/39
 description idrac .4 (.14) (PP20)
 switchport access vlan 250
 switchport mode access
!
interface GigabitEthernet1/0/40
 description idrac .5 (.15 TrueNAS)
 switchport access vlan 15
 switchport mode access
!
interface GigabitEthernet1/0/41
!
interface GigabitEthernet1/0/42
 description idrac .7 (.17)
 switchport access vlan 250
 switchport mode access
!
interface GigabitEthernet1/0/43
 switchport access vlan 2
 switchport mode access
!
interface GigabitEthernet1/0/44
 description BlackRifle
 switchport access vlan 255
 switchport mode access
 power inline never
 channel-protocol lacp
 channel-group 2 mode active
!
interface GigabitEthernet1/0/45
 description BlackRifle
 switchport access vlan 255
 switchport mode access
 power inline never
 channel-protocol lacp
 channel-group 2 mode active
!
interface GigabitEthernet1/0/46
 description BlackRifle
 switchport access vlan 255
 switchport mode access
 power inline never
 channel-protocol lacp
 channel-group 2 mode active
!
interface GigabitEthernet1/0/47
 description BlackRifle_Storage
 switchport access vlan 250
 switchport mode access
 power inline never
 channel-protocol lacp
 channel-group 3 mode active
!
interface GigabitEthernet1/0/48
 description BlackRifle_Storage
 switchport access vlan 250
 switchport mode access
 power inline never
 channel-protocol lacp
 channel-group 3 mode active
!
interface GigabitEthernet1/1/1
 switchport access vlan 1000
 switchport mode access
 speed 1000
 ip dhcp snooping trust
!
interface GigabitEthernet1/1/2
!
interface GigabitEthernet1/1/3
!
interface GigabitEthernet1/1/4
!
interface TenGigabitEthernet1/1/1
!
interface TenGigabitEthernet1/1/2
!
interface TenGigabitEthernet1/1/3
 description to 10G agg switch port 1
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 neighbor device type Switch
 channel-protocol lacp
 channel-group 4 mode active
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface TenGigabitEthernet1/1/4
 description to 10G agg switch port 2
 switchport trunk allowed vlan 2,4,5,7,10,12,13,15,50,51,224,250,255,1000,1001
 switchport trunk allowed vlan add 4009
 switchport mode trunk
 neighbor device type Switch
 channel-protocol lacp
 channel-group 4 mode active
 spanning-tree portfast trunk
 ip dhcp snooping trust
!
interface Vlan1
 no ip address
 no ip route-cache
 shutdown
!
interface Vlan2
 ip address YOUR.IP 255.255.255.128
 ip mtu 1500
 no ip route-cache cef
!
interface Vlan15
 ip address dhcp
 ip helper-address YOUR.IP
 ip mtu 1500
 no ip route-cache cef
!
interface Vlan224
 description routing-vlan
 ip address YOUR.IP 255.255.255.248
 no ip redirects
 no ip unreachables
 no ip proxy-arp
 ip mtu 1500
 ip pim sparse-dense-mode
 no ip route-cache cef
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 7 072C2E61633317560343055F106B6A
 ip ospf network broadcast
 ipv6 address IPv6_address
!
ip default-gateway YOUR.IP
ip forward-protocol nd
ip tcp synwait-time 10
ip tcp path-mtu-discovery
no ip http server
ip http authentication local
no ip http secure-server
ip ssh version 2
!
!
ip radius source-interface Vlan15 
logging host YOUR.IP
ip access-list standard 10
 10 permit YOUR.IP 0.0.0.7
 20 remark REMOTE_ACCESS_MGMT
 20 permit YOUR.IP 0.0.0.127 log
 30 permit YOUR.IP 0.0.0.127 log
ip access-list standard 11
 10 permit YOUR.IP 0.0.0.7 log
 30 permit YOUR.IP 0.0.0.127 log
ip access-list standard 99
 10 remark Black_Hole
 10 deny   any log
!
!
snmp-server group ReadWrite v3 priv write v1default access 10
snmp-server community DENIED_RO RO 99
snmp-server community DENIED_RW RW 99
snmp-server location Home
snmp-server contact a guy
snmp-server enable traps snmp authentication linkdown linkup coldstart warmstart
snmp-server enable traps flowmon
snmp-server enable traps entity-perf throughput-notif
snmp-server enable traps call-home message-send-fail server-fail
snmp-server enable traps tty
snmp-server enable traps ospf state-change
snmp-server enable traps ospf errors
snmp-server enable traps ospf retransmit
snmp-server enable traps ospf lsa
snmp-server enable traps ospf cisco-specific state-change nssa-trans-change
snmp-server enable traps ospf cisco-specific state-change shamlink interface
snmp-server enable traps ospf cisco-specific state-change shamlink neighbor
snmp-server enable traps ospf cisco-specific errors
snmp-server enable traps ospf cisco-specific retransmit
snmp-server enable traps ospf cisco-specific lsa
snmp-server enable traps eigrp
snmp-server enable traps auth-framework sec-violation
snmp-server enable traps rep
snmp-server enable traps vtp
snmp-server enable traps vlancreate
snmp-server enable traps vlandelete
snmp-server enable traps port-security
snmp-server enable traps license
snmp-server enable traps smart-license
snmp-server enable traps cpu threshold
snmp-server enable traps memory bufferpeak
snmp-server enable traps stackwise
snmp-server enable traps fru-ctrl
snmp-server enable traps flash insertion removal lowspace
snmp-server enable traps energywise
snmp-server enable traps power-ethernet group 1 threshold 80
snmp-server enable traps power-ethernet police
snmp-server enable traps entity
snmp-server enable traps envmon
snmp-server enable traps cef resource-failure peer-state-change peer-fib-state-change inconsistency
snmp-server enable traps lisp
snmp-server enable traps isis
snmp-server enable traps ipsla
snmp-server enable traps entity-diag boot-up-fail hm-test-recover hm-thresh-reached scheduled-test-fail
snmp-server enable traps bfd
snmp-server enable traps ike policy add
snmp-server enable traps ike policy delete
snmp-server enable traps ike tunnel start
snmp-server enable traps ike tunnel stop
snmp-server enable traps ipsec cryptomap add
snmp-server enable traps ipsec cryptomap delete
snmp-server enable traps ipsec cryptomap attach
snmp-server enable traps ipsec cryptomap detach
snmp-server enable traps ipsec tunnel start
snmp-server enable traps ipsec tunnel stop
snmp-server enable traps ipsec too-many-sas
snmp-server enable traps config-copy
snmp-server enable traps config
snmp-server enable traps config-ctid
snmp-server enable traps dhcp
snmp-server enable traps event-manager
snmp-server enable traps hsrp
snmp-server enable traps ipmulticast
snmp-server enable traps msdp
snmp-server enable traps ospfv3 state-change
snmp-server enable traps ospfv3 errors
snmp-server enable traps pim neighbor-change rp-mapping-change invalid-pim-message
snmp-server enable traps rsvp
snmp-server enable traps bridge newroot topologychange
snmp-server enable traps stpx inconsistency root-inconsistency loop-inconsistency
snmp-server enable traps syslog
snmp-server enable traps vlan-membership
snmp-server enable traps errdisable
snmp-server enable traps rf
snmp-server enable traps transceiver all
snmp-server enable traps bulkstat collection transfer
snmp-server enable traps mac-notification change move threshold
snmp-server enable traps vrfmib vrf-up vrf-down vnet-trunk-up vnet-trunk-down

!
radius-server dead-criteria time 5 tries 4
radius-server deadtime 5
!         
radius server pfSense_MGMT
 address ipv4 YOUR.IP auth-port 1812 acct-port 1813
 timeout 3
 retransmit 0
 automate-tester username real_user_Here probe-on
 key 7 3qe4rtsafgw4564256sdfhgbsfg_Key_Here
!
!
control-plane
 service-policy input system-cpp-policy
!
banner motd ^CYou Are Attempting to Access a Secure Device. If you do not have express written consent STOP!^C
!
line con 0
 logging synchronous
 stopbits 1
line aux 0
 access-class 99 in
 exec-timeout 0 1
 no exec
 stopbits 1
line vty 0 4
 session-timeout 10 
 access-class 10 in
 exec-timeout 9 59
 logging synchronous
 vacant-message ^CTerminal Disconnected^C
 transport preferred ssh
 transport input ssh
 transport output none
line vty 5 15
 session-timeout 10 
 access-class 10 in
 exec-timeout 9 59
 logging synchronous
 vacant-message ^CTerminal Disconnected^C
 transport preferred ssh
 transport input ssh
 transport output none
!
ntp server YOUR.IP
device-tracking binding reachable-lifetime 45