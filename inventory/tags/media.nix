{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ffmpeg
    pkgs.wiremix
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;
}
