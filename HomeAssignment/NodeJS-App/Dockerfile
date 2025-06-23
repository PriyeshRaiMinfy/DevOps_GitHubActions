# Use an official Node.js image
# FROM node:18

# # Set working directory
# WORKDIR /app

# # Copy package files
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy source code
# COPY . .

# # Expose app port
# EXPOSE 3000

# # Start the application
# CMD ["node", "server.js"]

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy only package files first to cache dependencies
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy entire project into container
COPY . .

# Expose port 3000 to outside the container
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
