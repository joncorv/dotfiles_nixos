{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;

  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  # Add jellyfin user to render group for GPU access
  users.users.jellyfin.extraGroups = [
    "render"
    "video"
    "media"
  ];

  # Enable hardware acceleration packages
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Intel iGPU (if you have one)
      intel-vaapi-driver # Fallback for older codecs
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };
  systemd.tmpfiles.rules = [
    "d /srv/media 0775 astro media -"
    "d /srv/media/videos 0775 astro media -"
  ];

  users.groups.media = {
    members = [
      "astro"
      "jellyfin"
    ];
  };

}
