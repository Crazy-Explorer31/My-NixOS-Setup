{
  pkgs,
  username,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "render"
        "docker"
      ];

      # define user packages here
      packages = with pkgs; [
        tree
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [zsh];
  environment.systemPackages = with pkgs; [lsd fzf];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster";
      };

      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

        prompt_context() {
          if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        	prompt_segment black blue "%B%n@%m%b"
          fi
        }
        export AGNOSTER_GIT_DIRTY_BG=222

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s;

        # Set-up icons for files/directories in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        alias hello='echo "Hello, World!"'
        alias nrs='sudo nixos-rebuild switch --flake .'
        alias hs='home-manager switch --flake .#stepan'
        alias nr='niri validate'

        # Функция для поиска с fzf и ripgrep
        fzf-rg-search() {
            /home/stepan/my-NixOS/UserScripts/SearchWithFzfRipgrep.sh
        }

        # Создаем виджет Zsh
        fzf-rg-widget() {
            # Сохраняем текущий буфер командной строки
            LBUFFER=""
            BUFFER=""

            # Вызываем поиск
            fzf-rg-search "$query"

            # Восстанавливаем состояние командной строки
            zle reset-prompt
            zle redisplay
        }

        # Регистрируем виджет
        zle -N fzf-rg-widget

        # Привязываем Ctrl+U
        bindkey '^U' fzf-rg-widget

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
      '';
    };
  };
}
