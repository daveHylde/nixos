{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.s3fs;
in

{
  options.services.s3fs = {
    enable = mkEnableOption "s3fs mount service";

    bucket = mkOption {
      type = types.str;
      default = "mounted";
      description = "S3 bucket name to mount";
    };

    mountPath = mkOption {
      type = types.str;
      default = "/home/david/s3";
      description = "Local path where the S3 bucket will be mounted";
    };

    url = mkOption {
      type = types.str;
      default = "https://se-sto-1.linodeobjects.com/";
      description = "S3 service URL";
    };

    keyFile = mkOption {
      type = types.str;
      default = "/etc/passwd-s3fs";
      description = "Path to the file containing ACCESS_KEY:SECRET_KEY";
    };

    extraOptions = mkOption {
      type = types.listOf types.str;
      default = [
        "use_cache=/tmp/s3fs"
        "uid=1000"
        "gid=100"
        "umask=0002"
        "allow_other"
        "use_path_request_style"
      ];
      description = "Additional options for s3fs";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.s3fs ];

    system.fsPackages = [ pkgs.s3fs ];

    systemd.services.s3fs = {
      description = "S3FS mount service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "forking";
        User = "root";
        Group = "root";
        ExecStartPre = [
          "${pkgs.coreutils}/bin/mkdir -p ${cfg.mountPath}"
          "${pkgs.coreutils}/bin/mkdir -p /tmp/s3fs"
          "${pkgs.coreutils}/bin/chown 1000:100 ${cfg.mountPath}"
          "${pkgs.coreutils}/bin/chmod 600 ${cfg.keyFile}"
        ];
        ExecStart = "${pkgs.s3fs}/bin/s3fs ${cfg.bucket} ${cfg.mountPath} -o passwd_file=${cfg.keyFile} -o url=${cfg.url} -o ${concatStringsSep "," cfg.extraOptions}";
        ExecStop = "${pkgs.util-linux}/bin/umount ${cfg.mountPath}";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };

    # Ensure the mount directory exists
    systemd.tmpfiles.rules = [
      "d ${cfg.mountPath} 0755 1000 100 -"
      "d /tmp/s3fs 0755 root root -"
    ];
  };
}
