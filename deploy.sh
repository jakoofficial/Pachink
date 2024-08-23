#! /bin/bash

# EXPORT client
godot Pachink/project.godot --headless --export-release "Web" ../client-docker/export/index.html

docker-compose build
docker-compose up