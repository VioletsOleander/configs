### Environment

## Editor
$env.config.buffer_editor = 'nvim'

## Edit
$env.config.edit_mode = 'vi'
$env.config.keybindings ++= [
    {
        name: 'ctrl-[ escape'
        modifier: Control
        keycode: Char_u00005b
        mode: [Vi_Insert]
        event: {send: ViChangeMode, mode: normal}
    }
    {
        name: 'ctrl-l escape'
        modifier: Control
        keycode: Char_l
        mode: [Vi_Insert]
        event: {send: ViChangeMode, mode: normal}
    }
    {
        name: 'ctrl-m enter'
        modifier: Control
        keycode: Char_m
        mode: [Vi_Insert]
        event: {send: Enter}
    }
    {
        name: 'ctrl-f word completion'
        modifier: Control
        keycode: Char_f
        mode: [Vi_Insert]
        event: {
            until: [
                {send: HistoryHintWordComplete}
                {edit: MoveWordRight, select: false}
            ]
        }
    }
    {
        name: 'ctrl-u cut line'
        modifier: Control
        keycode: Char_u
        mode: [Vi_Insert]
        event: {edit: CutFromStart}
    }
    {
        name: 'ctrl-j menu down'
        modifier: Control
        keycode: Char_j
        mode: [Vi_Insert]
        event: {
            until: [
                {send: MenuDown}
                {send: Down}
            ]
        }
    }
    {
        name: 'ctrl-k menu down'
        modifier: Control
        keycode: Char_k
        mode: [Vi_Insert]
        event: {
            until: [
                {send: MenuUp}
                {send: Up}
            ]
        }
    }
]

$env.config.cursor_shape.vi_insert = 'line'
$env.config.cursor_shape.vi_normal = 'block'

## Color
$env.config.color_config.bool = 'cyan'
$env.config.color_config.shape_bool = 'cyan'
$env.config.color_config.shape_external_resolved = 'yellow_bold'
$env.config.color_config.shape_nothing = 'cyan'
$env.config.color_config.shape_raw_string = 'purple'

$env.LS_COLORS = (vivid generate onelight-refined)

## Misc
$env.config.rm.always_trash = true
$env.config.show_banner = false
$env.PROMPT_COMMAND_RIGHT = {||
    let time = date now | format date '%m/%d/%Y %a %I:%M:%S %p'
    $'(ansi purple)($time)(ansi reset)'
}

## Tool
if $nu.os-info.name == 'windows' {
    $env.YAZI_FILE_ONE = [$env.HOMEDRIVE $env.HOMEPATH 'scoop\apps\git\current\usr\bin\file.exe'] | path join
    $env.DELTA_PAGER = $'less --lesskey-src="([$env.HOMEDRIVE $env.HOMEPATH "_lesskey"] | path join)"'
}

# Disable localization
$env.LANG = 'C.UTF-8'

### Source

const third_party = $nu.default-config-dir | path join 'third_party'
const nu_scripts = $third_party | path join 'nu_scripts'

## Completion
# const custom_completions = $nu_scripts | path join 'custom-completions'
source ($nu.cache-dir | path join 'carapace.nu')

## Color theme
const nu_themes = $nu_scripts | path join 'themes/nu-themes'

### Alias

## Built-in
alias la = ls -a
alias ll = ls -l
alias cls = clear

## Tool
alias g = git
# Set alias in shell to enable completion for branch name
alias 'g b' = git branch
alias 'g bd' = git branch -D
alias 'g bdr' = git branch -D --remotes
alias 'g sw' = git switch

alias lg = lazygit
alias re = recnys
alias vn = vanillian
alias nv = nvim
alias ex = exa
alias np = npm
alias cat = bat
alias tec = tectonic

### Plugin
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
