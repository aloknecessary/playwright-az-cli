# Base image: Microsoft Playwright (includes Node.js, npm, Playwright, and browsers)
FROM mcr.microsoft.com/playwright:v1.62.1-jammy

# Install AWS CLI v2
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       unzip \
       gnupg \
    && ARCH="$(dpkg --print-architecture)" \
    && case "$ARCH" in \
         amd64) AWS_ARCH="x86_64" ;; \
         arm64) AWS_ARCH="aarch64" ;; \
         *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
       esac \
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o /tmp/awscliv2.zip \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip \
    && rm -rf /var/lib/apt/lists/*

# Verify installations at build time
RUN node --version \
    && npm --version \
    && npx playwright --version \
    && aws --version

# Set default working directory
WORKDIR /app

# Keep container ready for CI usage
# (Project code will be mounted/copied by the pipeline)
