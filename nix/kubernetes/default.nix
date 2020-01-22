{ callPackage }:
{
  packages = {
    "1.11.5" = callPackage ./1_11.nix {
      version = "1.11.5";
      sha256 = "0ifncv46l62sx213fxkn9xkh87hysshigp829jz9ncv9k3j5jcnj";
    };
    "1.14.3" = callPackage ./1_14.nix {
      version = "1.14.3";
      sha256 = "1r31ssf8bdbz8fdsprhkc34jqhz5rcs3ixlf0mbjcbq0xr7y651z";
    };
    "1.14" = callPackage ./1_14.nix {
      version = "1.14.3";
      sha256 = "1r31ssf8bdbz8fdsprhkc34jqhz5rcs3ixlf0mbjcbq0xr7y651z";
    };
  };
}
