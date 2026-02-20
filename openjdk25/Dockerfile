# OpenJDK 25 Development Environment
FROM eclipse-temurin:25-jdk

# Install common development tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        git \
        curl \
        wget \
        ca-certificates \
        build-essential \
        unzip \
        zip \
        vim \
        less \
        jq \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Maven
ARG MAVEN_VERSION=3.9.9
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    | tar -xz -C /opt \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Install Gradle
ARG GRADLE_VERSION=8.12
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o /tmp/gradle.zip \
    && unzip -q /tmp/gradle.zip -d /opt \
    && rm /tmp/gradle.zip \
    && ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
ENV GRADLE_HOME=/opt/gradle
ENV PATH="${GRADLE_HOME}/bin:${PATH}"

# Create a working directory
WORKDIR /workspace

# Set up a non-root user for development (UID 1001 to avoid conflict with existing user)
RUN useradd -m -u 1001 -s /bin/bash javadev \
    && chown -R javadev:javadev /workspace

# Switch to the development user
USER javadev

# Set environment variables
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# Default command (keeps container running and stops quickly on SIGTERM)
CMD ["tail", "-f", "/dev/null"]
