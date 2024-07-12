#!/bin/bash

# Function to add a new site configuration
add_config() {
    local config_name=$1
    local config_path="$SITES_AVAILABLE/$config_name"
    
    # Create the configuration file with heredoc
    sudo tee "$config_path" >/dev/null <<EOF
# Configuration file for $config_name
server {
    listen 80;
    server_name $config_name $config_name.local;
    root /var/www/$config_name;
    index index.html index.php index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    # Set appropriate permissions
    sudo chmod "$CONFIG_PERMISSIONS" "$config_path"

    # Restart Nginx
    sudo sudo systemctl restart nginx

   
    echo -e "${GREEN}Created new configuration file $config_name.${NC}"
    echo -e "${GREEN}Restarted nginx"
   
}
