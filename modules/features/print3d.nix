{
  flake.modules.homeManager.print3d =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bambu-studio
        orca-slicer
        # Add desktop entry for bambu-studio (overlay did not produce one)
        (makeDesktopItem {
          name = "bambu-studio";
          desktopName = "Bambu Studio";
          exec = "bambu-studio";
          terminal = false;
          type = "Application";
          icon = builtins.fetchurl {
            url = "https://github.com/bambulab/BambuStudio/blob/b97b6475393eaa249e1a7f2c26f50b3d3d1a1ee4/resources/images/BambuStudio_192px.png";
            sha256 = "1v907xpwsy1qx7w9nm1893zl30hgd6rkfcbj6v3d9vpzxid510i7";
          };
        })
      ];
    };
}
