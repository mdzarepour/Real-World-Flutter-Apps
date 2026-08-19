import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final appsDirectory = Directory('apps');
  final apps = <Map<String, dynamic>>[];

  for (final file in appsDirectory.listSync()) {
    if (file is! File || !file.path.endsWith('.yaml')) {
      continue;
    }

    final content = file.readAsStringSync();
    final data = loadYaml(content);

    final fileName = file.uri.pathSegments.last.replaceFirst('.yaml', '');

    apps.add({
      'name': data['name'],
      'creator': data['creator'],
      'category': data['category'],
      'flutterStatus': data['flutter']?['status'],
      'officialWebsite': data['official_website'],
      'logo': 'assets/${fileName}_logo.png',
      'android': data['stores']?['google_play']?['url'],
      'androidDownloads': data['stores']?['google_play']?['downloads'],
      'androidRating': data['stores']?['google_play']?['rating'],
      'androidReviews': data['stores']?['google_play']?['reviews'],
      'androidSize': data['stores']?['google_play']?['size'],
      'ios': data['stores']?['app_store']?['url'],
      'iosRating': data['stores']?['app_store']?['rating'],
      'iosReviews': data['stores']?['app_store']?['reviews'],
      'iosSize': data['stores']?['app_store']?['size'],
    });
  }

  apps.sort(
    (a, b) => a['name'].toString().compareTo(b['name'].toString()),
  );

  final categories =
      apps.map((app) => app['category'].toString()).toSet().toList()..sort();

  final buffer = StringBuffer();

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  buffer.writeln('# Real-World Flutter Apps\n');

  buffer.writeln(
    '> A curated, community-driven collection of real-world applications '
    'built with Flutter and shipped to production.\n',
  );

  buffer.writeln(
    'The goal of this project is to document the growing Flutter ecosystem '
    'through publicly available production applications.\n',
  );

  buffer.writeln('---\n');

  // ---------------------------------------------------------------------------
  // Statistics
  // ---------------------------------------------------------------------------

  final appCount = apps.length;
  final appLabel = appCount == 1 ? 'App' : 'Apps';

  buffer.writeln('## 📊 Statistics\n');

  buffer.writeln('| Metric | Value |');
  buffer.writeln('|---|---:|');
  buffer.writeln('| Applications | **$appCount $appLabel** |');
  buffer.writeln('| Categories | **${categories.length}** |');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Applications
  // ---------------------------------------------------------------------------

  buffer.writeln('## 📱 Applications\n');

  buffer.writeln('<table width="100%">');

  buffer.writeln('''
<thead>
<tr align="center">
  <th width="8%">Logo</th>
  <th width="20%">App</th>
  <th width="16%">Creator</th>
  <th width="14%">Category</th>
  <th width="10%">Status</th>
  <th width="16%">Google Play</th>
  <th width="16%">App Store</th>
</tr>
</thead>
<tbody>
''');

  for (final app in apps) {
    final android = app['android'] != null
        ? '''
<a href="${app['android']}"><b>GET IT ON Play Store</b></a><br>
<small>
📥 ${app['androidDownloads'] ?? '-'}<br>
⭐ ${app['androidRating'] ?? '-'} (${app['androidReviews'] ?? '-'})<br>
📦 ${app['androidSize'] ?? '-'}
</small>
'''
        : '-';

    final ios = app['ios'] != null
        ? '''
<a href="${app['ios']}"><b>Download on App Store</b></a><br>
<small>
⭐ ${app['iosRating'] ?? '-'} (${app['iosReviews'] ?? '-'})<br>
📦 ${app['iosSize'] ?? '-'}
</small>
'''
        : '-';

    final logo =
        '<img src="${app['logo']}" width="48" height="48" style="border-radius: 10px; object-fit: cover;">';

    final flutterStatus = app['flutterStatus'] != null
        ? '<code>${app['flutterStatus']}</code>'
        : '-';

    final officialWebsite = app['officialWebsite'] != null
        ? '<a href="${app['officialWebsite']}"><small>🌐 Website</small></a>'
        : '';

    buffer.writeln('''
<tr valign="top">
  <td align="center">$logo</td>
  <td>
    <strong>${app['name']}</strong>
    ${officialWebsite.isNotEmpty ? '<br>$officialWebsite' : ''}
  </td>
  <td>${app['creator'] ?? '-'}</td>
  <td><code>${app['category']}</code></td>
  <td align="center">$flutterStatus</td>
  <td>$android</td>
  <td>$ios</td>
</tr>
''');
  }

  buffer.writeln('''
</tbody>
</table>
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Categories
  // ---------------------------------------------------------------------------

  buffer.writeln('## 🏷️ Categories\n');

  for (final category in categories) {
    final count =
        apps.where((app) => app['category'].toString() == category).length;

    final label = count == 1 ? 'app' : 'apps';

    buffer.writeln('- **$category** — $count $label');
  }

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Data Structure
  // ---------------------------------------------------------------------------

  buffer.writeln('## 🗂️ Project Structure\n');

  buffer.writeln('''
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
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Data Model
  // ---------------------------------------------------------------------------

  buffer.writeln('## 🧩 Data Model\n');

  buffer.writeln('''
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
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Automation
  // ---------------------------------------------------------------------------

  buffer.writeln('## ⚙️ Automation\n');

  buffer.writeln('''
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
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Contributing
  // ---------------------------------------------------------------------------

  buffer.writeln('## 🤝 Contributing\n');

  buffer.writeln('''
Contributions are welcome. You can contribute by:

- Adding a real-world Flutter application
- Updating existing application information
- Correcting outdated statistics
- Improving the generator
- Improving documentation

Before submitting a contribution, make sure the information is based on publicly available sources and that store statistics include an appropriate verification date.

See `CONTRIBUTING.md` for contribution guidelines.
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Data Guidelines
  // ---------------------------------------------------------------------------

  buffer.writeln('## 📋 Data Guidelines\n');

  buffer.writeln('''
The project aims to keep application data:

- Structured
- Reproducible
- Easy to update
- Machine-readable
- Human-readable

Statistics such as downloads, ratings, reviews, and application size are snapshots and may change over time.
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // Disclaimer
  // ---------------------------------------------------------------------------

  buffer.writeln('## ⚠️ Disclaimer\n');

  buffer.writeln('''
This repository is a community-maintained collection of publicly available information.

Application statistics may change over time and should not be considered permanent values.

Listing an application does not imply endorsement by its developer, company, Google, Apple, or the Flutter team.
''');

  buffer.writeln('\n---\n');

  // ---------------------------------------------------------------------------
  // License
  // ---------------------------------------------------------------------------

  buffer.writeln('## 📜 License\n');

  buffer.writeln('This project is licensed under the MIT License.');

  // ---------------------------------------------------------------------------
  // Write README
  // ---------------------------------------------------------------------------

  File('README.md').writeAsStringSync(buffer.toString());
  print('README generated successfully.');
}
