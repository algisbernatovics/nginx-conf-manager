list_configs() {
    # Retrieve list of sites in sites-available and sites-enabled
    enabled_configs=$(ls "$SITES_ENABLED" 2>/dev/null)
    available_configs=$(ls "$SITES_AVAILABLE" 2>/dev/null)

    # Merge arrays to get all unique sites
    all_configs=$(printf "%s\n%s\n" "$enabled_configs" "$available_configs" | sort -u)

    # Display configurations
    echo -e "${GREEN}=== Enabled and Available Configurations ===${NC}"
    echo -e

    # Convert the list to an array
    mapfile -t config_array <<< "$all_configs"

    # Check for empty configurations
    if [ ${#config_array[@]} -eq 0 ]; then
        echo -e "${YELLOW}No configurations available.${NC}"
    else
        # Print the configurations with numbers
        for i in "${!config_array[@]}"; do
            printf "%d. %s\n" $((i + 1)) "${config_array[i]}"
        done | column
    fi

    # Display option to add a new configuration
    echo -e
    echo -e "${YELLOW}a. Add a new configuration${NC}"
    echo -e
}
