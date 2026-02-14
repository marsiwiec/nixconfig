{
  flake.modules.nixos.nh = {
    programs.nh.enable = true;
    environment.shellAliases = {
      update = "nh os switch --ask";
    };
  };
  flake.modules.homeManager.nh =
    { config, ... }:
    {
      programs.nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/nixconfig";
      };
    };
}
