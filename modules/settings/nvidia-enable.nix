{ self, ... }:
{
  flake.modules.nixos.nvidia-enable =
    { config, pkgs, ... }:
    let
      bin = "/run/current-system/sw/bin";
    in
    {
      environment.systemPackages = with pkgs; [
        (writeShellScriptBin "nvidia-enable" ''
          ${bin}/virsh nodedev-reattach pci_0000_01_00_0 && \
          echo "GPU attached (now host ready)" && \
          ${bin}/rmmod vfio_pci vfio_pci_core vfio_iommu_type1 && \
          echo "VFIO drivers removed" && \
          ${bin}/modprobe -i nvidia && \
          sleep 2 && \
          ${bin}/modprobe -i nvidia_modeset && \
          sleep 2 && \
          ${bin}/modprobe -i nvidia_uvm && \
          echo "NVIDIA drivers added" && \
          echo "COMPLETED!"
        '')

        (writeShellScriptBin "nvidia-disable" ''
          sleep 5 && \
          ${bin}/rmmod nvidia_modeset nvidia_uvm nvidia && \
          echo "NVIDIA drivers removed" && \
          ${bin}/modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1 && \
          echo "VFIO drivers added" && \
          ${bin}/virsh nodedev-detach pci_0000_01_00_0 && \
          echo "GPU detached (now vfio ready)" && \
          echo "COMPLETED!"
        '')
      ];

      security.sudo = {
        extraRules = [
          {
            users = [ config.systemConstants.username ];
            commands = [
              {
                command = "${bin}/nvidia-enable";
                options = [ "NOPASSWD" ];
              }
              {
                command = "${bin}/nvidia-disable";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };

      environment.shellAliases = {
        nvidia-enable = "sudo nvidia-enable";
        nvidia-disable = "sudo nvidia-disable";
        hows-my-gpu = "echo 'NVIDIA Dedicated Graphics' | grep 'NVIDIA' && lspci -nnk | grep 'NVIDIA Corporation AD104' -A 2 | grep 'Kernel' && echo 'Enable and disable the dedicated NVIDIA GPU with nvidia-enable and nvidia-disable'";
      };

    };
}
