{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    looking-glass.enable = lib.mkEnableOption "enable looking glass config for GPU passthrough";
  };

  config = lib.mkIf config.looking-glass.enable {
    # Shell script for running windows VM through looking glass
    home.packages = with pkgs; [
      (writeShellScriptBin "win" ''
              tmp=$(virsh --connect qemu:///system list | grep " win11" | awk '{ print $3}')
        if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
        then
            virsh --connect qemu:///system start win11
            echo "Virtual Machine win11 is starting..."
            sleep 3
        fi
        looking-glass-client &
        exit

      '')
      # Create desktop entry the nix way
      (makeDesktopItem {
        name = "windows";
        desktopName = "Windows VM";
        exec = "win";
        terminal = false;
        type = "Application";
        icon = "windows";
      })
      # assign an icon the nix way...
      (stdenv.mkDerivation {
        name = "windows-icon";
        src = [ ../../../../style/icons/win11icon.png ];

        unpackPhase = ''
          for srcFile in $src; do
            # Copy file into build dir
            cp $srcFile ./
          done
        '';

        installPhase = ''
          mkdir -p $out $out/share $out/share/icons/hicolor/48x48/apps
          cp $src $out/share/icons/hicolor/48x48/apps/windows.png
        '';
      })
    ];

    programs.looking-glass-client = {
      enable = true;
      settings = {
        app = {
          allowDMA = true;
          shmFile = "/dev/kvmfr0";
        };
        win = {
          fullScreen = true;
          showFPS = false;
          jitRender = true;
        };
        spice = {
          enable = true;
          audio = true;
        };
      };
    };
  };
}
