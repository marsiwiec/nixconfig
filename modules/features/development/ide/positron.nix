{
  flake.modules.homeManager.positron =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (positron-bin.overrideAttrs (old: {
          version = "2026.05.1-2";
          src = pkgs.fetchurl {
            url = "https://cdn.posit.co/positron/releases/deb/x86_64/Positron-2026.05.2-3-x64.deb";
            hash = "sha256-oCW3E8dZNksaKWdRZOeqXwEIgX0oCfe6VvTxBe18jYc=";
          };
          buildInputs = old.buildInputs ++ [
            pkgs.libsecret
            pkgs.webkitgtk_4_1
          ];
        }))
      ];
    };
}
