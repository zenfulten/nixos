use std "path add"

path add ($env.HOME | path join ".sdk" "dart" "bin")

path add ($env.HOME | path join ".sdk" "go" "bin")

path add ($env.HOME | path join "tools" "duf" "bin")

path add ($env.HOME | path join "tools" "nerdfetch" "bin")

path add ($env.HOME | path join "tools" "dysk" "bin")

zoxide init nushell | save -f ~/.zoxide.nu
