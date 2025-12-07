# Movie Review Starter API
This is the starter application for the DevOps project.

## Running application
```bash
# Check node and npm versions
node -v
npm -v

# Install dependencies
npm install

# run server
npm start

# run tests
npm test

# dev mode with nodemon
npm run dev
```

## Testing endpoints
```bash
# GET /movies - Returns list of movies
xh http://127.0.0.1:8080/movies

# POST /movies - Adds a movie
xh post http://localhost:8080/movies title="Avatar 2" rating:=4
xh http://127.0.0.1:8080/movies

# GET /health - For Kubernetes probes
xh get http://localhost:8080/health
```