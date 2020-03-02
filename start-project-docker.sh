#!/bin/bash

if [[ -d ./app ]]
    then
        echo "Refusing to run script as ./app directory already exists"
        exit 1
fi

echo "Building Laravel Builder image"
docker build -t laravel-builder -f ./docker/builder/Dockerfile ./

echo "Running Laravel Builder to collect latest version of Laravel"
docker run --rm -d --name laravel-builder laravel-builder > /dev/null

echo "Collecting Laravel"
docker cp laravel-builder:/tmp/laravel.tar.gz ./
docker kill laravel-builder > /dev/null
tar xo -f laravel.tar.gz > /dev/null

echo "Cleaning up"
rm laravel.tar.gz > /dev/null
docker rmi laravel-builder > /dev/null

echo "Done!"