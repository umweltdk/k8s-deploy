{ callPackage }:
{
  packages = {
    "1.11.5" = callPackage ./1_11.nix {
      version = "1.11.5";
      sha256 = "0ifncv46l62sx213fxkn9xkh87hysshigp829jz9ncv9k3j5jcnj";
    };
    "1.11.6" = callPackage ./1_11.nix {
      version = "1.11.6";
      sha256 = "0p4kh056m84gyh05zia38aa4fqqad78ark2cycbi3nb60jj1nl9a";
    };
    "1.12.0" = callPackage ./1_11.nix {
      version = "1.12.0";
      sha256 = "0bnfhrli9xqf7ygfq5i5p6nsgv7ic57b5b705zbqsxrc24pvsy4s";
    };
    "1.12.1" = callPackage ./1_11.nix{
      version = "1.12.1";
      sha256 = "1gm0v5p008w9i4k94ddjdyfqfsbx7a6ngmh81p155599hifm32zc";
    };
    "1.12.2" = callPackage ./1_11.nix {
      version = "1.12.2";
      sha256 = "14w77yw8pd2y5d764byh31vv9203y38zlvcr1a9wylrs00kgzwfw";
    };
    "1.12.3" = callPackage ./1_11.nix {
      version = "1.12.3";
      sha256 = "0y227qzv7hsibf0sil5ylfdvkfsd43qlsyprc1dwgbj8igjl6q2d";
    };
    "1.13.1" = callPackage ./1_13.nix {
      version = "1.13.1";
      sha256 = "048ckirz7v1djari6l9ddkcd9i4yafcv57wk131dv0cs2zady9va";
    };
    "1.13.2" = callPackage ./1_13.nix {
      version = "1.13.2";
      sha256 = "1j5yyzn3c481ba6bbyx6gsa41zhg3x35sdbajlnxmbnid0g21g8g";
    };
    "1.13.3" = callPackage ./1_13.nix {
      version = "1.13.3";
      sha256 = "1fcp27c501ql4v7fl7rl5qyjlw1awk139rwwm0jqdpgh3sd22l2z";
    };
    "1.13.4" = callPackage ./1_13.nix {
      version = "1.13.4";
      sha256 = "1q3dc416fr9nzy64pl7rydahygnird0vpk9yflssw7v9gx84m6x9";
    };
  };
}
