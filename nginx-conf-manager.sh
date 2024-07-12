#!/bin/bash

# Define colors using ANSI escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Constants for paths
SITES_AVAILABLE="/etc/nginx/sites-available"
SITES_ENABLED="/etc/nginx/sites-enabled"

# Function to list configuration files and their status
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
    echo -e "${YELLOW}a. Add a new configuration${NC}"
}

# Function to disable a configuration
disable_config() {
    local config=$1
    sudo rm "$SITES_ENABLED/$config"
    sudo systemctl restart nginx
    echo -e "${YELLOW}Disabled configuration $config.${NC}"
}

# Function to enable a configuration
enable_config() {
    local config=$1
    sudo ln -s "$SITES_AVAILABLE/$config" "$SITES_ENABLED/"
    sudo systemctl restart nginx
    echo -e "${GREEN}Enabled configuration $config.${NC}"
    echo -e "${GREEN}Restarted Nginx.${NC}"
}

# Function to edit a configuration file
edit_config() {
    local config=$1
    gedit "$SITES_AVAILABLE/$config"
}

# Function to remove a disabled configuration
remove_config() {
    local config=$1
    sudo rm "$SITES_AVAILABLE/$config"
    echo -e "${YELLOW}Removed configuration $config.${NC}"
}

# Function to add a new site configuration
add_config() {
    local config_name=$1
    local config_path="$SITES_AVAILABLE/$config_name"
    
    # Create the configuration file
    sudo touch "$config_path"
    echo "# Configuration file for $config_name" | sudo tee "$config_path" >/dev/null
    echo "server {" | sudo tee -a "$config_path" >/dev/null
    echo "    listen 80;" | sudo tee -a "$config_path" >/dev/null
    echo "    server_name $config_name $config_name.local;" | sudo tee -a "$config_path" >/dev/null
    echo "    root /var/www/$config_name;" | sudo tee -a "$config_path" >/dev/null
    echo "    index index.html index.php index.htm;" | sudo tee -a "$config_path" >/dev/null
    echo "    location / {" | sudo tee -a "$config_path" >/dev/null
    echo "        try_files \$uri \$uri/ /index.php?\$query_string;" | sudo tee -a "$config_path" >/dev/null
    echo "    }" | sudo tee -a "$config_path" >/dev/null
    echo "    location ~ \.php$ {" | sudo tee -a "$config_path" >/dev/null
    echo "        include snippets/fastcgi-php.conf;" | sudo tee -a "$config_path" >/dev/null
    echo "        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;" | sudo tee -a "$config_path" >/dev/null
    echo "        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;" | sudo tee -a "$config_path" >/dev/null
    echo "        include fastcgi_params;" | sudo tee -a "$config_path" >/dev/null
    echo "    }" | sudo tee -a "$config_path" >/dev/null
    echo "    location ~ /\.ht {" | sudo tee -a "$config_path" >/dev/null
    echo "        deny all;" | sudo tee -a "$config_path" >/dev/null
    echo "    }" | sudo tee -a "$config_path" >/dev/null
    echo "}" | sudo tee -a "$config_path" >/dev/null

    # Set appropriate permissions
    sudo chmod 644 "$config_path"

    echo -e "${GREEN}Created new configuration file $config_name.${NC}"
}

# List configurations
list_configs

# Prompt for selection
read -p "Enter the number of the configuration to enable/disable/edit/remove/add (0 to exit, a to add a new configuration): " CHOICE

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
    read -p "Configuration $selected_config is enabled. Do you want to disable it (d) or edit it (e)? (d/e): " ACTION
    if [ "$ACTION" = "d" ]; then
        disable_config "$selected_config"
    elif [ "$ACTION" = "e" ]; then
        edit_config "$selected_config"
    else
        echo "Exiting."
        exit 0
    fi
else
    # Configuration is available, prompt to enable, edit, or remove
    read -p "Configuration $selected_config is available. Do you want to enable it (e), edit it (d), or remove it (r)? (e/d/r): " ACTION
    if [ "$ACTION" = "e" ]; then
        enable_config "$selected_config"
    elif [ "$ACTION" = "d" ]; then
        edit_config "$selected_config"
    elif [ "$ACTION" = "r" ]; then
        remove_config "$selected_config"
    else
        echo "Exiting."
        exit 0
    fi
fi

