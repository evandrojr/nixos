# NixOS Configuration

This repository contains the configuration files for a NixOS system. It is designed to manage and customize the system's behavior, installed packages, and services.

## Files

- **configuration.nix**: The main configuration file where system settings, services, and packages are defined.
- **hardware-configuration.nix**: Automatically generated file that contains hardware-specific configurations.

## Features

- **Desktop Environment**: GNOME is enabled as the default desktop environment.
- **Networking**: NetworkManager is enabled for managing network connections.
- **Locale**: Configured for Brazilian Portuguese (pt_BR.UTF-8).
- **User Account**: A user named `dg` is pre-configured with Zsh as the default shell and additional groups like `networkmanager`, `wheel`, and `docker`.
- **Packages**: Includes essential tools like Vim, Git, Docker, Google Chrome, LibreOffice, and more.
- **PipeWire**: Enabled for audio management.
- **Zsh**: Configured with Oh My Zsh, syntax highlighting, and autosuggestions.

## Usage

1. **Edit Configuration**: Modify `configuration.nix` to customize the system settings.
2. **Apply Changes**: Run the following command to apply the configuration:
   ```bash
   sudo nixos-rebuild switch
   ```
3. **Set Password**: Don't forget to set a password for the `dg` user:
   ```bash
   sudo passwd dg
   ```

## Notes

- Ensure that the `hardware-configuration.nix` file is up-to-date if you change hardware.
- For more information, refer to the [NixOS Manual](https://nixos.org/manual/nixos/stable/).

## License

This configuration is provided as-is. Feel free to modify it to suit your needs.