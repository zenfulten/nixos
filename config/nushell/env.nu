use std "path add"

path add ($env.HOME | path join ".sdk" "dart" "bin")

path add ($env.HOME | path join ".sdk" "go" "bin")

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join "tools" "duf" "bin")

path add ($env.HOME | path join "tools" "nerdfetch" "bin")

path add ($env.HOME | path join "tools" "dysk" "bin")

path add ($env.HOME | path join "tools" "opencode" "bin")

path add ($env.HOME | path join "tools" "superfile")

zoxide init nushell | save -f ~/.zoxide.nu
