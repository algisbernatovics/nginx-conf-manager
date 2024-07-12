#!/bin/bash

# Function to disable a configuration
disable_config() {
    local config=$1
    sudo rm "$SITES_ENABLED/$config"
    sudo systemctl restart nginx
    echo -e "${YELLOW}Disabled configuration $config.${NC}"
    echo -e "\n"
}
