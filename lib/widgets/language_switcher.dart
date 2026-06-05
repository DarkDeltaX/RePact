import 'package:flutter/material.dart';
import '../app_language.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  static const _languages = [
    {'code': 'en', 'label': 'English', 'flag': '🇬🇧'},
    {'code': 'nl', 'label': 'Nederlands', 'flag': '🇳🇱'},
    {'code': 'ar', 'label': 'العربية', 'flag': '🇪🇬'},
  ];

  @override
  Widget build(BuildContext context) {
    final lang = AppLanguageProvider.of(context);
    final theme = Theme.of(context);
    final current = _languages.firstWhere(
      (l) => l['code'] == lang.locale,
      orElse: () => _languages.first,
    );

    return PopupMenuButton<String>(
      tooltip: lang.t('change_language'),
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.18),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(current['flag']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              current['code']!.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => _languages
          .map(
            (lang) => PopupMenuItem<String>(
              value: lang['code'],
              child: Row(
                children: [
                  Text(lang['flag']!, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Text(
                    lang['label']!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onSelected: (code) => lang.setLocale(code),
    );
  }
}
