{
  flake.modules.homeManager.positron =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (positron-bin.overrideAttrs (old: {
          version = "2026.05.1-2";
          src = pkgs.fetchurl {
            url = "https://cdn.posit.co/positron/releases/deb/x86_64/Positron-2026.05.1-2-x64.deb";
            hash = "sha256-XBjC9hxOr6ioDpcZ4MT+hFOaxTXl+Xs331hyEdhx+oY=";
          };
          buildInputs = old.buildInputs ++ [
            pkgs.libsecret
            pkgs.webkitgtk_4_1
          ];
        }))
      ];
    };
}
