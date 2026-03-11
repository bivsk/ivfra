{ lib, pkgs, ... }:
let
  inherit (lib)
    listToAttrs
    mkDefault
    nameValuePair
    ;

  # Helper to define mime defaults in bulk
  mimeDefaults = mimeList: appList: mimeList |> map (mime: nameValuePair mime appList) |> listToAttrs;
in
{
  programs = {
    # Ebook reader
    foliate.enable = true;

    # PDF reader
    zathura = {
      enable = true;
      options.recolor = true;
    };

    # MPV
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        autoload
      ];
      config = {
        # High quality video output
        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";

        # Video settings
        hwdec = "auto-safe";
        vo = "gpu";

        # Audio
        audio-pitch-correction = "yes";
        volume-max = 150;

        # Subtitles
        sub-auto = "fuzzy";
        sub-font = mkDefault "Liberation Sans";
        sub-font-size = 36;

        # YouTube support
        ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";

        # Cache
        cache = "yes";
        cache-secs = 300;

        # UI
        osc = "yes";
        osd-bar = "yes";
      };

      bindings = {
        # Volume
        "WHEEL_UP" = "add volume 2";
        "WHEEL_DOWN" = "add volume -2";

        # Seek
        "Shift+RIGHT" = "seek 10";
        "Shift+LEFT" = "seek -10";

        # Speed
        "[" = "multiply speed 0.9091";
        "]" = "multiply speed 1.1";
        "\\" = "set speed 1.0";

        # Screenshot
        "s" = "screenshot";
        "S" = "screenshot video";
      };
    };

    cava.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      mimeDefaults
        [
          "image/png"
          "image/jpeg"
          "image/jpg"
          "image/gif"
          "image/webp"
          "image/bmp"
          "image/svg+xml"
          "image/tiff"
        ]
        [
          "org.gnome.gThumb.desktop"
          "imv.desktop "
        ]
      //
        mimeDefaults
          [
            "video/mp4"
            "video/x-matroska"
            "video/webm"
            "video/avi"
            "video/quicktime"
          ]
          [ "mpv.desktop" ]
      //
        mimeDefaults
          [
            "application/pdf"
          ]
          [ "org.pwmt.zathura.desktop" ];
  };

  home.packages = with pkgs; [
    # Audio control
    pwvucontrol
    wiremix
    playerctl

    # Image viewers
    gthumb
    imv

    # Gfx
    exiftool
    imagemagick
    jpeginfo
    krita
    wl-color-picker

    # Streaming
    ani-cli
    spotify
  ];
}
