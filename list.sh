# list.sh
list_configs() {
    # Retrieve list of sites in sites-available and sites-enabled
    enabled_configs=$(ls "$SITES_ENABLED" 2>/dev/null)
    available_configs=$(ls "$SITES_AVAILABLE" 2>/dev/null)

    # Merge arrays to get all unique sites
    all_configs=$(printf "%s\n%s\n" "$enabled_configs" "$available_configs" | sort -u)

    # Display configurations
    echo -e "${GREEN}=== Enabled and Available Configurations ===${NC}"
    index=1
    for config in $all_configs; do
        if echo "$enabled_configs" | grep -q "\b$config\b"; then
            echo -e "${GREEN}${index}. $config${NC}"
        else
            echo -e "${RED}${index}. $config${NC}"
        fi
        index=$((index + 1))
    done

    # Display option to add a new configuration
    echo -e
    echo -e "${YELLOW}a. Add a new configuration${NC}"
    echo -e
}