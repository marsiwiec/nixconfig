{
  flake.modules.homeManager.positron =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ positron-bin ];
    };
}
