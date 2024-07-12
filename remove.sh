#!/bin/bash

# Function to remove a disabled configuration
remove_config() {
    local config=$1
    sudo rm "$SITES_AVAILABLE/$config"
    echo -e "${YELLOW}Removed configuration $config.${NC}"
    echo -e "\n"
}
