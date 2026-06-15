{
  flake-file.inputs = {
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
