# Rust Development Environment
FROM rust:latest

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

# Copy certificates for secure connections
COPY *.crt /usr/local/share/ca-certificates/ksu-certificates.crt
RUN update-ca-certificates

# Install useful Rust tools for development
RUN cargo install \
    cargo-watch \
    cargo-edit

# Create a working directory
WORKDIR /workspace

# Set up a non-root user for development
RUN useradd -m -u 1000 -s /bin/bash rustdev \
    && chown -R rustdev:rustdev /workspace

# Switch to the development user
USER rustdev

# Set environment variables
ENV CARGO_HOME=/home/rustdev/.cargo
ENV RUSTUP_HOME=/home/rustdev/.rustup

# Default command opens a bash shell
CMD ["/bin/bash"]
