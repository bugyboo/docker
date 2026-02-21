# Use Ubuntu as base for good GUI support
FROM ubuntu:22.04

# Install dependencies for running GUI apps via X11, wget for downloading, and xz-utils for extraction
RUN apt-get update && apt-get install -y \
    wget xz-utils libdbus-glib-1-2 libgtk-3-0 libxt6 libnss3 libpango-1.0-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libasound2 \
    x11-apps mesa-utils libgl1-mesa-glx libglu1-mesa \
    && rm -f /usr/bin/firefox \
    && wget -O firefox.tar.xz "https://ftp.mozilla.org/pub/firefox/releases/147.0.4/linux-x86_64/en-US/firefox-147.0.4.tar.xz" \
    && echo "fdafe715d3b3ee406e306a27fd91f3e8bdee2fd35c1b3834df6c9134be6265ca  firefox.tar.xz" | sha256sum -c - \
    && tar xJf firefox.tar.xz -C /opt/ \
    && ln -s /opt/firefox/firefox /usr/local/bin/firefox \
    && rm firefox.tar.xz \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for running apps (matches host UID/GID for file sharing if needed)
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} appuser && useradd -u ${USER_ID} -g ${GROUP_ID} -m appuser

# Set up entrypoint for bash shell
USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/bin/bash"]