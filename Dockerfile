# Use Node.js image
FROM node:18

# Set memory limit for Node.js during the build
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Set working directory
WORKDIR /app

# Copy dependency files and install
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose port (adjust if needed)
EXPOSE 5173

# Start the server
CMD ["npm", "run", "dev"]


# Build the Docker image
# docker build -t my-calc-image .
# Run the Docker container
# docker run -d -p 5173:5173 my-calc-image