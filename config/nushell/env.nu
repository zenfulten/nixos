use std "path add"

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join ".sdk" "go" "bin")

path add ($env.HOME | path join "tools" "bin")

path add ($env.HOME | path join ".local" "bin")

zoxide init nushell | save -f ~/.zoxide.nu
