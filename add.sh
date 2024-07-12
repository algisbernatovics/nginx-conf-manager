#!/bin/bash

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
    echo "}" | sudo tee -a "$config_path" >/dev/null

    # Set appropriate permissions
    sudo chmod "$CONFIG_PERMISSIONS" "$config_path"

    echo -e "${GREEN}Created new configuration file $config_name.${NC}"
}
