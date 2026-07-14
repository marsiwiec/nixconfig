{
  inputs,
  ...
}:
{
  flake.modules.homeManager.niri-keybinds =
    {
      # config,
      ...
    }:
    {
      imports = [
        inputs.self.modules.homeManager.niri-keybinds-dms
        # inputs.self.modules.homeManager.niri-keybinds-noctalia
      ];
    };
}
