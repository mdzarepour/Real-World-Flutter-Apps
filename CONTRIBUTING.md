# Contributing

Thank you for your interest in contributing to **Real-World Flutter Apps**! 🎉

This project is a community-driven collection of real-world applications built with Flutter and released to production.

Contributions are welcome, whether you want to add a new application, update existing information, or improve the project itself.

## Adding a New App

To add a new application:

1. Create a YAML file inside the `apps/` directory.
2. Add the application's logo to the `assets/` directory.
3. Make sure the YAML filename and logo filename follow the same naming convention.

Example:

```text
apps/habitkit.yaml
assets/habitkit_logo.png
```

## Application Data

Use the existing YAML files as examples.

A typical application entry looks like:

```yaml
name: HabitKit
creator: Sebastian Röhl
category: Productivity

flutter:
  status: production

platforms:
  - android
  - ios

stores:
  google_play:
    url: "https://play.google.com/..."
    downloads: "500K+"
    rating: "4.6"
    reviews: "11K"
    size: "30 MB"

  app_store:
    url: "https://apps.apple.com/..."
    rating: "4.9"
    reviews: "2.3K"
    size: "216 MB"

official_website: "https://www.example.com/"

last_verified: 2026-08-19
```

## Data Accuracy

Please make sure submitted information is:

- Based on publicly available information
- Accurate at the time of submission
- Up to date
- Clearly formatted

Store statistics such as downloads, ratings, reviews, and application size change over time.

Always update `last_verified` when verifying application statistics.

## Application Logos

Please use an appropriate application logo and place it in:

```text
assets/
```

Use this naming convention:

```text
<appname>_logo.png
```

## Pull Requests

Before opening a Pull Request:

- Make sure the YAML file is valid.
- Make sure the logo exists.
- Make sure store links are correct.
- Make sure the information is accurate.
- Run the README generator locally:

```bash
dart pub get
dart run scripts/generate_readme.dart
```

## Updating an Existing App

If information about an existing application becomes outdated, you can update its YAML file and submit a Pull Request.

Examples include:

- Download count
- Rating
- Review count
- Application size
- Store links
- Official website
- Application status

Remember to update:

```yaml
last_verified: YYYY-MM-DD
```

## Issues

If you find incorrect information or have an idea for improving the repository, feel free to open an Issue.

Please provide enough information for the issue to be verified.

## Automated README Generation

The README is generated automatically from the application YAML files.

Do not manually edit the generated application table in `README.md`.

Changes to application data should be made in:

```text
apps/
```
