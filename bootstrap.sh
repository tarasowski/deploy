#!/usr/bin/env bash
set -ex

# Install Node.js (LTS version)
echo "Installing Node.js (LTS version)"
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs

# Verify Node.js installation
echo "Node.js version:"
node -v
echo "npm version:"
npm -v

# Install any additional dependencies (if your app needs any)
# For example, you can install additional libraries or tools here
# sudo apt install -y <some-package>

# Create _app user if it doesn't already exist
echo "Creating user '_app' if it doesn't exist"
if ! id "_app" &>/dev/null; then
    sudo useradd -r -m -s /bin/bash _app
fi

# Create the application directory
echo "Creating /home/_app directory"
sudo mkdir -p /home/_app

# Create empty env.ini file if it doesn't exist (temporary placeholder)
echo "Creating empty env.ini file"
if [ ! -f /home/_app/env.ini ]; then
    sudo touch /home/_app/env.ini
    sudo chown _app:_app /home/_app/env.ini
    sudo chmod 400 /home/_app/env.ini
else
    echo "/home/_app/env.ini already exists."
fi

# Create the systemd service for the app
echo "Creating systemd service for the app"
cat <<EOF | sudo tee /etc/systemd/system/app.service
[Unit]
Description=Node.js App
After=network.target

[Service]
ExecStart=/usr/bin/node /home/_app/app.js
WorkingDirectory=/home/_app
Restart=always
User=_app
Group=_app
EnvironmentFile=/home/_app/env.ini

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to apply the new service
sudo systemctl daemon-reload

# Enable and start the service (optional, can be done later)
# sudo systemctl enable app
# sudo systemctl start app

# Set permissions for the application directory
echo "Setting permissions for /home/_app"
sudo chown -R _app:_app /home/_app
sudo chmod 700 /home/_app

# Final message
echo "Setup complete. The machine is ready to run the Node.js app."

# End of script
