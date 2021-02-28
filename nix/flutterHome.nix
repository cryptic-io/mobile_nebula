{ pkgs }:
    let
        mkFlutterDL = ({ name, path, sha256 }: pkgs.stdenv.mkDerivation {
            name = "mobile_nebula-flutter-home-${name}";
            src = builtins.fetchurl {
                url = "https://${path}";
                inherit sha256;
            };

            inherit path;
            builder = builtins.toFile "builder.sh" ''
                source $stdenv/setup
                mkdir -p $out/.cache/flutter/downloads/$(dirname $path)
                cp $src $out/.cache/flutter/downloads/$path
            '';
        });

        toInclude = [
            (mkFlutterDL {
                name = "material_fonts";
                path = "storage.googleapis.com/flutter_infra/flutter/fonts/13ac995daa9dda0a6ba0a45f1fccc541e616a74c/fonts.zip";
                sha256 = "17e9fd737985199193f304cf2744c8239f95b8889ca459fb81e8f2d08d31ea8d";
            })

            (mkFlutterDL {
                name = "gradle_wrapper";
                path = "storage.googleapis.com/flutter_infra/gradle-wrapper/fd5c1f2c013565a3bea56ada6df9d2b8e96d56aa/gradle-wrapper.tgz";
                sha256 = "31e9428baf1a2b2f485f1110c5899f852649b33d46a2e9b07f9d17752d50190a";
            })

            (mkFlutterDL {
                name = "sky_engine";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/sky_engine.zip";
                sha256 = "9c9fe57801d7f37c6cf5b6ab99ff5c28f053d990634f99e75b49bc15129e2a95";
            })

            (mkFlutterDL {
                name = "flutter_patched_sdk";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/flutter_patched_sdk.zip";
                sha256 = "e714b56067bd1f51c8127b59f71955ce4bc41d540b1591cace9562c8784f53f2";
            })

            (mkFlutterDL {
                name = "flutter_patched_sdk_product";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/flutter_patched_sdk_product.zip";
                sha256 = "c87ec7762eb373f67ca1ea2a649cc218c02c05e4741e5ab8314697bfc2525058";
            })

            (mkFlutterDL {
                name = "linux-x64_artifacts";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/linux-x64/artifacts.zip";
                sha256 = "b0be96b5f3973d140bf9d3539da533cbd1cc41fd81d20dd183e4b8f9a6c35a51";
            })

            (mkFlutterDL {
                name = "linux-x64_font-subset";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/linux-x64/font-subset.zip";
                sha256 = "50dbc60c970f505d7fc78d562110720a36e9bcb446babe7391a219e94b28ed98";
            })

            (mkFlutterDL {
                name = "android-arm-profile_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-arm-profile/linux-x64.zip";
                sha256 = "8339d5aee413d9eb4ef526c8a5b2b4be2cf1d3448815fb27dbea1e482d1f2930";
            })

            (mkFlutterDL {
                name = "android-arm-release_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-arm-release/linux-x64.zip";
                sha256 = "00405110183b5412e3c5b4901fc52f479cf8a0b3a60ca428ff1eb39b6445da46";
            })

            (mkFlutterDL {
                name = "android-arm64-profile_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-arm64-profile/linux-x64.zip";
                sha256 = "fe529878ebdc80f7f49cc121fc0f948eff64f270eabdf59748a68c4ba1a1b89e";
            })

            (mkFlutterDL {
                name = "android-arm64-release_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-arm64-release/linux-x64.zip";
                sha256 = "4959457a1f6b2aac6035f5f7408d0b85536e35bdc9ad9436cfbb816ff8b9c743";
            })

            (mkFlutterDL {
                name = "android-x64-profile_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-x64-profile/linux-x64.zip";
                sha256 = "7b50cb4ee3efc0e5b35c5c6afd656db44f321d7cd63f0c8093d72aa443e8574d";
            })

            (mkFlutterDL {
                name = "android-x64-release_linux-x64";
                path = "storage.googleapis.com/flutter_infra/flutter/ee76268252c22f5c11e82a7b87423ca3982e51a7/android-x64-release/linux-x64.zip";
                sha256 = "4f3f7b06dc99095409617870b653148df7e9dc4ce16fe8eed5ae23914675f565";
            })
        ];

    in
        pkgs.buildEnv {
            name = "mobile_nebula-flutter-home";
            paths = toInclude;
        }
