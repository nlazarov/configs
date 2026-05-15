#!/usr/bin/env bash

skills_dir="$HOME/.agents/skills"

echo 'Looking for agent skills...'
if [ -d "$skills_dir" ]; then
    echo 'Found agent skills:'
    ls "$skills_dir"
else
    echo 'No agent skills found.'
    return 1
fi


function link_skills() {
    local app="$1"
    local dir="$2"

    echo "try linking to $app"
    if [ -d "$dir" ]; then
        echo "Found $app, linking to agent skills..."
        ln -s "$dir/skills" "$skills_dir"
    else
        echo "No $app found."
    fi
}

link_skills "copilot" "$HOME/.copilot"
link_skills "opencode" "$HOME/.config/opencode"
