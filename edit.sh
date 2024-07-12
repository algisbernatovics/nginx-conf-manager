#!/bin/bash

# Function to edit a configuration file
edit_config() {
    local config=$1
    gedit "$SITES_AVAILABLE/$config"
    # Restart Nginx
    sudo sudo systemctl restart nginx
    echo "Restarted nginx"
    echo -e "\n"
}
