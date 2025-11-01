{
  inputs,
  outputs,
  vars,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/darwin/base.nix
    ../../style/stylix/macnix
  ];

  users.users.${vars.userName} = {
    home = /Users/${vars.userName};
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${vars.userName} = {
        imports = [
          ../../modules/home-manager/darwin.nix
          ../../style/stylix/macnix
        ];
      };
    };
  };
  networking = {
    hostName = "macnix";
    computerName = "macnix";
    localHostName = "macnix";
  };
  system.stateVersion = 6;
}
