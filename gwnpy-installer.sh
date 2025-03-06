#!/bin/bash

# Ask for the user’s password upfront
echo "Enter your password to proceed with the setup."
sudo -v

# Define the virtual environment directory
VENV_DIR="$HOME/python_env"

# Check if Python 3 is installed, install it if necessary
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Installing it now..."
    sudo apt update && sudo apt install -y python3 python3-venv python3-pip
fi

# Create the virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating Python virtual environment at $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

# Ensure the user owns the virtual environment folder
sudo chown -R $USER:$USER "$VENV_DIR"

# Add the `gwnpy` command to the shell configuration
if ! grep -q "gwnpy()" ~/.bashrc; then
    echo "Setting up gwnpy command..."
    cat <<EOF >> ~/.bashrc

# GwenPy function to activate the Python virtual environment
export GWNPY_ENV="$VENV_DIR"
gwnpy() {
    source "\$GWNPY_ENV/bin/activate"
    echo "Virtual environment activated: \$GWNPY_ENV"
}
EOF
fi

# Apply the changes immediately
source ~/.bashrc

echo "Setup complete! Use 'gwnpy' to enter your virtual environment."
echo "Run 'gwnpy' to activate the virtual environment, and 'deactivate' to exit."