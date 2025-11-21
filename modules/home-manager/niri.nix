{ config, pkgs, inputs,... }:

{

  imports = [
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  services.tuned.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  services.gnome-keyring.enable = true;

  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.x86_64-linux.quickshell;

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableClipboard = true;            # Clipboard history manager
    enableVPN = true;                  # VPN management widget
    enableBrightnessControl = true;    # Backlight/brightness controls
    enableColorPicker = true;          # Color picker tool
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableSystemSound = true;          # System sound effects

    niri = {
      enableSpawn = true;      # Auto-start DMS with niri
      enableKeybinds = true;
    };
  };

  programs.niri.settings = with config.lib.niri.actions; {
    prefer-no-csd = true;
    input = {
      keyboard = {
        repeat-rate = 35;
        repeat-delay = 300;
        numlock = true;
        xkb = {
          layout = "us,ru";
          options = "grp:alt_space_toggle,compose:ralt,ctrl:nocaps";
        };
        # track-layout left at default "global"
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
        # other touchpad options omitted (use defaults)
      };

      mouse = {
        accel-profile = "flat";
        # accel-speed left null
      };

      # focus-follows-mouse: enable with max-scroll-amount "0%"
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    layout = {
      gaps = 8;

      focus-ring = {
        width = 2;
        active.color = "white";
      };
      default-column-width.proportion = 0.5;
    };

    environment = {
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
    };

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 10.0;
          top-right = 10.0;
          bottom-left = 10.0;
          bottom-right = 10.0;
        };
        clip-to-geometry = true;
        tiled-state = true;
        draw-border-with-background = false;
      }
    ];

    layer-rules = [
      {
        matches = [
          { namespace = "^dms:blurwallpaper$"; }
        ];
        place-within-backdrop = true;
      }
    ];

    binds = {
      # Hotkey help
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      # Suggested program binds
      "Mod+E".action = spawn "nautilus";
      "Mod+B".action = spawn "brave";
      "Mod+Return".action = spawn "alacritty";
      "Super+Alt+S".action = spawn-sh "pkill orca || exec orca";

      # Overview
      "Mod+O".action = toggle-overview;

      # Close
      "Mod+Q".action = close-window;

      # Movement (focus)
      "Mod+Left".action  = focus-column-left;
      "Mod+Down".action  = focus-window-down;
      "Mod+Up".action    = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action     = focus-column-left;
      "Mod+J".action     = focus-window-down;
      "Mod+K".action     = focus-window-up;
      "Mod+L".action     = focus-column-right;

      # Movement (move)
      "Mod+Ctrl+Left".action  = move-column-left;
      "Mod+Ctrl+Down".action  = move-window-down;
      "Mod+Ctrl+Up".action    = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action     = move-column-left;
      "Mod+Ctrl+J".action     = move-window-down;
      "Mod+Ctrl+K".action     = move-window-up;
      "Mod+Ctrl+L".action     = move-column-right;

      # First / last / move to first / last
      "Mod+Home".action = focus-column-first;
      "Mod+End".action  = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action  = move-column-to-last;

      # Monitor focus / move
      "Mod+Shift+Left".action  = focus-monitor-left;
      "Mod+Shift+Down".action  = focus-monitor-down;
      "Mod+Shift+Up".action    = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+H".action  = focus-monitor-left;
      "Mod+Shift+J".action  = focus-monitor-down;
      "Mod+Shift+K".action    = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+Left".action  = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action  = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action    = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+H".action  = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action  = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action    = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      # Page / workspace navigation
      "Mod+Page_Down".action      = focus-workspace-down;
      "Mod+Page_Up".action        = focus-workspace-up;
      "Mod+U".action              = focus-workspace-down;
      "Mod+I".action              = focus-workspace-up;

      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action   = move-column-to-workspace-up;
      "Mod+Ctrl+U".action         = move-column-to-workspace-down;
      "Mod+Ctrl+I".action         = move-column-to-workspace-up;

      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action   = move-workspace-up;
      "Mod+Shift+U".action         = move-workspace-down;
      "Mod+Shift+I".action         = move-workspace-up;

      # Wheel ticks (these are normal actions; omitted per-bind cooldown attributes)
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".action   = focus-workspace-up;
      "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
      "Mod+Ctrl+WheelScrollUp".action   = move-column-to-workspace-up;

      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action  = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action  = move-column-left;

      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action   = focus-column-left;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
      "Mod+Ctrl+Shift+WheelScrollUp".action   = move-column-left;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Focus previous workspace
      "Mod+Tab".action = focus-workspace-previous;

      # Consume / expel windows
      "Mod+BracketLeft".action  = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+Period".action = expel-window-from-column;

      # Resize & layout controls
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+C".action = center-column;
      "Mod+Ctrl+C".action = center-visible-columns;

      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      "Mod+W".action = toggle-column-tabbed-display;

      "Print".action.screenshot-screen = [ ];
      "Ctrl+Print".action.screenshot = [ ];
      "Alt+Print".action.screenshot-window = [ ];

      # Inhibitor toggle
      "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

      # Quit / confirm / power
      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;

      "Mod+Shift+P".action = power-off-monitors;

    };
  };

#   xdg.portal = {
#     enable = true;
#     config = {
#       common = {
#         default = ["gnome"];
#       };
#     };
#     xdgOpenUsePortal = true;
#     extraPortals = with pkgs; [
#       xdg-desktop-portal
#       xdg-desktop-portal-gtk
#       xdg-desktop-portal-gnome
#     ];
#   };

#   home.packages = with pkgs;[
#     peaclock
#     cava
#     neovim
#     swaybg
#     nwg-look
#     sbctl
#     kdePackages.kate
#     brave
#     alacritty
#     vesktop
#     telegram-desktop
#     fastfetch
#     #obsidian
#     vscode
#     libreoffice-fresh
#     cmatrix
#     mangohud
#     prismlauncher
#     cava
#     xwayland-satellite
#     nautilus
#     mint-y-icons
#     obs-studio
#     kdePackages.breeze
#     adw-gtk3
#     letterpress
#     loupe
#     blanket
#     kdePackages.qt6ct
#     papers
#     osu-lazer-bin
#     protonvpn-gui
#     onlyoffice-desktopeditors
#     pavucontrol
#   ];
}
