{pkgs, ...}:

{
  services.swaync = {
    enable = true;
		settings = {
			positionX = "center";
			positionY = "top";
			layer = "overlay";
			control-center-layer = "top";
			layer-shell = true;
			cssPriority = "application";
			control-center-margin-top = 0;
			control-center-margin-bottom = 0;
			control-center-margin-right = 0;
			control-center-margin-left = 0;
			notification-2fa-action = true;
			notification-inline-replies = true;
			notification-icon-size = 64;
			notification-body-image-width = 200;
		};
	};
}

