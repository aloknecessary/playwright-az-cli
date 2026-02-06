# Playwright + Azure CLI Docker Image

A custom Docker image built on top of the official **Microsoft Playwright** image, with **Azure CLI pre-installed**.  
This image is intended for CI/CD and automation workflows that require browser-based testing along with Azure operations in a single, ready-to-use container.

---

## 🔍 Overview

CI pipelines often spend significant time installing:
- Node.js
- Playwright dependencies and browsers
- Azure CLI

This image removes that overhead by shipping everything pre-baked, allowing pipelines to focus purely on **test execution** and **result handling**.

---

## ✨ What’s Included

- **Microsoft Playwright**
  - Chromium, Firefox, WebKit
  - Required system and browser dependencies
- **Node.js & npm**
  - Version bundled and tested with Playwright
- **Azure CLI**
  - Ready for authentication and Azure resource operations
- **Multi-architecture support**
  - `linux/amd64`
  - `linux/arm64` (Apple Silicon, ARM runners)

---

## 🚀 Why This Image

**Before**
- Install Node
- Install Playwright
- Download browsers
- Install Azure CLI  
→ Repeated on every pipeline run

**After**
- Tooling available immediately
- Pipeline runs tests directly

### Benefits
- Faster CI execution
- Reduced setup complexity
- Deterministic and reproducible environments
- Cleaner workflow YAML files

---

## 🧪 Typical Use Cases

- Playwright end-to-end automation
- GitHub Actions / Azure DevOps / GitLab CI
- Uploading test artifacts to Azure Storage
- Azure-integrated testing and reporting workflows

---

## 🏗️ Image Tags

- Versioned tags (e.g. `1.0.0`)
- `latest` → most recent stable release

Each tag is published as a **multi-architecture manifest**, so Docker automatically pulls the correct image for your platform. Also I am keping a version match against playwright image to avaoid any confusion. You may notice a minor verion difference bcz of maintenance.

---

## 📦 Sample Usage (GitHub Actions)

Below is an example of how this image can be consumed in a GitHub Actions workflow.

```yaml
name: Run Playwright Tests

on:
  workflow_dispatch:

jobs:
  run-tests:
    runs-on: ubuntu-latest

    container:
      image: aloknecessary/playwright-az-cli:latest
      options: --ipc=host --user root

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install project dependencies
        run: npm ci

      - name: Run Playwright tests
        run: npx playwright test --reporter=list,html

      - name: Upload report to Azure Storage
        if: always()
        run: |
          az login --service-principal \
            --username "${{ secrets.AZURE_CLIENT_ID }}" \
            --password "${{ secrets.AZURE_CLIENT_SECRET }}" \
            --tenant "${{ secrets.AZURE_TENANT_ID }}"

          az storage blob upload-batch \
            -d "playwright-reports/${{ github.run_id }}" \
            -s ./playwright-report \
            --connection-string "${{ secrets.AZURE_STORAGE_CONNECTION_STRING }}" \
            --overwrite
