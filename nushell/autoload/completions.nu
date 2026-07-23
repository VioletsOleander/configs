use completions/git.nu *
use completions/cargo.nu *
use completions/rustup.nu *
use completions/uv.nu *
use completions/rg.nu *
use completions/eza.nu *
use completions/vivid.nu *
use completions/dprint.nu *
use completions/gh.nu *
use completions/curl.nu *
use completions/fd.nu *
use completions/git-cliff.nu *

# Optional imports
const scoop = if $nu.os-info.name == 'windows' { 'completions/scoop.nu' } else { null }
const wsl = if $nu.os-info.name == 'windows' { 'completions/wsl.nu' } else { null }
const systemctl = if $nu.os-info.name == 'linux' { 'completions/systemctl.nu' } else { null }
use $scoop *
use $wsl *
use $systemctl *
