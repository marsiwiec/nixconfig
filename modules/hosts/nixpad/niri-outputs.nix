{
  # Niri output config for the laptop.
  #
  # The internal panel shows up as "eDP-1". No mode is forced here, so niri
  # just uses the panel's native resolution. After first boot you can check
  # the actual output name/modes with `niri msg outputs` and pin them here
  # (see nixgroot/niri-outputs.nix for a full example).
  flake.modules.homeManager.niri-outputs-nixpad = {
    programs.niri.settings = {
      # Example (uncomment and adjust if you have the 2.2K option panel):
      outputs."eDP-1" = {
        # mode.width = 2240;
        # mode.height = 1400;
        scale = 1;
      };
    };
  };
}
