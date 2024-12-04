#!/bin/bash

# Start the Client Portal Gateway
cd gateway && sh bin/run.sh root/conf.yaml &

# Start the Flask application
cd /app/webapp
flask --app app run --debug -p 5056 -h 0.0.0.0