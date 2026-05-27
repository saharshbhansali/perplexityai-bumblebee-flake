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
    sha256 = "sha256-gmB+j1rmnOqHjV2N4hqH2QDolAZ3Za7ztioskZ/FkOQ=";
  };

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=v${version}"
  ];

  doInstallCheck = true;

  installCheckPhase = ''
    runHook preInstallCheck

    $out/bin/bumblebee selftest

    runHook postInstallCheck
  '';

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
