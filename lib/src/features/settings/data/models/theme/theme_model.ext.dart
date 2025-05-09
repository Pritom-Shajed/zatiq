part of 'theme_model.dart';

extension ThemeProfileExtension on ThemeProfile {
  String get label {
    switch (this) {
      case ThemeProfile.system:
        return 'System Default';
      case ThemeProfile.light:
        return 'Light';
      case ThemeProfile.dark:
        return 'Dark';
    }
  }

  String get icon {
    switch (this) {
      case ThemeProfile.system:
        return AppSvgImages.system;
      case ThemeProfile.light:
        return AppSvgImages.light;
      case ThemeProfile.dark:
        return AppSvgImages.dark;
    }
  }

  bool get isSystem => this == ThemeProfile.system;
  bool get isLight => this == ThemeProfile.light;
  bool get isDark => this == ThemeProfile.dark;

  bool get isNotSystem => !isSystem;
  bool get isNotLight => !isLight;
  bool get isNotDark => !isDark;
}
