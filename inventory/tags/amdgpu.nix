{
  pkgs,
  ...
}:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # ROCm packages for compute
        rocmPackages.clr.icd
        rocmPackages.rocm-runtime
        rocmPackages.rocm-device-libs
        rocmPackages.rocm-smi

        # Vulkan packages for graphics and compute
        vulkan-loader # Vulkan loader
        vulkan-validation-layers # Vulkan validation
        vulkan-extension-layer # Vulkan extensions

        # Mesa Vulkan driver (RADV) - alternative to AMDVLK
        mesa # Includes RADV Vulkan driver

        # Additional Vulkan tools
        vulkan-tools # vulkaninfo, vkcube, etc.
        vulkan-headers # Development headers
      ];
      extraPackages32 = with pkgs; [
        # driversi686Linux.amdvlk
        driversi686Linux.mesa
      ];
    };

    # AMD GPU specific settings
    amdgpu = {
      # amdvlk = {
      #   enable = true;
      #   support32Bit.enable = true;
      #   # Enable both AMDVLK and RADV for maximum compatibility
      #   settings = {
      #     # Allow both drivers to coexist (1 = enabled)
      #     AllowVkDeviceSelection = "1";
      #   };
      # };
      opencl.enable = true;
    };

    # Note: hardware.vulkan doesn't exist in NixOS
    # Vulkan support is handled through hardware.graphics.extraPackages
  };

  # System packages for AMD GPU development and monitoring
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    clinfo # OpenCL device info
    radeontop # AMD GPU monitoring

    # Additional monitoring tools for AI workloads
    nvtopPackages.amd # AMD GPU monitoring (nvtop with AMD support)
    btop # System resource monitoring with GPU support

    # GPU stress testing and benchmarking
    vulkan-tools # Vulkan utilities
    vkmark # Vulkan benchmarking tool
  ];

  # Environment variables for ROCm/OpenCL/Vulkan
  environment.variables = {
    # ROCm/HIP settings
    ROC_ENABLE_PRE_VEGA = "1";
    HIP_VISIBLE_DEVICES = "0";

    # OpenCL settings
    OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";

    # Vulkan settings
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json:/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";

    # Allow both RADV and AMDVLK drivers
    AMD_VULKAN_ICD = "RADV"; # Prefer RADV for better compatibility
    VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

    # Enable Vulkan debug layers in development
    VK_INSTANCE_LAYERS = "VK_LAYER_KHRONOS_validation";
  };

  # Kernel modules for AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
}
