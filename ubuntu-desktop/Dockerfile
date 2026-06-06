# Use current Ubuntu LTS as base for good GUI support
FROM ubuntu:24.04

# Install dependencies for running GUI apps via X11 plus tools for secure Firefox download
RUN apt-get update && apt-get install -y \
    wget curl ca-certificates xz-utils python3 python3-pip python3-venv \
    libdbus-glib-1-2 libgtk-3-0 libxt6 libnss3 libpango-1.0-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libasound2t64 \
    x11-apps mesa-utils libgl1 libglu1-mesa \
    && FIREFOX_VERSION="$(curl -fsSL https://product-details.mozilla.org/1.0/firefox_versions.json | sed -n 's/.*"LATEST_FIREFOX_VERSION"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')" \
    && [ -n "${FIREFOX_VERSION}" ] \
    && wget -O firefox.tar.xz "https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.xz" \
    && wget -O firefox.sha256 "https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/SHA256SUMS" \
    && FIREFOX_SHA256="$(awk -v v="${FIREFOX_VERSION}" '$2=="linux-x86_64/en-US/firefox-" v ".tar.xz" { print $1; exit }' firefox.sha256)" \
    && [ -n "${FIREFOX_SHA256}" ] \
    && echo "${FIREFOX_SHA256}  firefox.tar.xz" | sha256sum -c - \
    && tar xJf firefox.tar.xz -C /opt/ \
    && ln -s /opt/firefox/firefox /usr/local/bin/firefox \
    && rm firefox.tar.xz firefox.sha256 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for running apps (matches host UID/GID for file sharing if needed)
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN set -eux; \
    if getent group "${GROUP_ID}" >/dev/null; then \
        EXISTING_GROUP="$(getent group "${GROUP_ID}" | cut -d: -f1)"; \
    else \
        groupadd -g "${GROUP_ID}" appuser; \
        EXISTING_GROUP=appuser; \
    fi; \
    if getent passwd "${USER_ID}" >/dev/null; then \
        EXISTING_USER="$(getent passwd "${USER_ID}" | cut -d: -f1)"; \
        usermod -l appuser -d /home/appuser -m "${EXISTING_USER}" || true; \
        usermod -g "${EXISTING_GROUP}" appuser; \
    elif id -u appuser >/dev/null 2>&1; then \
        usermod -u "${USER_ID}" -g "${EXISTING_GROUP}" appuser; \
    else \
        useradd -u "${USER_ID}" -g "${EXISTING_GROUP}" -m appuser; \
    fi

# Set up entrypoint for bash shell
USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/bin/bash"]