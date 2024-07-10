# Nginx Configuration Manager Script

This script provides a simple command-line interface (CLI) for managing Nginx server configurations in the directories `/etc/nginx/sites-available` (available configurations) and `/etc/nginx/sites-enabled` (enabled configurations).

## Features

- List all available and enabled Nginx configurations.
- Enable, disable, edit, and remove Nginx configurations.
- Add new Nginx configurations easily through the CLI.

## Requirements

- Bash (Bourne Again Shell)
- Nginx installed and configured
- Sudo privileges to manage Nginx configurations

## Features

  - Manage Nginx configurations.
  - Enable or disable configurations.
  - Edit or remove existing configurations.
  - Add new configurations.
  - Automatically restart Nginx after enabling configuration.

## Requirements 

  - Nginx installed on your system.
  - The script assumes standard Nginx configuration file naming and directory conventions (sites-available and sites-enabled).
    
## Usage

  1. **Clone the repository**:
     ```bash
     git clone https://github.com/algisbernatovics/nginx-conf-manager.git
     ```
  2. **Make the script executable**:
     ```bash
     cd nginx-conf-manager
     chmod +x nginx-conf-manager.sh
     ```
  3. **Run the script**:
     ```bash
     ./nginx-conf-manager.sh
     ```
  4. **Follow the on-screen prompts**:
     - Enter the number corresponding to the configuration you want to manage.
     - Choose to enable, disable, edit, or remove the configuration.
     - To add a new configuration, select `a` and enter the name of the new configuration file.

- **Example**:
  ```bash
  # List configurations
  ./nginx-conf-manager.sh

  # Enable a configuration
  Enter the number of the configuration to enable/disable/edit/remove/add (0 to exit, a to add a new configuration): 1
  Configuration example.com is available. Do you want to enable it (e), edit it (d), or remove it (r)? (e/d/r): e

  # Add a new configuration
  Enter the number of the configuration to enable/disable/edit/remove/add (0 to exit, a to add a new configuration): a
  Enter the name of the new configuration file: new_site.conf
  Created new configuration testsite.com
