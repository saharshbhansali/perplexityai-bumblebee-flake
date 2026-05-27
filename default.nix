{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "bumblebee";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "perplexityai";
    repo = "bumblebee";
    rev = "v${version}";
    sha256 = lib.fakeSha256;
  };

  # vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  vendorHash = null;

  subPackages = [ "cmd/bumblebee" ];

  meta = with lib; {
    description = "PerplexityAI Bumblebee";
    homepage = "https://github.com/perplexityai/bumblebee";
    license = licenses.asl20;
    maintainers = [ ];
    mainProgram = "bumblebee";
  };
}
