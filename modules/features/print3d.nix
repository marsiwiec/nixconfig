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
            sha256 = "114qnz0i6qjm3zws31yw237kkcq969gw8ymd3jab24wsxjd6mv7r";
          };
        })
      ];
    };
}
