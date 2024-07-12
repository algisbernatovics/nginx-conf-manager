#!/bin/bash

# Load configuration and functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load configuration and functions
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/list.sh"
source "$SCRIPT_DIR/enable.sh"
source "$SCRIPT_DIR/disable.sh"
source "$SCRIPT_DIR/edit.sh"
source "$SCRIPT_DIR/remove.sh"
source "$SCRIPT_DIR/add.sh"

list_configs

get_user_choice() {
    while true; do
        read -p "Enter the number of the configuration to enable/disable/edit/remove/add (0 to exit, a to add a new configuration): " CHOICE

        # Check if the choice is valid
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 0 ]; then
            echo "$CHOICE"
            return
        elif [ "$CHOICE" = "a" ]; then
            echo "$CHOICE"
            return
        else
            echo "Invalid choice. Please enter a valid number, '0' to exit, or 'a' to add a new configuration."
        fi
    done
}

CHOICE=$(get_user_choice)

# Process selection
if [ "$CHOICE" = "0" ]; then
    echo "Exiting."
    exit 0
elif [ "$CHOICE" = "a" ]; then
    # Prompt for the name of the new configuration file
    read -p "Enter the name of the new configuration file: " NEW_CONFIG
    add_config "$NEW_CONFIG"
    exit 0
fi

# Get the selected configuration from all_configs array based on CHOICE
selected_config=$(echo "$all_configs" | sed -n "${CHOICE}p")

# Check if the selected configuration is enabled or available and take appropriate action
if echo "$enabled_configs" | grep -q "\b$selected_config\b"; then
    # Configuration is enabled, prompt to disable or edit
    while true; do
        read -p "Configuration $selected_config is enabled. Do you want to disable it (d) or edit it (ed)? (d/ed): " ACTION
        if [[ "$ACTION" == "d" ]]; then
            disable_config "$selected_config"
            break
        elif [[ "$ACTION" == "ed" ]]; then
            edit_config "$selected_config"
            break
        else
            echo "Invalid action. Please enter 'd' to disable or 'e' to edit."
        fi
    done
else
    # Configuration is available, prompt to enable, edit, or remove
    while true; do
        read -p "Configuration $selected_config is available. Do you want to enable it (e), edit it (ed), or remove it (r)? (e/ed/r): " ACTION
        if [[ "$ACTION" == "e" ]]; then
            enable_config "$selected_config"
            break
        elif [[ "$ACTION" == "ed" ]]; then
            edit_config "$selected_config"
            break
        elif [[ "$ACTION" == "r" ]]; then
            remove_config "$selected_config"
            break
        else
            echo "Invalid action. Please enter 'e' to enable, 'ed' to edit, or 'r' to remove."
        fi
    done
fi