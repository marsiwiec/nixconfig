{
  # ThinkPad T14 Gen3 speaker tuning (host-specific): the Realtek ALC257
  # speakers are thin and quiet by default. A convolver + impulse response
  # gives them real body. Host-specific because the EQ fits one device only;
  # labnix/nixgroot get no EasyEffects.
  flake.modules.homeManager.nixpad-audio =
    let
      # Pinned EasyEffects speaker preset + impulse response (convolver).
      # Stored in the repo so the exact speaker tuning survives wipes of
      # ~/.config / ~/.local/share and is reproducible across rebuilds.
      assets = ../../../assets/easyeffects;
    in
    {
      # Auto-loads the pinned "nixpad-speakers" preset at login; the GUI
      # (`easyeffects`) can tweak it live, but this file is the source of truth.
      services.easyeffects = {
        enable = true;
        preset = "nixpad-speakers";
      };

      xdg.configFile."easyeffects/output/nixpad-speakers.json".source =
        "${assets}/nixpad-speakers.json";
      xdg.dataFile."easyeffects/irs/impulse-dynamic.irs".source =
        "${assets}/impulse-dynamic.irs";
    };
}
