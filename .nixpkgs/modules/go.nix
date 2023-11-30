{ lib
, fetchurl
, tzdata
, substituteAll
, iana-etc
, Security
, Foundation
, xcbuild
, mailcap
, pkgsBuildTarget
, threadsCross
, testers
, skopeo
, buildGo121Module
, pkgs
, ...
}:

let
   useGccGoBootstrap = pkgs.stdenv.buildPlatform.isMusl;
  goBootstrap = if useGccGoBootstrap then pkgs.buildPackages.gccgo12 else pkgs.buildPackages.callPackage ./bootstrap121.nix { };

  skopeoTest = skopeo.override { buildGoModule = buildGo121Module; };

  goarch = platform: {
    "aarch64" = "arm64";
    "arm" = "arm";
    "armv5tel" = "arm";
    "armv6l" = "arm";
    "armv7l" = "arm";
    "i686" = "386";
    "mips" = "mips";
    "mips64el" = "mips64le";
    "mipsel" = "mipsle";
    "powerpc64le" = "ppc64le";
    "riscv64" = "riscv64";
    "s390x" = "s390x";
    "x86_64" = "amd64";
  }.${platform.parsed.cpu.name} or (throw "Unsupported system: ${platform.parsed.cpu.name}");

  # We need a target compiler which is still runnable at build time,
  # to handle the cross-building case where build != host == target
  targetCC = pkgsBuildTarget.targetPackages.stdenv.cc;

  isCross = pkgs.stdenv.buildPlatform != pkgs.stdenv.targetPlatform;
  go = pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "go";
  version = "1.21.4";

  src = fetchurl {
    url = "https://go.dev/dl/go${finalAttrs.version}.src.tar.gz";
    hash = "sha256-R7Jqg9K2WjwcG8rOJztpvuSaentRaKdgTe09JqN714c=";
  };

  strictDeps = true;
  buildInputs = [ ]
    ++ lib.optionals pkgs.stdenv.isLinux [ pkgs.stdenv.cc.libc.out ]
    ++ lib.optionals (pkgs.stdenv.hostPlatform.libc == "glibc") [ pkgs.stdenv.cc.libc.static ];

  depsTargetTargetPropagated = lib.optionals pkgs.stdenv.targetPlatform.isDarwin [ Foundation Security xcbuild ];

  depsBuildTarget = lib.optional isCross targetCC;

  depsTargetTarget = lib.optional pkgs.stdenv.targetPlatform.isWindows threadsCross.package;

  postPatch = ''
    patchShebangs .
  '';

  patches = [
    (substituteAll {
      src = ./iana-etc-1.17.patch;
      iana = iana-etc;
    })
    # Patch the mimetype database location which is missing on NixOS.
    # but also allow static binaries built with NixOS to run outside nix
    (substituteAll {
      src = ./mailcap-1.17.patch;
      inherit mailcap;
    })
    # prepend the nix path to the zoneinfo files but also leave the original value for static binaries
    # that run outside a nix server
    (substituteAll {
      src = ./tzdata-1.19.patch;
      inherit tzdata;
    })
    ./remove-tools-1.11.patch
    ./go_no_vendor_checks-1.21.patch
  ];

  GOOS = pkgs.stdenv.targetPlatform.parsed.kernel.name;
  GOARCH = goarch pkgs.stdenv.targetPlatform;
  # GOHOSTOS/GOHOSTARCH must match the building system, not the host system.
  # Go will nevertheless build a for host system that we will copy over in
  # the install phase.
  GOHOSTOS = pkgs.stdenv.buildPlatform.parsed.kernel.name;
  GOHOSTARCH = goarch pkgs.stdenv.buildPlatform;
 
  # {CC,CXX}_FOR_TARGET must be only set for cross compilation case as go expect those
  # to be different from CC/CXX
  CC_FOR_TARGET =
    if isCross then
      "${targetCC}/bin/${targetCC.targetPrefix}cc"
    else
      null;
  CXX_FOR_TARGET =
    if isCross then
      "${targetCC}/bin/${targetCC.targetPrefix}c++"
    else
      null;

  GOARM = toString (lib.intersectLists [ (pkgs.stdenv.hostPlatform.parsed.cpu.version or "") ] [ "5" "6" "7" ]);
  GO386 = "softfloat"; # from Arch: don't assume sse2 on i686
  CGO_ENABLED = 1;

  GOROOT_BOOTSTRAP = if useGccGoBootstrap then goBootstrap else "${goBootstrap}/share/go";

  buildPhase = ''
    runHook preBuild
    export GOCACHE=$TMPDIR/go-cache
    # this is compiled into the binary
    export GOROOT_FINAL=$out/share/go

    export PATH=$(pwd)/bin:$PATH

    ${lib.optionalString isCross ''
    # Independent from host/target, CC should produce code for the building system.
    # We only set it when cross-compiling.
    export CC=${pkgs.buildPackages.stdenv.cc}/bin/cc
    ''}
    ulimit -a

    pushd src
    ./make.bash
    popd
    runHook postBuild
  '';

  preInstall = ''
    # Contains the wrong perl shebang when cross compiling,
    # since it is not used for anything we can deleted as well.
    rm src/regexp/syntax/make_perl_groups.pl
  '' + (if (pkgs.stdenv.buildPlatform.system != pkgs.stdenv.hostPlatform.system) then ''
    mv bin/*_*/* bin
    rmdir bin/*_*
    ${lib.optionalString (!(finalAttrs.GOHOSTARCH == finalAttrs.GOARCH && finalAttrs.GOOS == finalAttrs.GOHOSTOS)) ''
      rm -rf pkg/${finalAttrs.GOHOSTOS}_${finalAttrs.GOHOSTARCH} pkg/tool/${finalAttrs.GOHOSTOS}_${finalAttrs.GOHOSTARCH}
    ''}
  '' else lib.optionalString (pkgs.stdenv.hostPlatform.system != pkgs.stdenv.targetPlatform.system) ''
    rm -rf bin/*_*
    ${lib.optionalString (!(finalAttrs.GOHOSTARCH == finalAttrs.GOARCH && finalAttrs.GOOS == finalAttrs.GOHOSTOS)) ''
      rm -rf pkg/${finalAttrs.GOOS}_${finalAttrs.GOARCH} pkg/tool/${finalAttrs.GOOS}_${finalAttrs.GOARCH}
    ''}
  '');

  installPhase = ''
    runHook preInstall
    mkdir -p $GOROOT_FINAL
    cp -a bin pkg src lib misc api doc go.env $GOROOT_FINAL
    mkdir -p $out/bin
    ln -s $GOROOT_FINAL/bin/* $out/bin
    runHook postInstall
  '';

  disallowedReferences = [ goBootstrap ];

  passthru = {
    inherit goBootstrap skopeoTest;
    tests = {
      skopeo = testers.testVersion { package = skopeoTest; };
      version = testers.testVersion {
        package = finalAttrs.finalPackage;
        command = "go version";
        version = "go${finalAttrs.version}";
      };
    };
  };

  meta = with lib; {
    changelog = "https://go.dev/doc/devel/release#go${lib.versions.majorMinor finalAttrs.version}";
    description = "The Go Programming language";
    homepage = "https://go.dev/";
    license = licenses.bsd3;
    maintainers = teams.golang.members;
    platforms = platforms.darwin ++ platforms.linux;
  };
});
in
{
  environment.systemPackages = [ go ];
}
