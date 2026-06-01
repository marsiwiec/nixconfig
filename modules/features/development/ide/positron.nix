{
  flake.modules.homeManager.positron =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (positron-bin.overrideAttrs (old: {
          version = "2026.06.0-211";
          src = pkgs.fetchurl {
            url = "https://cdn.posit.co/positron/releases/deb/x86_64/Positron-2026.06.0-211-x64.deb";
            hash = "sha256-YvnweVTKAvxZTR5/FY1VWt03Gx4LFa2faL+Z0AYCtpY=";
          };
          buildInputs = old.buildInputs ++ [
            pkgs.libsecret
            pkgs.webkitgtk_4_1
          ];
        }))
      ];
    };
}
