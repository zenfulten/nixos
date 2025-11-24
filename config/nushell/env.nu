use std "path add"

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join ".sdk" "go" "bin")

path add ($env.HOME | path join "tools" "bin")

path add ($env.HOME | path join ".local" "bin")


# rust path 
path add ($env.HOME | path join ".sdk" "rust-nightly" "cargo" "bin")

path add ($env.HOME | path join ".sdk" "rust-nightly" "clippy-preview" "bin")

path add ($env.HOME | path join ".sdk" "rust-nightly" "rust-analyzer-preview" "bin")

path add ($env.HOME | path join ".sdk" "rust-nightly" "rustc" "bin")

$env.LD_LIBRARY_PATH = ($env.HOME | path join ".sdk" "rust-nightly" "rustc" "lib")

path add ($env.HOME | path join ".sdk" "rust-nightly" "rustfmt-preview" "bin")


zoxide init nushell | save -f ~/.zoxide.nu
