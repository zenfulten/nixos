use std "path add"

path add ($env.HOME | path join ".sdk" "dart" "bin")

path add ($env.HOME | path join "tools" "duf" "bin")

zoxide init nushell | save -f ~/.zoxide.nu
