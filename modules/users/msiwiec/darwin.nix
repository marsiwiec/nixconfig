{
  inputs,
  ...
}:
{
  # Darwin user configuration
  flake.modules.darwin.msiwiec =
    { ... }:
    {
      imports = with inputs.self.modules.darwin; [
        home-manager
        zsh-shell
      ];

      home-manager.users.msiwiec = {
        imports = [ inputs.self.modules.homeManager.msiwiec ];
      };
    };
}
