{
  flake.modules.nixos.protonvpn =
    { pkgs, ... }:
    {
      networking.firewall.checkReversePath = "loose";
      environment.systemPackages = with pkgs; [
        proton-vpn
        proton-vpn-cli
        iproute2
      ];
    };
}
