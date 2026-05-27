## Environment

# Editor
$env.config.buffer_editor = "nvim"

# Edit
$env.config.edit_mode = "vi"
$env.config.keybindings ++= [
  {
    name: "ctrl-[ escape"
    modifier: Control 
    keycode: Char_u00005b
    mode: [Vi_Insert]
    event: {
        send: ViChangeMode
        mode: normal # This is case senstive, see https://github.com/nushell/reedline/pull/932
    }
  },
  {
    name: "ctrl-l escape"
    modifier: Control,
    keycode: Char_l
    mode: [Vi_Insert]
    event : {
      send: ViChangeMode
      mode: normal
    }
  },
  {
    name: "ctrl-m enter"
    modifier: Control,
    keycode: Char_m
    mode: [Vi_Insert]
    event : { send: Enter }
  },
  {
    name: "ctrl-e word completion",
    modifier: Control,
    keycode: Char_e
    mode: [Vi_Insert]
    event: {
      until: [
        { send: HistoryHintWordComplete }
        { edit: MoveWordRight, select: false }
      ]
    }
  },
  {
    name: "ctrl-f line completion",
    modifier: Control,
    keycode: Char_f
    mode: [Vi_Insert]
    event: {
      until: [
        { send: HistoryHintComplete }
        { edit: MoveToLineEnd, select: false }
      ]
    }
  }
]

$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# Color
$env.config.color_config.bool = "cyan"
$env.config.color_config.shape_bool = "cyan"
$env.config.color_config.shape_external_resolved = "yellow_bold"
$env.config.color_config.shape_nothing = "cyan"
$env.config.color_config.shape_raw_string = "purple"

# $env.LS_COLORS = (vivid generate onelight-refined)
$env.LS_COLORS = (vivid generate gruvbox-light)

# Misc
$env.config.rm.always_trash = true
$env.config.show_banner = false
if $nu.os-info.name == "windows" {
  $env.YAZI_FILE_ONE = 'C:\Users\Vios\scoop\apps\git\current\usr\bin\file.exe'
}

## Source

# Nu scripts
const third_party = ($nu.default-config-dir | path join "third_party")
const nu_scripts = ($third_party | path join "nu_scripts")

# completion
const custom_completions = ($nu_scripts | path join "custom-completions")
source ($custom_completions | path join "git/git-completions.nu")
source ($custom_completions | path join "scoop/scoop-completions.nu")
source ($custom_completions | path join "uv/uv-completions.nu")
source ($custom_completions | path join "pytest/pytest-completions.nu")
source ($custom_completions | path join "cargo/cargo-completions.nu")
source ($custom_completions | path join "rustup/rustup-completions.nu")
source ($custom_completions | path join "gh/gh-completions.nu")

# color theme
const nu_themes = ($nu_scripts | path join "themes/nu-themes")

## Alias

alias la = ls -a
alias ll = ls -l

alias g = git
alias lg = lazygit
alias re = recnys
alias vn = vanillian
alias nv = nvim
alias ex = exa
alias np = npm
alias cat = bat

alias new-pr = gh pr new --title (git log -1 --format=%s) --body (git log -1 --format=%b)
alias new-c = git commit -m "update" 

# the completion command will shadow the original command
# for consulting help message, the original command should be preferred
# while ^ is hard to type, so use , to replace it.
alias ,git = ^git
alias ,scoop = ^scoop
alias ,uv = ^uv
alias ,pytest = ^pytest
alias ,cargo = ^cargo

# Plugin
# const NU_PLUGIN_DIRS = [
#   ($nu.current-exe | path dirname)
#   ...$NU_PLUGIN_DIRS
# ]
#
# if ($nu.os-info.name == "windows") {
#   plugin add ($NU_PLUGIN_DIRS | path join "nu_plugin_gstat.exe")
# } else {
#   plugin add ($NU_PLUGIN_DIRS | path join "nu_plugin_gstat")
# }
