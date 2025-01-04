{ ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;

    extraConfig.pipewire-pulse."90-network" = {
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
  };
}
