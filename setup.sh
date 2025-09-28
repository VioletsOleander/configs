#!/bin/bash

function show_help() {
	echo "Usage: $0 [OPTIONS]"
	echo ""
	echo "Options:"
	echo "  -a, --append     Append mode (default) - appends content to existing files"
	echo "  -o, --overwrite  Overwrite mode - replaces existing files"
	echo "  -f, --force      Skip confirmation prompt"
	echo "  -h, --help       Show this help message"
	echo ""
	echo "Examples:"
	echo "  $0               # Interactive append mode (default)"
	echo "  $0 --append      # Interactive append mode"
	echo "  $0 --overwrite   # Interactive overwrite mode"
	echo "  $0 -o -f         # Force overwrite mode"
	echo "  $0 -a -f         # Force append mode"
}

function setup_append() {
	echo "Setting up in APPEND mode (content will be appended to existing files)..."
	
	# Find all files to copy (excluding the specified ones)
	find . -type f \
		-not -path "./.git/*" \
		-not -name ".gitignore" \
		-not -name "setup.sh" \
		-not -name "README.md" \
		| while read -r file; do
		
		# Remove the leading './' from the file path
		relative_path="${file#./}"
		target_file="$HOME/$relative_path"
		
		# Create target directory if it doesn't exist
		target_dir=$(dirname "$target_file")
		mkdir -p "$target_dir"
		
		if [[ -f "$target_file" ]]; then
			echo "Appending to: $target_file"
			echo "" >> "$target_file"  # Add a newline separator
			echo "# --- Appended from configs setup $(date) ---" >> "$target_file"
			cat "$file" >> "$target_file"
		else
			echo "Creating new file: $target_file"
			cp "$file" "$target_file"
		fi
	done
	
	source ~/.bashrc;
}

function setup_overwrite() {
	echo "Setting up in OVERWRITE mode (existing files will be replaced)..."
	rsync --exclude ".git/" \
        --exclude ".gitignore" \
		--exclude "setup.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	source ~/.bashrc;
}

# Parse command line arguments
MODE="append"  # default mode
FORCE=false

while [[ $# -gt 0 ]]; do
	case $1 in
		-a|--append)
			MODE="append"
			shift
			;;
		-o|--overwrite)
			MODE="overwrite"
			shift
			;;
		-f|--force)
			FORCE=true
			shift
			;;
		-h|--help)
			show_help
			exit 0
			;;
		*)
			echo "Unknown option: $1"
			show_help
			exit 1
			;;
	esac
done

# Ensure we're in $HOME/configs 
if [[ "$(pwd)" != "$HOME/configs" ]]; then
    echo "Error: this script must run from \$HOME/configs/"
    echo "Current dir: $current_dir"
    echo "Expected: $HOME/configs"
    exit 1
fi


# Execute setup based on mode and force flag
if [ "$FORCE" = true ]; then
	if [ "$MODE" = "append" ]; then
		setup_append;
	else
		setup_overwrite;
	fi
else
	if [ "$MODE" = "append" ]; then
		echo "APPEND MODE: Content will be appended to existing files."
		read -p "Continue with setup? (y/n) " -n 1;
	else
		echo "OVERWRITE MODE: This will replace existing files in your home directory."
		read -p "Are you sure you want to continue? (y/n) " -n 1;
	fi
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		if [ "$MODE" = "append" ]; then
			setup_append;
		else
			setup_overwrite;
		fi
	else
		echo "Setup cancelled."
		exit 0
	fi;
fi;

# Cleanup
unset setup_append;
unset setup_overwrite;
unset show_help;
