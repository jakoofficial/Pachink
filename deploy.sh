#! /bin/bash

# GET latest version
git pull

# EXPORT client
cd Game
godot Pachink/project.godot --headless --export-release "Web" ../client-docker/export/index.html
cd ..

docker-compose build
docker-compose up -d