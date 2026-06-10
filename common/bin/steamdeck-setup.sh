#!/bin/bash

echo "=== Steam Deck Quick Setup Script ==="
echo "This will install EmuDeck, Decky Loader, and CryoUtilities."

# Update system
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# ---------------------------------------
# Install EmuDeck
# ---------------------------------------
echo "Installing EmuDeck..."
curl -L https://www.emudeck.com/install.sh | bash

# ---------------------------------------
# Install Decky Loader
# ---------------------------------------
echo "Installing Decky Loader..."
curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | bash

# ---------------------------------------
# Install CryoUtilities
# ---------------------------------------
echo "Installing CryoUtilities..."
curl -s https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/install.sh | bash

# ---------------------------------------
# Final message
# ---------------------------------------
echo "✅ Installation complete!"
echo "Please reboot your Steam Deck to apply all changes."
