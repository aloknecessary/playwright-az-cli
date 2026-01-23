# Base image: Microsoft Playwright (includes Node.js, npm, Playwright, and browsers)
FROM mcr.microsoft.com/playwright:v1.57.0-jammy

# Install Azure CLI
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    apt-transport-https \
    lsb-release \
    gnupg \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*

# Optional: verify installations at build time
RUN node --version \
    && npm --version \
    && npx playwright --version \
    && az --version

# Set default working directory
WORKDIR /app

# Keep container ready for CI usage
# (Project code will be mounted/copied by the pipeline)
