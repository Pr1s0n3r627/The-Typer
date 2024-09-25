#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to find the Python path and set up virtual environment
find_python() {
    echo "Checking for Python installation..."
    if command_exists python3; then
        PYTHON_PATH=$(command -v python3)
    elif command_exists python; then
        PYTHON_PATH=$(command -v python)
    else
        echo "Python is not installed on this system. Attempting installation..."
        if [[ "$OS" == "Mac" ]]; then
            install_homebrew_if_needed
            echo "Installing Python via Homebrew..."
            brew install python3 || { echo "Python installation failed. Install Python manually."; exit 1; }
            PYTHON_PATH=$(command -v python3)
        elif [[ "$OS" == "Windows" ]]; then
            echo "Please install Python manually from https://www.python.org/ and re-run this script."
            exit 1
        fi
    fi
    echo "Python found at: $PYTHON_PATH"

    echo "Setting up virtual environment..."
    $PYTHON_PATH -m venv "$HOME/Desktop/autotyper/venv" || { echo "Failed to create virtual environment."; exit 1; }
    source "$HOME/Desktop/autotyper/venv/bin/activate"
}

# Function to install Homebrew if it's not installed (macOS only)
install_homebrew_if_needed() {
    echo "Checking for Homebrew installation..."
    if ! command_exists brew; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew. Please install it manually."; exit 1; }
    else
        echo "Homebrew is already installed."
    fi
}

# Function to check if Git is installed
check_git() {
    echo "Checking for Git installation..."
    if ! command_exists git; then
        echo "Git is not installed."
        if [[ "$OS" == "Mac" ]]; then
            install_homebrew_if_needed
            echo "Installing Git via Homebrew..."
            brew install git || { echo "Git installation failed. Install Git manually."; exit 1; }
        elif [[ "$OS" == "Windows" ]]; then
            echo "Please install Git manually from https://git-scm.com/ and re-run this script."
            exit 1
        fi
    else
        echo "Git is already installed."
    fi
}

# Function to clone or update the repository
clone_repo() {
    REPO_DIR="$HOME/Desktop/autotyper/The-Typer"
    if [ -d "$REPO_DIR" ]; then
        echo "The-Typer repository already exists. Pulling latest changes..."
        cd "$REPO_DIR" && git pull || { echo "Git pull failed. Check your internet connection."; exit 1; }
    else
        echo "Cloning The-Typer repository..."
        mkdir -p "$HOME/Desktop/autotyper"
        git clone https://github.com/Pr1s0n3r627/The-Typer "$REPO_DIR" || { echo "Git clone failed. Check your internet connection."; exit 1; }
    fi
}

# Function to install Python dependencies
install_dependencies() {
    echo "Checking and installing required Python dependencies..."
    PIP_EXEC="$HOME/Desktop/autotyper/venv/bin/pip"
    if ! $PIP_EXEC show pyautogui > /dev/null 2>&1 || ! $PIP_EXEC show pyqt5 > /dev/null 2>&1; then
        echo "Installing dependencies..."
        $PIP_EXEC install pyautogui pyqt5 || { echo "Dependency installation failed. Ensure pip is correctly installed."; exit 1; }
    else
        echo "Dependencies are already installed."
    fi
}

# Function to create a shortcut (macOS)
create_mac_shortcut() {
    echo "Creating a macOS shortcut..."
    APP_DIR="$HOME/Desktop/RunTexter.app"
    mkdir -p "$APP_DIR/Contents/MacOS"
    echo '#!/bin/bash' > "$APP_DIR/Contents/MacOS/RunTexter"
    echo "$HOME/Desktop/autotyper/venv/bin/python $HOME/Desktop/autotyper/The-Typer/texter.py" >> "$APP_DIR/Contents/MacOS/RunTexter"
    chmod +x "$APP_DIR/Contents/MacOS/RunTexter"
    echo "Shortcut created: RunTexter.app on your Desktop."
}

# Function to create a shortcut (Windows)
create_windows_shortcut() {
    echo "Creating a Windows shortcut..."
    powershell -Command "
        \$WshShell = New-Object -ComObject WScript.Shell;
        \$Shortcut = \$WshShell.CreateShortcut([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'RunTexter.lnk'));
        \$Shortcut.TargetPath = '$HOME\\Desktop\\autotyper\\venv\\Scripts\\python.exe';
        \$Shortcut.Arguments = '\"$HOME\\Desktop\\autotyper\\The-Typer\\texter.py\"';
        \$Shortcut.WorkingDirectory = '\"$HOME\\Desktop\\autotyper\\The-Typer\"';
        \$Shortcut.Save();
    " || { echo "Failed to create a Windows shortcut. You may need to manually create one."; exit 1; }
    echo "Shortcut created: RunTexter.lnk on your Desktop."
}

# Function to run the Python script
run_texter() {
    echo "Running texter.py..."
    $HOME/Desktop/autotyper/venv/bin/python "$HOME/Desktop/autotyper/The-Typer/texter.py" || { echo "Failed to run texter.py. Ensure Python is correctly set up."; exit 1; }
}

# Check the OS type
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="Mac"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
    OS="Windows"
else
    echo "This script only supports macOS and Windows."
    exit 1
fi
echo "Detected OS: $OS"

# Main script flow
find_python
check_git
clone_repo
install_dependencies

# Create shortcut based on OS
if [[ "$OS" == "Mac" ]]; then
    create_mac_shortcut
elif [[ "$OS" == "Windows" ]]; then
    create_windows_shortcut
fi

# Run the texter script
run_texter

echo "Setup completed successfully!"