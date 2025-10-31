{
  inputs,
  outputs,
  vars,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager

    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${vars.userName} = {
        imports = [
          ../../modules/home-manager/darwin.nix
        ];
      };
    };
  };
  networking = {
    hostName = "macnix";
    computerName = "macnix";
    localHostName = "macnix";
  };
}
