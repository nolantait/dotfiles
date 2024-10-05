# Minimal Arch Install

## Installation

1. **Boot into Arch Live Environment:** Start by booting into your live Arch environment. You can use a USB drive with Arch installation or similar methods.

2. **Copy the Scripts:** Copy the provided scripts to the live environment. Ensure that all scripts are executable.

3. **Run the Installation Script:** Execute the following command to initiate the installation process:

```bash
./install-arch.sh
```

This script will prompt you with various questions during the installation.

- The script will request the block device path where you want to install Arch.
- Choose between manual partitioning or the default partitioning scheme.
 - Default scheme: Creates partition according to arch wiki
 - Manual partitioning: Use `cfdisk` for cases with existing OSes/partitions on the device.
- Sets up systemd boot manager


4. **Post-Installation Setup:** After the installation script finishes, reboot your system and log in as the root user. Run the `init-root.sh` script:

```bash
./init-root.sh
```

This script performs the following tasks:
- Creates a new user and adds it to relevant groups.
- Modifies suders config
- Improves some `pacman` functionalities
- Sets up a 2 GB swap file.
