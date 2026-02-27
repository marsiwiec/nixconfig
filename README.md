# nixconfig

Personal NixOS and Home Manager configurations, managed with [Flake Parts](https://flake.parts/) and [import-tree](https://github.com/vic/import-tree).

## 🚀 Overview

This repository contains my personal system configurations for various machines. It is structured to be modular and easily extensible, leveraging modern Nix features.

- **System:** NixOS (Unstable)
- **Configuration Framework:** `flake-parts`
- **User Management:** Home Manager
- **Secret Management:** `sops-nix`
- **Styling:** `stylix` (Theming across the entire system)

> [!IMPORTANT]
> The `flake.nix` file is auto-generated using [flake-file](https://github.com/vic/flake-file). Use `nix run .#write-flake` to regenerate it if you modify the structure.

## 🖥️ Hosts

| Host | Purpose | Theme |
|------|---------|-------|
| `nixgroot` | Main Desktop (Gaming, NVIDIA, Passthrough) | Everforest |
| `labnix` | Work/Lab Machine | Catppuccin Frappe |

## 📂 Project Structure

- `assets/`: Wallpapers, icons, and avatars.
- `modules/`:
    - `defaults/`: Default settings for NixOS, Darwin, and Home Manager.
    - `features/`: Modular system and home-manager features (e.g., browsers, gaming, development).
    - `hosts/`: Machine-specific configurations.
    - `settings/`: Global settings (nix, secrets, stylix, system).
    - `users/`: User-specific configurations.

## 🛠️ Features

The configuration is broken down into modular features that can be easily enabled:

- **Desktop Environments:** Niri, Dank Material Shell.
- **Development:** AI tools, Devenv, Git, LSP support, Python, R.
- **Gaming:** Steam and gaming-related tweaks.
- **Media:** Spicetify, generic media tools.
- **Cloud/Sync:** Syncthing, Rclone, Tailscale.
- **Security:** Bitwarden, Sops.
- **System:** Custom networking, boot, audio, and hardware (NVIDIA) configurations.

## ⚙️ Installation & Usage

### Rebuilding the system

To apply the configuration for a specific host:

```bash
# Example for nixgroot
sudo nixos-rebuild switch --flake .#nixgroot
# OR use the nh update script in the config to perform nh os switch .
update
```

### Updating

```bash
nix flake update
update
```

### Formatting

This project uses `nixfmt` (via treefmt if configured, otherwise manual).

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
