# nginx-conf-manager

Running the Script:

Execute the script in the terminal:
`sh nginx-conf-manager.sh`
Navigating the Menu:

The script first lists the enabled and disabled configurations.
The user is prompted to select an option:
Enter the number corresponding to a configuration to enable/disable/edit/remove it.
Enter a to add a new configuration.
Enter 0 to exit.
Actions on Configurations:

Enable a Configuration:
If a disabled configuration is selected, it can be enabled.
Disable a Configuration:
If an enabled configuration is selected, it can be disabled.
Edit a Configuration:
Any configuration can be edited in the text editor.
Remove a Configuration:
Disabled configurations can be removed.
Add a New Configuration:
Prompts for a new configuration name and creates a template file.
Dependencies
Nginx: Ensure Nginx is installed and the configuration directories exist.
gedit: The script uses gedit to edit configuration files.
System Permissions: The script requires sudo permissions to modify Nginx configurations and restart the service.
