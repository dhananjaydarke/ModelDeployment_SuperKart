

#!/bin/bash
# Remove previous containers using these names, if present
docker rm -f backend superkart-frontend 2>/dev/null || true

# Create the shared network if it doesn't already exist
docker network inspect superkart-net >/dev/null 2>&1 || docker network create superkart-net

# Build both images
docker build -t superkart-backend ./backend
docker build -t superkart-frontend ./frontend

# Start the backend, then the frontend
docker run -d --name backend -p 7860:7860 superkart-backend
docker run -d --name superkart-frontend --add-host=backend:host-gateway -p 8501:8501 superkart-frontend
