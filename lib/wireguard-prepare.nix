lib: {
  ip,
  endpointPeerExtra ? {},
  ...
} @ settings: {peers, ...} @ wireguardConfig: let
  getHost = ip: builtins.head (builtins.split "/" ip);
  ipHost = getHost ip;
  peerFilter = {allowedIPs, ...} @ peer: let
    allowedIPHosts = map getHost allowedIPs;
  in
    ! (builtins.any (e: e == ipHost) allowedIPHosts);
  peerMap = peer: lib.attrsets.recursiveUpdate (lib.attrsets.optionalAttrs (builtins.hasAttr "endpoint" peer) endpointPeerExtra) peer;
in
  wireguardConfig
  // {
    ips = [ip];
    peers = map peerMap (builtins.filter peerFilter peers);
  }
