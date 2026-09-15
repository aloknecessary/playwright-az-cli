# Playwright + AWS CLI Docker Image

A custom Docker image built on top of the official Microsoft Playwright image, with AWS CLI v2 pre-installed.
This image is designed for CI/CD pipelines and automation workflows that require browser-based testing along with AWS operations in a single container.

---

## ✨ What’s Included

- **Microsoft Playwright**
  - Chromium, Firefox, and WebKit browsers
  - Required system and browser dependencies
- **Node.js & npm**
  - Version bundled and tested with Playwright
- **AWS CLI v2**
  - Ready for authentication, deployments, and AWS resource operations
- **Multi-architecture support**
  - `linux/amd64`
  - `linux/arm64` (Apple Silicon, ARM runners)

---

## 🚀 Why This Image

Traditionally, CI pipelines install Node.js, Playwright browsers, and AWS CLI during every run.
This image removes that overhead by shipping everything pre-installed.

**Benefits:**

- Faster pipeline startup times
- Reduced setup complexity
- More consistent and reproducible test runs
- Cleaner CI configuration with fewer repeated installs

---

## 🧪 Typical Use Cases

- Playwright end-to-end test automation
- CI/CD pipelines (GitHub Actions, AWS CodeBuild, GitLab CI)
- Uploading test artifacts or reports to Amazon S3
- AWS-integrated test and deployment workflows
- ECR image pushes and AWS deployment automation

---

## 🏗️ Image Tags

- Versioned tags (for example, `1.0.0`)
- `latest` – points to the most recent stable release

Each tag is published as a **multi-architecture manifest**, so Docker automatically pulls the correct image for your platform. I also keep the version aligned with the Playwright base image to reduce confusion. You may notice a minor version difference because of active maintenance.

---

## 🔐 Security & Vulnerabilities

This image includes a full browser stack, which can produce vulnerability reports from scanners.
Most reported CVEs come from browser and operating-system dependencies included by Playwright.

The image is intended for **CI/CD and test automation**, not long-running production workloads.
Base images are updated regularly to pick up upstream security fixes.

---

## 📦 Source & Maintenance

- **Source repository:** <https://github.com/aloknecessary/playwright-az-cli>
- Built and maintained by **aloknecessary**
- Based on the official Microsoft Playwright Docker images

---

## 📄 License

This image follows the licensing terms of:

- Microsoft Playwright
- Ubuntu
- AWS CLI

Refer to the upstream projects for detailed license information.
