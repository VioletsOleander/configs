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
use completions/scoop.nu *
use completions/wsl.nu *

# Seems like defining alias after the module is loaded can safely utlize the completion also for
# alias, and defining alias inside the module has no such effect.

export alias g = git
export alias co = cargo
