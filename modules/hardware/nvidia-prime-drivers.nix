{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia-prime;
in {
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";

    amdgpuBusId = mkOption {
      type = types.str;
      default = "PCI:5:0:0";
      description = "Bus ID of the AMD integrated GPU";
    };

    nvidiaBusId = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
      description = "Bus ID of the NVIDIA discrete GPU";
    };
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = cfg.amdgpuBusId;
        nvidiaBusId = cfg.nvidiaBusId;
      };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      nvidia-offload # для удобства
    ];
  };
}
