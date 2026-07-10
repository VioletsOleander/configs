def distros [] {
    [
        'Ubuntu'
        'Ubuntu-26.04'
        'Ubuntu-24.04'
        'Ubuntu-22.04'
        'openSUSE-Tumbleweed'
        'openSUSE-Leap-16.0'
        'SUSE-Linux-Enterprise-15-SP7'
        'SUSE-Linux-Enterprise-16.0'
        'kali-linux'
        'Debian'
        'AlmaLinux-8'
        'AlmaLinux-9'
        'AlmaLinux-Kitten-10'
        'AlmaLinux-10'
        'archlinux'
        'FedoraLinux-44'
        'FedoraLinux-43'
        'eLxr'
        'OracleLinux_7_9'
        'OracleLinux_8_10'
        'OracleLinux_9_5'
        'SUSE-Linux-Enterprise-15-SP6'
    ]
}

# Refer to https://github.com/microsoft/WSL/blob/master/localization/strings/en-US/Resources.resw
export extern main [
    --install: string@distros # Install a Windows Subsystem for Linux distribution.
    --list (-l) # Lists distributions.
    --running # List only distributions that are currently running.
    --verbose (-v) # Show detailed information about all distributions.
    --oneline (-o) # Displays a list of available distributions for install with 'wsl.exe --install'.
]
