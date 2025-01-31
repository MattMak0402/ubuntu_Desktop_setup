#!/bin/bash

# This script sets up Node.js environment variables and verifies the installation

# Define a helper function to check if a command/program exists in the system
# Returns 0 (success) if command exists, 1 (failure) if it doesn't
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Checking Node.js installation..."

# Verify that Node.js is installed on the system
# If not found, exit with error message
if ! command_exists node; then
    echo "Error: Node.js is not installed. Please install it first."
    exit 1
fi

# Get the full path to Node.js executable
# This helps confirm where Node.js is installed
NODE_PATH=$(which node)
echo "Node.js found at: $NODE_PATH"

# Check if Node.js path is already configured in ~/.bashrc
# If not, add it to ensure Node.js is always accessible
if ! grep -q "export PATH.*node" ~/.bashrc; then
    echo "Adding Node.js to PATH in ~/.bashrc..."
    # Add a section marker for Node.js configuration
    echo -e "\n# Node.js Path" >> ~/.bashrc
    # Add /usr/bin to PATH if it's not already there
    echo "export PATH=\"\$PATH:/usr/bin\"" >> ~/.bashrc
    echo "Node.js path has been added to ~/.bashrc"
else
    echo "Node.js path already exists in ~/.bashrc"
fi

# Display installed versions for verification
# This helps confirm that Node.js and npm are working correctly
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Remind user to reload shell configuration
echo "Setup complete. Please run 'source ~/.bashrc' or restart your terminal to apply changes."
