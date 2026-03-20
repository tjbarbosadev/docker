# Use the official Bun image as the base image
FROM oven/bun:1 AS builder

# Set the working directory
WORKDIR /usr/src/app

# Install dependencies and build the application
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the application (if needed, otherwise this step can be skipped)
EXPOSE 3333

# Start the application
CMD ["bun", "run", "src/index.ts"]