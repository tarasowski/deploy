### Project: Fast Deployment for Express Application

#### Motivation

This project is inspired by the need for rapid deployment, as described in the blog post ["How do you deploy in 10 seconds?"](https://paravoce.bearblog.dev/how-do-you-deploy-in-10-seconds/). After years of managing production environments, ranging from startups to large enterprises, the goal is to minimize deployment time to enhance productivity and reduce costs.

#### Overview
This project provides a streamlined deployment process for an Express application using simple tools like bash, rsync, and systemd. The aim is to deploy the application in under 10 seconds, ensuring quick validation and rollback of changes.

#### Folder Structure
```
app.service
bootstrap.sh
deploy.sh
env.ini
index.js
package.json
```

#### Files Description

1. **bootstrap.sh**
   - Installs Node.js (LTS version).
   - Verifies Node.js and npm installation.
   - Creates `_app` user if it doesn't exist.
   - Creates the application directory `/home/_app`.

2. **deploy.sh**
   - Removes and recreates the temporary directory `/tmp/app`.
   - Copies application files to the temporary directory.
   - Syncs the temporary directory to the remote server.
   - Executes commands on the remote server to:
     - Stop the existing service.
     - Copy files to the application directory.
     - Copy the service file to the systemd directory.
     - Reload the systemd daemon.
     - Set appropriate permissions for the application files.
     - Start the service.

3. **app.service**
   - Defines the service unit for the Express application.
   - Sets environment variables and working directory.
   - Configures the service to restart always and run as `_app` user.

#### Usage

1. **Bootstrap the Environment**
   ```sh
   chmod +x bootstrap.sh
   ./bootstrap.sh
   ```

2. **Deploy the Application**
   ```sh
   chmod +x deploy.sh
   ./deploy.sh
   ```

#### Conclusion
By using basic tools and a straightforward approach, this project aims to achieve rapid deployment, reducing the time and complexity typically associated with CI/CD pipelines. This method allows for quick validation and rollback, enhancing the overall efficiency of the development and deployment process.

---

For more details, refer to the blog post: ["How do you deploy in 10 seconds?"](https://paravoce.bearblog.dev/how-do-you-deploy-in-10-seconds/)