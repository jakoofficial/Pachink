#! /bin/bash

# GET latest version
git pull

# EXPORT client
godot Pachink/project.godot --headless --export-release "Web" ../client-docker/export/index.html

docker-compose build
docker-compose up -d