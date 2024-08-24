{...}: {
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  services.pipewire.extraConfig.pipewire-pulse."90-network" = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-protocol-simple";
        "args" = {
          "playback" = true;
          "server.address" = [
            "tcp:27459"
          ];
        };
      }
    ];
  };
}
