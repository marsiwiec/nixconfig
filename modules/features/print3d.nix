{
  flake.modules.homeManager.print3d =
    { osConfig, pkgs, ... }:
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
          icon = "${osConfig.systemConstants.iconDir}/BambuStudio_192px.png";
        })
      ];
    };
}
