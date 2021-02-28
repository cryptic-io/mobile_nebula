{ pkgs }:
    pkgs.buildGoModule {
        pname = "gomobile";
        version = "unstable-2020-12-17";
        src = pkgs.fetchFromGitHub {
            owner = "golang";
            repo = "mobile";
            rev = "e6ae53a27f4fd7cfa2943f2ae47b96cba8eb01c9";
            sha256 = "03dzis3xkj0abcm4k95w2zd4l9ygn0rhkj56bzxbcpwa7idqhd62";
        };
        vendorSha256 = "1n1338vqkc1n8cy94501n7jn3qbr28q9d9zxnq2b4rxsqjfc9l94";

        CGO_CFLAGS = [
            "-I ${pkgs.libglvnd.dev}/include"
                "-I ${pkgs.xlibs.libX11.dev}/include"
                "-I ${pkgs.xlibs.xorgproto}/include"
                "-I ${pkgs.openal}/include"
        ];

        CGO_LDFLAGS = [
            "-L ${pkgs.libglvnd}/lib"
                "-L ${pkgs.xlibs.libX11}/lib"
                "-L ${pkgs.openal}/lib"
        ];

        checkPhase = "";
    }
