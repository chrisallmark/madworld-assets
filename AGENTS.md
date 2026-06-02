# Repository Guidelines

## Project Structure & Module Organization

This repository stores runtime assets for the `madworld` application. Keep files in the existing top-level asset folders:

- `extras/`: additional audio clips.
- `samples/`: commentary sample MP3s.
- `tracks/`: music tracks.
- `videos/`: runtime video assets.
- `terraform/`: AWS S3 infrastructure used to publish the assets.

There is no application source tree or unit test suite here. The consuming app expects this repository to be checked out as `public/assets`, so preserve relative paths unless the app is updated at the same time.

## Build, Test, and Development Commands

Run Terraform commands from the repository root with `-chdir=terraform`, or from inside `terraform/`.

- `terraform -chdir=terraform fmt`: format Terraform files.
- `terraform -chdir=terraform validate`: validate Terraform syntax and provider configuration after `terraform init`.
- `terraform -chdir=terraform plan`: preview bucket, CORS, and uploaded object changes.
- `terraform -chdir=terraform apply`: provision infrastructure and publish current assets to S3.

Before deploying, create `terraform/terraform.tfvars` with a unique `bucket` and allowed CORS origins. Do not commit `.tfvars` or state files.

## Coding Style & Naming Conventions

Use two-space indentation in Terraform, matching the existing files. Keep resource names descriptive and scoped to `madworld`. For assets, use clear title-style filenames with the correct extension, such as `tracks/Move by Ox.mp3`. Avoid renaming existing files unless you have verified all downstream references in the main application.

## Testing Guidelines

For infrastructure changes, run `terraform -chdir=terraform fmt` and `terraform -chdir=terraform validate`. Use `terraform -chdir=terraform plan` to confirm object additions, removals, and CORS changes before applying. For media changes, verify files open locally and are not corrupt before committing.

## Commit & Pull Request Guidelines

Recent history uses short Conventional Commit-style messages, for example `chore: migrate madworld assets`. Prefer `chore: add samples`, `fix: correct terraform cors`, or similar concise subjects.

Pull requests should include a summary of added, removed, or renamed assets; any Terraform changes; deployment impact; and links to related application changes. Include screenshots only when video or visual behavior changes need review.

## Security & Configuration Tips

Never commit AWS credentials, `terraform.tfvars`, `.terraform/`, or `*.tfstate*`. Keep production bucket names and secrets in deployment configuration, not in this repository.
