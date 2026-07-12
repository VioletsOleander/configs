# Subcommands for systemctl
def commands [] {
    # systemctl has too long --help page, and no consistent format, which is hard to parse,
    # therefore just hardcode them.

    [

        # Unit Commands:
        {value: 'list-units', description: 'List units currently in memory'}
        {value: 'list-automounts', description: 'List automount units currently in memory, ordered by path'}
        {value: 'list-paths', description: 'List path units currently in memory, ordered by path'}
        {value: 'list-sockets', description: 'List socket units currently in memory, ordered by address'}
        {value: 'list-timers', description: 'List timer units currently in memory, ordered by next elapse'}
        {value: 'is-active', description: 'Check whether units are active'}
        {value: 'is-failed', description: 'Check whether units are failed or system is in degraded state'}
        {value: 'status', description: 'Show runtime status of one or more units'}
        {value: 'show', description: 'Show properties of one or more units/jobs or the manager'}
        {value: 'cat', description: 'Show files and drop-ins of specified units'}
        {value: 'help', description: 'Show manual for one or more units'}
        {value: 'list-dependencies', description: 'Recursively show units which are required or wanted by the units or by which those units are required or wanted'}
        {value: 'start', description: 'Start (activate) one or more units'}
        {value: 'stop', description: 'Stop (deactivate) one or more units'}
        {value: 'reload', description: 'Reload one or more units'}
        {value: 'restart', description: 'Start or restart one or more units'}
        {value: 'try-restart', description: 'Restart one or more units if active'}
        {value: 'enqueue-marked', description: 'Enqueue jobs for all marked units'}
        {value: 'reload-or-restart', description: 'Reload one or more units if possible, otherwise start or restart'}
        {value: 'try-reload-or-restart', description: 'If active, reload one or more units, if supported, otherwise restart'}
        {value: 'isolate', description: 'Start one unit and stop all others'}
        {value: 'kill', description: 'Send signal to processes of a unit'}
        {value: 'clean', description: 'Clean runtime, cache, state, logs or configuration of unit'}
        {value: 'freeze', description: 'Freeze execution of unit processes'}
        {value: 'thaw', description: 'Resume execution of a frozen unit'}
        {value: 'set-property', description: 'Sets one or more properties of a unit'}
        {value: 'bind', description: "Bind-mount a path from the host into a unit's namespace"}
        {value: 'mount-image', description: "Mount an image from the host into a unit's namespace"}
        {value: 'service-log-level', description: 'Get/set logging threshold for service'}
        {value: 'service-log-target', description: 'Get/set logging target for service'}
        {value: 'reset-failed', description: 'Reset failed state for all, one, or more units'}
        {value: 'whoami', description: 'Return unit caller or specified PIDs are part of'}

        # Unit File Commands:
        {value: 'list-unit-files', description: 'List installed unit files'}
        {value: 'enable', description: 'Enable one or more unit files'}
        {value: 'disable', description: 'Disable one or more unit files'}
        {value: 'reenable', description: 'Reenable one or more unit files'}
        {value: 'preset', description: 'Enable/disable one or more unit files based on preset configuration'}
        {value: 'preset-all', description: 'Enable/disable all unit files based on preset configuration'}
        {value: 'is-enabled', description: 'Check whether unit files are enabled'}
        {value: 'mask', description: 'Mask one or more units'}
        {value: 'unmask', description: 'Unmask one or more units'}
        {value: 'link', description: 'Link one or more units files into the search path'}
        {value: 'revert', description: 'Revert one or more unit files to vendor version'}
        {value: 'add-wants', description: "Add 'Wants' dependency for the target on specified one or more units"}
        {value: 'add-requires', description: "Add 'Requires' dependency for the target on specified one or more units"}
        {value: 'edit', description: 'Edit one or more unit files'}
        {value: 'get-default', description: 'Get the name of the default target'}
        {value: 'set-default', description: 'Set the default target'}

        # Machine Commands:
        {value: 'list-machines', description: 'List local containers and host'}

        # Job Commands:
        {value: 'list-jobs', description: 'List jobs'}
        {value: 'cancel', description: 'Cancel all, one, or more jobs'}

        # Environment Commands:
        {value: 'show-environment', description: 'Dump environment'}
        {value: 'set-environment', description: 'Set one or more environment variables'}
        {value: 'unset-environment', description: 'Unset one or more environment variables'}
        {value: 'import-environment', description: 'Import all or some environment variables'}

        # Manager State Commands:
        {value: 'daemon-reload', description: 'Reload systemd manager configuration'}
        {value: 'daemon-reexec', description: 'Reexecute systemd manager'}
        {value: 'log-level', description: 'Get/set logging threshold for manager'}
        {value: 'log-target', description: 'Get/set logging target for manager'}
        {value: 'service-watchdogs', description: 'Get/set service watchdog state'}

        # System Commands:
        {value: 'is-system-running', description: 'Check whether system is fully running'}
        {value: 'default', description: 'Enter system default mode'}
        {value: 'rescue', description: 'Enter system rescue mode'}
        {value: 'emergency', description: 'Enter system emergency mode'}
        {value: 'halt', description: 'Shut down and halt the system'}
        {value: 'poweroff', description: 'Shut down and power-off the system'}
        {value: 'reboot', description: 'Shut down and reboot the system'}
        {value: 'kexec', description: 'Shut down and reboot the system with kexec'}
        {value: 'soft-reboot', description: 'Shut down and reboot userspace'}
        {value: 'exit', description: 'Request user instance or container exit'}
        {value: 'switch-root', description: 'Change to a different root file system'}
        {value: 'sleep', description: 'Put the system to sleep (through one of the operations below)'}
        {value: 'suspend', description: 'Suspend the system'}
        {value: 'hibernate', description: 'Hibernate the system'}
        {value: 'hybrid-sleep', description: 'Hibernate and suspend the system'}
        {value: 'suspend-then-hibernate', description: 'Suspend the system, wake after a period of time, and hibernate'}
    ]
}

# Refer to https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_systemctl.fish#L4
def units [extra_flags?: string] {
    let loaded = if $extra_flags == null {
        ^systemctl --full --no-legend --no-pager --plain --all list-units
    } else {
        ^systemctl --full --no-legend --no-pager --plain --all list-units $extra_flags
    }
    | lines
    | parse --regex '(?<value>\S+)\s+(?<description>.+)'

    let installed = if $extra_flags == null {
        ^systemctl --full --no-legend --no-pager --plain --all list-unit-files
    } else {
        ^systemctl --full --no-legend --no-pager --plain --all list-unit-files $extra_flags
    }
    | lines
    | parse --regex '(?<value>\S+)\s+(?<description>.+)'
    | where value not-in $loaded.value

    $loaded | append $installed
}

# Very strange, just pass @units as completer will not work, therefore an wrapper is needed
# It is suspected to be a bug of Nushell.
def all-units [] {
    units
}

def units-to-enable [] {
    units '--state=disabled'
}

def units-to-disable [] {
    units '--state=enabled'
}

def units-to-start [] {
    units '--state=dead,failed,disabled'
}

def units-to-mask [] {
    units '--state=loaded'
}

def units-to-unmask [] {
    units '--state=masked'
}

def units-to-stop [] {
    units '--state=running,mounted,active'
}

export extern main [
    command?: string@commands
]

export extern 'systemctl enable' [
    unit: string@units-to-enable
]

export extern 'systemctl disable' [
    unit: string@units-to-disable
]

export extern 'systemctl start' [
    unit: string@units-to-start
]

export extern 'systemctl mask' [
    unit: string@units-to-mask
]

export extern 'systemctl unmask' [
    unit: string@units-to-unmask
]

export extern 'systemctl stop' [
    unit: string@units-to-stop
]

export extern 'systemctl status' [
    unit: string@all-units
]

export extern 'systemctl show' [
    unit: string@all-units
]

export extern 'systemctl restart' [
    unit: string@all-units
]

export extern 'systemctl reload' [
    unit: string@all-units
]
