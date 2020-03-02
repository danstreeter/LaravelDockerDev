# Basic Development Laravel Docker Installer

Installs Laravel 5.8 for development using Docker-Compose, using Docker to obtain the framework.

## TLDR

Make sure you have Docker installed

Run:

```bash
./start-project-docker.sh
```

Note - if you want to change your database settings, do so now... (see `docker-compose.yml`)

Then:

```bash
docker-compose up -d
```

- Laravel will be running on `localhost:8080` by default (see `docker-compose.yml`) to change the port.

Note - Performance may not be incredible, as the entire vendor directory is volume mapped into the container - this is not the most ideal way for this to work, but this setup is just to get going 'quickly'.
