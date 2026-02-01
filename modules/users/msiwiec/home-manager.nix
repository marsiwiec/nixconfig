{
  inputs,
  ...
}:
let
  name = "Marcin Siwiec";
  email = "marsiwiec@users.noreply.github.com";
in
{
  # Home-Manager configuration for msiwiec
  flake.modules.homeManager.msiwiec =
    { lib, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        cli
        shell
        helix
        firefox
      ];

      home = {
        username = lib.mkDefault "msiwiec";
        homeDirectory = lib.mkDefault "/home/msiwiec";
      };
      programs.zsh.enable = true;

      # Git configuration with user info
      programs.git.settings.user = {
        inherit name email;
      };
    };
}
