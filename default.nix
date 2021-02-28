{
    pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/cd63096d6d887d689543a0b97743d28995bc9bc3.tar.gz") {
        config = { android_sdk.accept_license = true; };
        overlays = [
            (import (builtins.fetchTarball {
                url = "https://github.com/paulyoung/pub2nix/archive/2c921a46c10dc72ff33005722e4c642852ff22af.tar.gz";
                sha256 = "14lcylqdmigsl7argcx1pprap6abi3znghj7469f5cif50ydw5gk";
            }))
        ];
    }
}:
    let
        androidEnv = pkgs.androidenv.composeAndroidPackages {
            includeNDK = true;
            ndkVersion = "21.0.6113669";
            buildToolsVersions = [ "29.0.2" ];
            platformVersions = [ "29" ];
            abiVersions = [ "arm64-v8a" "x86" "x86_64" ];
            cmakeVersions = [ "3.10.2" ];
        };

        ANDROID_HOME = "${androidEnv.androidsdk}/libexec/android-sdk";
        ANDROID_NDK_HOME = "${ANDROID_HOME}/ndk-bundle";
        JAVA_HOME = pkgs.jdk;

        buildInputs = [
            pkgs.rsync
            pkgs.unzip
            pkgs.flutter
            pkgs.jdk
            (import ./nix/gomobile.nix {pkgs=pkgs;})
            pkgs.go
            androidEnv.platform-tools
            androidEnv.androidsdk
            pkgs.pub2nix.lock
        ];

    in
        {
            shell = pkgs.mkShell {
                inherit ANDROID_HOME ANDROID_NDK_HOME JAVA_HOME buildInputs;
            };

            build = derivation {
                name = "mobile_nebula-apk";
                src = ./.;

                system = builtins.currentSystem;
                inherit ANDROID_HOME ANDROID_NDK_HOME JAVA_HOME buildInputs;
                flutterHome = (import ./nix/flutterHome.nix {pkgs=pkgs;});
                stdenv = pkgs.stdenv;

                builder = "${pkgs.bash}/bin/bash";
                args = [ ./nix/build.sh ];
            };
        }
