{...}: {
  home.shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "/" = "cd /";
    sudo = "sudo ";
    v = "nvim";
    yy = "yazi";
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    lg = "lazygit";
  };
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
  };
}
