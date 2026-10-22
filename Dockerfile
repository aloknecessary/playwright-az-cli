# Base image: Microsoft Playwright (includes Node.js, npm, Playwright, and browsers)
FROM mcr.microsoft.com/playwright:v1.63.0-jammy

# Install Azure CLI
RUN apt-get update \
    && apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg \
    && chmod go+r /etc/apt/keyrings/microsoft.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install -y azure-cli \
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
