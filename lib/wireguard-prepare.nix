ip: {peers, ...} @ wireguardConfig: let
  getHost = ip: builtins.head (builtins.split "/" ip);
  ipHost = getHost ip;
  peerFilter = {allowedIPs, ...} @ peer: let
    allowedIPHosts = map getHost allowedIPs;
  in
    ! (builtins.any (e: e == ipHost) allowedIPHosts);
in
  wireguardConfig
  // {
    ips = [ip];
    peers = builtins.filter peerFilter peers;
  }
