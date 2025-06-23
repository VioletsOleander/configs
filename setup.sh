#!/bin/bash

function setup() {
	rsync --exclude ".git/" \
		--exclude "setup.sh" \
		--exclude "README.md" \
        --exclude "additional_setup.sh" \
		-avh --no-perms . ~;
    if [[ -f ./additional_setup.sh ]]; then
        source additional_setup.sh
    fi
	source ~/.bashrc;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	setup;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup;
	fi;
fi;
unset setup;
