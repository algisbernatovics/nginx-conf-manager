get_user_choice() {
    while true; do
        read -p "Enter the number of the configuration): " CHOICE

        # Check if the choice is valid
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 0 ]; then
            echo "$CHOICE"
            return
        elif [ "$CHOICE" = "a" ]; then
            echo "$CHOICE"
            return
        else
            echo "Invalid choice.\nPlease enter a valid number,\n'-0' to exit,\n'a' to add a new configuration."
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
echo -e "\nConfiguration $selected_config is available.\n\n- Edit it (ed)\n- Disable it (d)?\n"
        read -p "(ed/d):" ACTION
           echo -e "\n"
        if [[ "$ACTION" == "d" ]]; then
            disable_config "$selected_config"
            break
        elif [[ "$ACTION" == "ed" ]]; then
            edit_config "$selected_config"
            break
        elif [ "$ACTION" = "0" ]; then
        echo "Exiting."
        exit 0
        else
            echo -e "Invalid action. Please enter\n\n'd' to disable or\n'e' to edit.\n"
        fi
    done
else
    # Configuration is available, prompt to enable, edit, or remove
    while true; do
   echo -e "\nConfiguration $selected_config is available.\n\n- Edit it (ed)\n- Remove it (r)?\n- Enable it (e)\n"
        read -p "(ed/r/e):" ACTION
        echo -e "\n"
        if [[ "$ACTION" == "e" ]]; then
            enable_config "$selected_config"
            break
        elif [[ "$ACTION" == "ed" ]]; then
            edit_config "$selected_config"
            break
        elif [[ "$ACTION" == "r" ]]; then
            remove_config "$selected_config"
            break
        elif [ "$ACTION" = "0" ]; then
        echo "Exiting."
        exit 0
        else
            echo -e "Invalid action. Please enter\n\n'e' to enable,\n'ed' to edit, or\n'r' to remove.\n"
        fi
    done
fi