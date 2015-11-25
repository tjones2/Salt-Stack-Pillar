# vim: sts=2:ts=2:et:ai


pptp:
  localip: 'x.x.x.x'
  remoteip: 'x.x.x.x'
  ppp_chap: '/etc/ppp/chap-secrets'
  config: /etc/pptpd.conf
  user: 'user pptpd password *'
  iptables:
    - 'echo net.ipv4.ip_forward = 1 > /etc/sysctl.conf && sysctl -p'
    - 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save'
    - 'iptables --table nat --append POSTROUTING --out-interface ppp0 -j MASQUERADE'
    - 'iptables -I INPUT -s x.x.x.x/x -i ppp0 -j ACCEPT'
    - 'iptables --append FORWARD --in-interface eth0 -j ACCEPT'

