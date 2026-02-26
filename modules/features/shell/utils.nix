{
  flake.modules.homeManager.shell-utils =
    { pkgs, ... }:
    {
      programs.fd.enable = true;
      home.packages = with pkgs; [
        unzip
        duf
        just
      ];
    };
}
