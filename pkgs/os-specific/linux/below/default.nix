{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, clang
, pkgconfig
, elfutils
, rustfmt
, zlib
}:

rustPlatform.buildRustPackage rec {
  pname = "below";
  version = "0.6.3";

  src = fetchFromGitHub {
    owner = "facebookincubator";
    repo = "below";
    rev = "v${version}";
    sha256 = "sha256-d5a/M2XEw2E2iydopzedqZ/XfQU7KQyTC5NrPTeeNLg=";
  };

  cargoSha256 = "sha256-EoRCmEe9SAySZCm+QhaR4ngik4Arnm4SZjgDM5fSRmk=";

  # bpf code compilation
  hardeningDisable = [ "stackprotector" ];

  nativeBuildInputs = [ clang pkgconfig rustfmt ];
  buildInputs = [ elfutils zlib ];

  # needs /sys/fs/cgroup
  doCheck = false;

  meta = with lib; {
    platforms = platforms.linux;
    maintainers = with maintainers; [ globin ];
    description = "A time traveling resource monitor for modern Linux systems";
    license = licenses.asl20;
    homepage = "https://github.com/facebookincubator/below";
  };
}
