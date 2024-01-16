{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bennett";
  home.homeDirectory = "/home/bennett";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    ".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
    ".config/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;

    # dunst
    ".config/dunst/dunstrc" = {
      source = ./config/dunst/dunstrc;
      executable = true;
    };
    ".config/dunst/alert" = {
      source = ./config/dunst/alert;
      executable = true;
    };
    ".config/dunst/notification.wav".source = ./config/dunst/notification.wav;

    ".config/waypaper/config.ini".source = ./config/waypaper/config.ini;

    ".config/wofi/style.css".source = ./config/wofi/style.css;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bennett/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "robbyrussell";
    initExtra = "cd ~\npfetch";
    shellAliases = {
      ll = "ls -l";
      pf = "pfetch";
    };
    loginExtra = "#!/bin/bash\n\nif [ \"$(tty)\" = \"/dev/tty1\" ];then\nexec Hyprland\nfi";
  };

  programs.wofi = {
    enable = true;
    settings = {
      mode = "drun";
      hide_scroll = true;
      width = "25%";
      height = "50%";
      location = "center";
    };
  };

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./config/eww;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 10;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
