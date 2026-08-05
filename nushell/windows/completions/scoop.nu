# Subcommands for scoop
def commands [] {
    # Scoop help is too slow, therefore directly hardcode the subcommands
    [
        {value: "alias", description: "Manage scoop aliases"}
        {value: "bucket", description: "Manage Scoop buckets"}
        {value: "cache", description: "Show or clear the download cache"}
        {value: "cat", description: "Show content of specified manifest."}
        {value: "checkup", description: "Check for potential problems"}
        {value: "cleanup", description: "Cleanup apps by removing old versions"}
        {value: "config", description: "Get or set configuration values"}
        {value: "create", description: "Create a custom app manifest"}
        {value: "depends", description: "List dependencies for an app, in the order they'll be installed"}
        {value: "download", description: "Download apps in the cache folder and verify hashes"}
        {value: "export", description: "Exports installed apps, buckets (and optionally configs) in JSON format"}
        {value: "help", description: "Show help for a command"}
        {value: "hold", description: "Hold an app to disable updates"}
        {value: "home", description: "Opens the app homepage"}
        {value: "import", description: "Imports apps, buckets and configs from a Scoopfile in JSON format"}
        {value: "info", description: "Display information about an app"}
        {value: "install", description: "Install apps"}
        {value: "list", description: "List installed apps"}
        {value: "prefix", description: "Returns the path to the specified app"}
        {value: "reset", description: "Reset an app to resolve conflicts"}
        {value: "search", description: "Search available apps"}
        {value: "shim", description: "Manipulate Scoop shims"}
        {value: "status", description: "Show status and check for new app versions"}
        {value: "unhold", description: "Unhold an app to enable updates"}
        {value: "uninstall", description: "Uninstall an app"}
        {value: "update", description: "Update apps, or Scoop itself"}
        {value: "virustotal", description: "Look for app's hash or url on virustotal.com"}
        {value: "which", description: "Locate a shim/executable (similar to 'which' on Linux)"}
    ]
}

export extern main [
    command?: string@commands
]
