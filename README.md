# Real-World Flutter Apps

> A curated, community-driven collection of real-world applications built with Flutter and shipped to production.

The goal of this project is to document the growing Flutter ecosystem through publicly available production applications.

---

## 📊 Statistics

| Metric | Value |
|---|---:|
| Applications | **1 App** |
| Categories | **1** |

---

## 📱 Applications

<table width="100%">
<thead>
<tr>
<th width="7%">Logo</th>
<th width="15%">App</th>
<th width="15%">Creator</th>
<th width="13%">Category</th>
<th width="10%">Flutter</th>
<th width="20%">Android</th>
<th width="20%">iOS</th>
</tr>
</thead>
<tbody>

<tr>
<td align="center"><img src="assets/habitkit_logo.png" width="50"></td>
<td>
<strong>HabitKit</strong>
<br>
<a href="https://www.habitkit.app/">Website</a>
</td>
<td>Sebastian Röhl</td>
<td>Productivity</td>
<td>production</td>
<td><a href="https://play.google.com/store/apps/details?id=com.roehl.habitkit">Android</a>
<br>📥 500K+
<br>⭐ 4.6
<br>💬 11K
<br>📦 30 Mb
</td>
<td><a href="https://apps.apple.com/us/app/habit-tracker-habitkit/id6443918070">iOS</a>
<br>⭐ 4.9
<br>💬 2.3K
<br>📦 216 MB
</td>
</tr>

</tbody>
</table>


---

## 🏷️ Categories

- **Productivity** — 1 app

---

## 🗂️ Project Structure

```text
real-world-flutter-apps/
│
├── apps/
│   └── <app-name>.yaml
│
├── assets/
│   └── <app-name>_logo.png
│
├── data/
│   └── apps.json
│
├── scripts/
│   └── generate_readme.dart
│
├── .github/
│   └── workflows/
│       └── generate-readme.yml
│
├── README.md
├── CONTRIBUTING.md
├── LICENSE
└── pubspec.yaml
```


---

## 🧩 Data Model

Each application is represented by a YAML file inside the `apps/` directory.

**Example:**
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

official_website: "https://www.habitkit.app/"

last_verified: 2026-08-19
```


---

## ⚙️ Automation

The README is generated automatically from the structured application data.

When application data changes and is pushed to the main branch:

```text
Application YAML
       ↓
GitHub Actions
       ↓
Dart Generator
       ↓
README.md
       ↓
Automatic Commit
```

This keeps the README synchronized with the underlying dataset without requiring manual table updates.


---

## 🤝 Contributing

Contributions are welcome. You can contribute by:

- Adding a real-world Flutter application
- Updating existing application information
- Correcting outdated statistics
- Improving the generator
- Improving documentation

Before submitting a contribution, make sure the information is based on publicly available sources and that store statistics include an appropriate verification date.

See `CONTRIBUTING.md` for contribution guidelines.


---

## 📋 Data Guidelines

The project aims to keep application data:

- Structured
- Reproducible
- Easy to update
- Machine-readable
- Human-readable

Statistics such as downloads, ratings, reviews, and application size are snapshots and may change over time.


---

## ⚠️ Disclaimer

This repository is a community-maintained collection of publicly available information.

Application statistics may change over time and should not be considered permanent values.

Listing an application does not imply endorsement by its developer, company, Google, Apple, or the Flutter team.


---

## 📜 License

This project is licensed under the MIT License.
