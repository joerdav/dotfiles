{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema # Terminal Recording
    aws-vault # AWS Profile Manager
    bitwarden-cli
    buf # Protobuf Framework
    capnproto # Protobuf Framework
    ccls # c Language Server
    clang-tools # clang tools, installed for formatter
    delta # syntax-highlighted git diff
    discord # Discord desktop app
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
    gnupg # PGP Implementation
    gomodifytags # Refactor tool
    google-cloud-sdk # GCP CLI
    gopls # Go Language Server
    goreleaser # Go Release Framework
    gotools # Common Go Tools
    gofumpt # Stricter Go Formatter
    graphviz # Code defined graphs
    gv # PDF Viewer
    html-tidy # HTML Formatter
    htop # Advanced top command
    jq # JSON Query
    lua # Lua runtime
    luarocks # Lua package managers
    ngrok # Temporarily host a port
    nix-prefetch # Get hashes of nix packages easily
    nixpkgs-fmt # Nix Formatter
    nmap # nmap command
    nodePackages.node2nix # Node 2 Nix
    nodePackages.prettier # TS Formatter
    nodePackages.typescript # TS Compiler
    nodejs-14_x # Node runtime
    oh-my-zsh # ZSH Wrapper
    (pass.withExtensions (ext: with ext; [
      pass-import
    ])) # Wallet interface
    protobuf # Protobuf CLI
    ripgrep # Multithreaded file search
    rust-analyzer # Rust Language Server
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
    yarn # Node package manager
    zip # zup commpressed files
  ];
}
