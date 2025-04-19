{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [ 
        pkgs.neovim
        pkgs.vim
        pkgs.alacritty
        pkgs.mkalias
        pkgs.git
        pkgs.zulu17
        pkgs.asdf
        pkgs.zsh-autosuggestions
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
          "stow"
          "tree"
        ];
        casks = [
          "1password"
          "appcleaner"
          "folx"
          "iina"
          "maccy"
          "textsniper"
          "aldente"
          "arc"
          "iterm2"
          "postman"
          "visual-studio-code"
          "alfred"
          "bartender"
          "google-chrome"
          "spotify"
          "intellij-idea"
        ];
        masApps = {
          "WhatsApp" = 310633997;
          "Bandwidth+" = 490461369;
          "1Password for Safari" = 1569813296;
          "Keka" = 470158793;
          "Dropover" = 1355679052;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ];})
      ];
      
      system.activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      system.defaults = {
        dock.autohide = true;
        dock.largesize = 90;
        dock.autohide-delay = 0.0;
        dock.persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/Spotify.app"
          "/Applications/IntelliJ IDEA.app"
          "/System/Applications/System Settings.app"
          "/System/Applications/App Store.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        finder.AppleShowAllExtensions = true;
        finder._FXShowPosixPathInTitle = true;
        finder.AppleShowAllFiles = true;
        NSGlobalDomain.AppleShowAllExtensions = true;
      };

      programs.zsh = {
        enable = true;
      };

      security.pam.enableSudoTouchIdAuth = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
        modules = [ 
          configuration 
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "asishkumar";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
    };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
