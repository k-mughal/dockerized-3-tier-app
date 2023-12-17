# Dockerized 3-Tier Application

This is a fully functional example of a three-tier multi-container application. It includes React for the frontend, Flask for the backend, and PostgreSQL as the database, all orchestrated by the Nginx reverse proxy.

## How it Works

When a request from an external user hits the Nginx web server on port 80, the request is served based on the URL. The React code routes the request to the Flask backend server through nginx reverse proxy. The Flask Docker container is running and exposes port 5000. These settings are defined in the nginx.conf file, enabling Nginx to be aware of both frontend and backend services. The Flask container communicates with the PostgreSQL database on port 5432 for any requests requiring database operations.

**Note:** Ensure that you have Docker, python, Node, and npm installed.
