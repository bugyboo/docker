# Node.js Development Environment
FROM node:latest

# Install common development tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        git \
        curl \
        ca-certificates \
        build-essential \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Create a workspace directory for projects
RUN mkdir -p /workspaces

# Set the working directory
WORKDIR /workspaces

# Switch to the node user (already exists in node:latest)
USER node

# Expose port 3000 for typical Node.js apps (optional, can be overridden)
EXPOSE 3000

# Default command (keeps container running and stops quickly on SIGTERM)
CMD ["tail", "-f", "/dev/null"]