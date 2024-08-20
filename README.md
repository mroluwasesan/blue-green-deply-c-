# Bg.Csharp.Web - ASP.NET Core Sample for Blue-Green Deployment

## Overview

**Bg.Csharp.Web** is a simple ASP.NET Core MVC web application designed to demonstrate Blue-Green Deployment strategies. The project follows a modular structure, which is commonly used in enterprise-level applications.

## Project Structure

- **Bg.Application**: Application logic and services.
- **Bg.Application.Test**: Unit tests for the application layer.
- **Bg.Domain**: Domain models and business logic.
- **Bg.Infrastructure**: Infrastructure and data access code.
- **Bg.Web**: ASP.NET Core MVC web application.

## Purpose

This project is intended to help you understand and experiment with Blue-Green Deployment. By setting up two identical environments (Blue and Green) on your server, you can practice deploying new versions of the application with minimal downtime and easy rollback.

## Features

- Modular structure for easy scaling and maintenance
- Simple MVC web application
- Easily identifiable environment (Blue or Green) on the home page
- Dockerfile included for containerization

## How to Use

### Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download) installed on your machine
- A server with [Nginx](https://www.nginx.com/) installed for reverse proxy setup
- Systemd for managing services (optional)

### Building the Application

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/Bg.Csharp.Web.git
   cd Bg.Csharp.Web

2. **Build the Solution:**

   ```bash
   dotnet build Bg.Csharp.Web.sln

3. **Publish the Web Application:**
    Publish the web application to a directory for either Blue or Green environment:

   ```bash
   # For Blue environment
    dotnet publish src/Bg.Web/Bg.Web.csproj -c Release -o /var/www/blue
    # For Green environment
    dotnet publish src/Bg.Web/Bg.Web.csproj -c Release -o /var/www/green

### Setting Up Blue-Green Deployment

1. **Configure Nginx:**
    Create or update your Nginx configuration file to set up the reverse proxy:

   ```bash
    upstream blue {
        server 127.0.0.1:5000;  # Port where Blue is running
        }

    upstream green {
    server 127.0.0.1:5001;  # Port where Green is running
    }

    server {
        listen 80;
        server_name yourdomain.com;

        location / {
            proxy_pass http://blue;  # Switch to http://green for Green environment
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }

2. **Deploy Blue/Green:**
    Deploy either Blue or Green by updating the Nginx configuration and restarting the service:
   ```bash
   sudo systemctl restart nginx

3. **Testing:**
    Access your application via the domain name you've set up. You should see the environment name (Blue or Green) on the home page.


### Contributing
Feel free to submit issues, fork the repository, and make pull requests. Contributions are welcome!

### License
This project is licensed under the MIT License - see the LICENSE file for details.


### Steps to Deploy

1. **Clone the Project**: Clone the repository to your local machine.
2. **Build and Run**: Use the provided commands to build and run the application.
3. **Nginx Configuration**: Set up your Nginx server to route requests to either the Blue or Green environment.
4. **Deploy and Test**: Deploy the application and test the Blue-Green deployment by switching the upstream server in the Nginx configuration.

This setup will allow you to test Blue-Green Deployment with a basic ASP.NET Core application. You can add more features and complexity as needed.
