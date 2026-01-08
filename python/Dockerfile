# Python Development Environment
FROM python:latest

# Install additional development tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    pkg-config \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy ca-certificates for secure connections
COPY *.crt /usr/local/share/ca-certificates/ksu-certificates.crt
RUN update-ca-certificates

# Install Poetry for dependency management
RUN curl -sSL https://install.python-poetry.org | python3 -

# Install Poetry 
RUN pip install poetry

# Install PyInstaller for creating executables
RUN pip install pyinstaller

# Create a working directory
WORKDIR /workspace

# Set up a non-root user for development
RUN useradd -m -u 1000 -s /bin/bash pythondev \
    && chown -R pythondev:pythondev /workspace

# Switch to the development user
USER pythondev

# Set environment variables
ENV PATH="/home/pythondev/.local/bin:$PATH"

# Default command opens a bash shell
CMD ["/bin/bash"]
