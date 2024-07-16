#!/bin/bash

# Declaration of style variables
MAGENTA="\033[35m"
BOLD="\033[1m"
CLEAR_LINE="\033[2K"
WHITE="\033[37m"
GREEN="\033[32m"
RESET="\033[0m"


# Function to clone or pull a repository
function clone_or_pull_repo {
    local repo_name="$1"
    local repo_url="$2"
    local repo_path="./$repo_name"

    if [ -d "$repo_path" ]; then
        show_message "Repository $repo_name already exists. Pulling latest changes..."
        cd "$repo_path"
        git pull origin master > /dev/null 2>&1
        cd ..
    else
        show_message "Cloning $repo_name repository from GitHub..."
        git clone "$repo_url" > /dev/null 2>&1
    fi
}

# Function to display messages
function show_message {
    printf "${BOLD}$1${RESET}\n"
}

# Function to display success messages
function show_success {
    printf "${GREEN}$1${RESET}\n"
}

# Update package list (silent)
show_message "Updating package list..."
sudo apt update -y > /dev/null 2>&1
show_success "Package list updated successfully."

# Install git if not installed
if ! command -v git &> /dev/null; then
    show_message "Git is not installed. Installing git..."
    sudo apt install git -y > /dev/null 2>&1
    show_success "Git installed successfully."
else
    show_message "Git is already installed."
fi

# Install vim if not installed
if ! command -v vim &> /dev/null; then
    show_message "Vim is not installed. Installing vim..."
    sudo apt install vim -y > /dev/null 2>&1
    show_success "Vim installed successfully."
else
    show_message "Vim is already installed."
fi

# Install python3-pip if not installed
if ! command -v pip3 &> /dev/null; then
    show_message "pip is not installed. Installing python3-pip..."
    sudo apt install python3-pip -y > /dev/null 2>&1
    show_success "python3-pip installed successfully."
else
    show_message "python3-pip is already installed."
fi

# Change to user directory
cd ~

# Create doncom directory if it doesn't exist
if [ ! -d "doncom" ]; then
    mkdir doncom
fi

# Change to doncom directory
cd doncom

# Create .dcprograms hidden directory if it doesn't exist
if [ ! -d ".dcprograms" ]; then
    mkdir .dcprograms
fi


# Clone or pull repositories
clone_or_pull_repo "Arenita" "https://github.com/doncomproject/arenita"

# Change to .dcprograms directory
cd .dcprograms

clone_or_pull_repo "Rocket" "https://github.com/doncomproject/rocket"
clone_or_pull_repo "Yakuza" "https://github.com/doncomproject/yakuza"

# Create alias for commands rocket and yakuza
echo "alias rocket='python3 ~/doncom/.dcprograms/rocket/main.py'" >> ~/.bashrc
echo "alias yakuza='python3 ~/doncom/.dcprograms/yakuza/yakuza.py'" >> ~/.bashrc
source ~/.bashrc

# Create alias for commands rocket and yakuza
alias rocket="python3 ~/doncom/.dcprogram/rocket/main.py"
alias yakuza="python3 ~/doncom/.dcprogram/yakuza/yakuza.py"

# Display completion message
show_success "${GREEN}Cloning complete!${RESET}"
