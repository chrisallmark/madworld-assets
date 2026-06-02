# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A dedicated asset and infrastructure repository for the [madworld](https://github.com/chrisallmark/madworld) application. It contains audio/video media files and Terraform code to publish them to AWS S3. There is no application source code, no package.json, and no test suite.

The consuming app expects this repo checked out as `public/assets`. **Do not rename or move existing asset files** without updating downstream references in the main application.

## Terraform commands

Run from the repository root using `-chdir=terraform`, or from inside `terraform/`.

```bash
terraform -chdir=terraform fmt        # format HCL files
terraform -chdir=terraform validate   # validate syntax (requires prior init)
terraform -chdir=terraform plan       # preview changes to bucket, CORS, objects
terraform -chdir=terraform apply      # provision S3 and upload assets
```

Before first deploy: create `terraform/terraform.tfvars` with a unique `bucket` value and allowed CORS `origins`. Then run `terraform -chdir=terraform init`.

## Asset directories

- `tracks/` — music MP3s (~20 files)
- `samples/` — commentary/dialogue clips (~497 files)
- `extras/` — supplementary audio (~7 files)
- `videos/` — runtime video assets

Use title-style filenames with correct extensions (e.g. `tracks/Move by Ox.mp3`).

## Architecture

Terraform uses `aws_s3_object` resources with MD5 hash tracking for change detection. The S3 bucket uses a private ACL with per-object public-read, and GET-only CORS whitelisting configurable via `variables.tf`. Default allowed origins: `http://madworld.local` and `https://mad-world.vercel.app`.

The consuming app switches between local assets (submodule) and S3 (production) via environment variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_BUCKET`, `AWS_REGION` (default `eu-west-1`).

## Commit style

Conventional Commits: `chore: add samples`, `fix: correct terraform cors`, etc.

PR descriptions should list added/removed/renamed assets, Terraform changes, and links to related application changes.

## What not to commit

`.terraform/`, `*.tfstate*`, `*.tfvars`, AWS credentials, or bucket names.
