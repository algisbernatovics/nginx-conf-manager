#!/bin/bash

# Function to enable a configuration
enable_config() {
    local config=$1
    sudo ln -s "$SITES_AVAILABLE/$config" "$SITES_ENABLED/"
    sudo systemctl restart nginx
    echo -e "${GREEN}Enabled configuration $config.${NC}"
    echo -e "${GREEN}Restarted Nginx.${NC}"
    echo -e "\n"
}
