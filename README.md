# Playwright + AWS CLI Docker Image

A custom Docker image built on top of the official **Microsoft Playwright** image, with **AWS CLI v2 pre-installed**.  
This image is intended for CI/CD and automation workflows that require browser-based testing along with AWS operations in a single, ready-to-use container.

---
[![Build and Push Playwright + AWS CLI Image](https://github.com/aloknecessary/playwright-az-cli/actions/workflows/docker-publish.yml/badge.svg?branch=aws)](https://github.com/aloknecessary/playwright-az-cli/actions/workflows/docker-publish.yml?branch=aws)
---

## 🔍 Overview

CI pipelines often spend significant time installing:
- Node.js
- Playwright dependencies and browsers
- AWS CLI

This image removes that overhead by shipping everything pre-baked, allowing pipelines to focus purely on **test execution** and **result handling**.

---

## ✨ What’s Included

- **Microsoft Playwright**
  - Chromium, Firefox, WebKit
  - Required system and browser dependencies
- **Node.js & npm**
  - Version bundled and tested with Playwright
- **AWS CLI v2**
  - Ready for authentication and AWS resource operations
- **Multi-architecture support**
  - `linux/amd64`
  - `linux/arm64` (Apple Silicon, ARM runners)

---

## 🚀 Why This Image

**Before**
- Install Node
- Install Playwright
- Download browsers
- Install AWS CLI  
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
- GitHub Actions / AWS CodeBuild / GitLab CI
- Uploading test artifacts to Amazon S3
- AWS-integrated testing and reporting workflows
- ECR image pushes and AWS deployment automation

---

## 🏗️ Image Tags

- Versioned tags (e.g. `1.0.0`)
- `latest` → most recent stable release

Each tag is published as a **multi-architecture manifest**, so Docker automatically pulls the correct image for your platform. Also, I keep a version match against the Playwright image to avoid confusion. However you may notice a minor version difference because of active maintenance.

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
      image: aloknecessary/playwright-aws-cli:latest
      options: --ipc=host --user root

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install project dependencies
        run: npm ci

      - name: Run Playwright tests
        run: npx playwright test --reporter=list,html

      - name: Upload report to S3
        if: always()
        run: |
          aws configure set aws_access_key_id "${{ secrets.AWS_ACCESS_KEY_ID }}"
          aws configure set aws_secret_access_key "${{ secrets.AWS_SECRET_ACCESS_KEY }}"
          aws configure set default.region "${{ secrets.AWS_REGION }}"

          aws s3 cp ./playwright-report "s3://your-bucket/playwright-reports/${{ github.run_id }}/" --recursive
