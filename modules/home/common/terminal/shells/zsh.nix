{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    zsh-shell.enable = lib.mkEnableOption "zsh config";
  };
  config = lib.mkIf config.zsh-shell.enable {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        nixdiff = "nix run nixpkgs#nvd -- diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
      };
      defaultKeymap = "emacs";
      initContent = lib.mkIf pkgs.stdenv.isLinux ''
        if [[ $(wezterm cli list | wc -l) -eq 2 ]]; then
          date
          ${lib.getExe pkgs.microfetch}
        fi
      '';
    };
  };
}
