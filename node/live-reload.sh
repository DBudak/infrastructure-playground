#adds live reload
#https://www.npmjs.com/package/nodemon
nodemon ./src/index.js

#Steps to enable live reload:
  # Install nodemon
  # Update package json with start:dev: nodemon ./src/index.js
  # Create dev and prod dockerfiles. dev docker file should not copy codei nto the image
  # npm install on container startup for development mode
  # Update docker compose file to use development docker file
  # Add docker volumes to compose file so source and npm cache are shared with container