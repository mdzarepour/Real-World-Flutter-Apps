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

  final buffer = StringBuffer();

  buffer.writeln('# Real-World Flutter Apps\n');

  buffer.writeln(
    'A curated collection of ${apps.length} real-world applications built with Flutter.\n',
  );

  final appCount = apps.length;
  final appLabel = appCount == 1 ? 'App' : 'Apps';
  buffer.writeln('📱 **$appCount $appLabel**\n');

  buffer.writeln('| App | Creator | Category | Android | iOS |');
  buffer.writeln('|---|---|---|---|---|');

  for (final app in apps) {
    final android = app['android'] != null
        ? '[Android](${app['android']})'
            '<br>📥 ${app['androidDownloads'] ?? '-'}'
            '<br>⭐ ${app['androidRating'] ?? '-'}'
            '<br>💬 ${app['androidReviews'] ?? '-'}'
            '<br>📦 ${app['androidSize'] ?? '-'}'
        : '-';

    final ios = app['ios'] != null
        ? '[iOS](${app['ios']})'
            '<br>⭐ ${app['iosRating'] ?? '-'}'
            '<br>💬 ${app['iosReviews'] ?? '-'}'
            '<br>📦 ${app['iosSize'] ?? '-'}'
        : '-';

    final logo = '<img src="${app['logo']}" width="50">';

    buffer.writeln(
      '| $logo ${app['name']} | ${app['creator']} | ${app['category']} | $android | $ios |',
    );
  }

  File('README.md').writeAsStringSync(buffer.toString());

  print('README generated successfully.');
}
