{ pkgs, globalBuildInputs ? [], ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema # Terminal Recording
    act
    aws-vault # AWS Profile Manager
    bitwarden-cli
    buf # Protobuf Framework
    capnproto # Protobuf Framework
    ccls # c Language Server
    clang-tools # clang tools, installed for formatter
    cmake
    cmake-language-server
    delta # syntax-highlighted git diff
    discord # Discord desktop app
    direnv
    docker
    docker-machine
    entr # File watcher
    exercism # Code Kata cli
    ffmpeg # Video Encoder
    fzf # Fuzzy Filter
    gdb # Debugger
    gh # Github CLI
    git # Source Control
    gitAndTools.gh # Github CLI
    git-bug
    glfw
    gnupg # PGP Implementation
    gomodifytags # Refactor tool
    google-cloud-sdk # GCP CLI
    gopls # Go Language Server
    goreleaser # Go Release Framework
    gotools # Common Go Tools
    gofumpt # Stricter Go Formatter
    graphviz # Code defined graphs
    gradle
    gv # PDF Viewer
    html-tidy # HTML Formatter
    htop # Advanced top command
    jq # JSON Query
    lua # Lua runtime
    luarocks # Lua package managers
    mdcat
    minikube
    kubectl
    ngrok # Temporarily host a port
    nix-prefetch # Get hashes of nix packages easily
    nixpkgs-fmt # Nix Formatter
    nodejs_20
    nmap # nmap command
    oh-my-zsh # ZSH Wrapper
    (pass.withExtensions (ext: with ext; [
      pass-import
    ])) # Wallet interface
    protobuf # Protobuf CLI
    qrencode
    ripgrep # Multithreaded file search
    rustup # Rust Installer
    silver-searcher # AG Multithreaded file search
    ssm-session-manager-plugin # AWS SSM CLI
    stylua # Lua Formatter
    tmate # Tmux session sharer
    tmux # Terminal Multiplexer
    tree # Show a tree of files
    unzip # unzip compressed files
    upterm # Terminal session sharer
    wezterm # Terminal Emulator
    wget # wget command
    wrk # Load tester
    #yarn # Node package manager
    zip # zup commpressed files
  ];
}
