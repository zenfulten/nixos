use std "path add"

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join ".sdk")

path add ($env.HOME | path join "mem" "sdk" "go" "bin")

path add ($env.HOME | path join "mem" "tools" "bin")

path add ($env.HOME | path join "mem" "sdk" "dart-sdk" "bin")

path add ($env.HOME | path join ".local" "bin")


# rust path 
path add ($env.HOME | path join "mem" "sdk" "rust-nightly" "cargo" "bin")

path add ($env.HOME | path join  "mem" "sdk" "rust-nightly" "clippy-preview" "bin")

path add ($env.HOME | path join "mem" "sdk" "rust-nightly" "rust-analyzer-preview" "bin")

path add ($env.HOME | path join "mem" "sdk" "rust-nightly" "rustc" "bin")

$env.LD_LIBRARY_PATH = ($env.HOME | path join "mem" "sdk" "rust-nightly" "rustc" "lib")

path add ($env.HOME | path join "mem" "sdk" "rust-nightly" "rustfmt-preview" "bin")


zoxide init nushell | save -f ~/.zoxide.nu
