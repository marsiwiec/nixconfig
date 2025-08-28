{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    emacs.enable = lib.mkEnableOption "enable emacs editor";
  };
  config = lib.mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs: [
        epkgs.mu4e
      ];
    };
    home.file.".emacs.d/themes/doom-stylix-theme.el".source = config.lib.stylix.colors {
      template = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
      extension = ".el";
    };

    home.packages = with pkgs; [
      gnumake
      coreutils
      clang
      ripgrep
      fd
      pandoc
      shellcheck
      ispell
      cmake
      libtool
      nodejs
      sqlite

      mu

      pinentry-curses

      imagemagick
      maim
      graphviz
    ];
    services = {
      emacs.enable = true;
      # mbsync = {
      #   preExec = "mkdir -p ~/Maildir";
      #   enable = true;
      #   postExec = "${pkgs.mu}/bin/mu index";
      # };
    };
    programs.zsh.initContent = ''
      export PATH="$HOME/.emacs.d/bin:$PATH"
    '';
    programs = {
      msmtp.enable = true;
      mbsync = {
        enable = true;
        extraConfig = ''
          # First section: remote IMAP account
          IMAPAccount fastmail
          Host imap.fastmail.com
          Port 993
          UserCmd "pass mail/fastmail/login"
          PassCmd "pass mail/fastmail/password"
          TLSType IMAPS
          TLSVersions +1.2

          IMAPStore fastmail-remote
          Account fastmail

          # This section describes the local storage
          MaildirStore fastmail-local
          Path ~/Maildir/
          Inbox ~/Maildir/INBOX
          # The SubFolders option allows to represent all
          # IMAP subfolders as local subfolders
          SubFolders Verbatim

          # This section a "channel", a connection between remote and local
          Channel fastmail
          Far :fastmail-remote:
          Near :fastmail-local:
          Patterns *
          Expunge None
          CopyArrivalDate yes
          Sync All
          Create Near
          SyncState *
        '';
      };
      password-store.enable = true;
    };
  };
}
