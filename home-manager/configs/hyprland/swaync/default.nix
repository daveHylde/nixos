{pkgs, ...}:

{
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 400;
      notification-window-height = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "title"
        "dnd"
        "notifications"
        "volume"
        "mpris"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        volume = {
          show-per-app = true;
          label = "Volume";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };
    style = ''
      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      .floating-notifications.background {
        background-color: rgba(46, 52, 64, 0.9);
        border-radius: 12px;
        border: 2px solid rgba(76, 86, 106, 0.8);
        margin: 10px;
        max-height: 70vh;
      }

      .floating-notifications .notification {
        background-color: rgba(59, 66, 82, 0.8);
        border-radius: 12px;
        padding: 10px;
        margin: 10px;
        border: 2px solid rgba(76, 86, 106, 0.6);
      }

      .floating-notifications .notification.critical {
        border: 2px solid rgba(191, 97, 106, 0.9);
      }

      .notification-action-button {
        background-color: rgba(67, 76, 94, 0.8);
        border-radius: 8px;
        padding: 5px 10px;
        margin: 5px;
        border: 1px solid rgba(76, 86, 106, 0.6);
      }

      .notification-action-button:hover {
        background-color: rgba(76, 86, 106, 0.8);
      }

      .control-center {
        background-color: rgba(46, 52, 64, 0.9);
        border-radius: 12px;
        border: 2px solid rgba(76, 86, 106, 0.8);
        max-height: 80vh;
      }

      .control-center .notification {
        background-color: rgba(67, 76, 94, 0.8);
        border-radius: 10px;
        padding: 10px;
        margin: 10px;
        border: 1px solid rgba(76, 86, 106, 0.6);
      }

      .control-center .notification.critical {
        border: 1px solid rgba(191, 97, 106, 0.9);
      }

      .notification-content {
        padding: 5px;
      }

      .notification-default-action {
        padding: 5px;
      }

      .notification-default-action:hover {
        background-color: rgba(76, 86, 106, 0.7);
        border-radius: 8px;
      }

      .close-button {
        background-color: rgba(191, 97, 106, 0.8);
        color: rgba(236, 239, 244, 1);
        padding: 2px 5px;
        border-radius: 5px;
      }

      .close-button:hover {
        background-color: rgba(191, 97, 106, 1);
      }

      .notification .body-image {
        margin-top: 10px;
        border-radius: 8px;
        background-size: cover;
        background-position: center;
      }

      .title {
        font-weight: bold;
        font-size: 16px;
        color: rgba(236, 239, 244, 1);
      }

      .widget-title {
        margin: 10px;
        font-size: 18px;
        font-weight: bold;
        color: rgba(236, 239, 244, 1);
      }

      .widget-dnd {
        margin: 10px;
        padding: 5px 10px;
        border-radius: 8px;
        background-color: rgba(67, 76, 94, 0.8);
        color: rgba(236, 239, 244, 1);
      }

      .widget-dnd.active {
        background-color: rgba(191, 97, 106, 0.8);
        color: rgba(236, 239, 244, 1);
      }

      .widget-volume {
        margin: 10px;
      }

      .volume-slider {
        background-color: rgba(67, 76, 94, 0.8);
        border-radius: 8px;
      }

      .volume-slider trough {
        background-color: rgba(67, 76, 94, 0.8);
        border-radius: 8px;
        min-height: 10px;
      }

      .volume-slider highlight {
        background-color: rgba(94, 129, 172, 0.8);
        border-radius: 8px;
      }

      .widget-mpris {
        margin: 10px;
        padding: 10px;
        background-color: rgba(67, 76, 94, 0.8);
        border-radius: 12px;
      }

      .widget-mpris-player {
        padding: 5px;
      }

      .widget-mpris-title {
        font-weight: bold;
        font-size: 15px;
        color: rgba(236, 239, 244, 1);
      }

      .widget-mpris-subtitle {
        font-size: 13px;
        color: rgba(216, 222, 233, 1);
      }
    '';
  };
}

