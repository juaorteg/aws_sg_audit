module AwsSgAudit
  # TCP
  SSH     = 22..22
  SMTP    = 25..25
  HTTP    = 80..80
  HTTPS   = 443..443

  # UDP
  DNS    = 53..53
  DHCP   = 67..67
  NTP    = 123..123
  SYSLOG = 1514..1514

  # ICMP
  ALL_ICMP     = 1..-1
  ECHO_REPLY   = 0..-1
  ECHO_REQUEST = 8..-1
  TRACEROUTE   = 30..-1
end