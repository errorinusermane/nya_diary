import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nya_diary/pages/lock_page.dart';
import 'package:nya_diary/pages/widgets/about_dialog.dart';
import 'package:nya_diary/theme/light_theme.dart';
import 'package:nya_diary/theme/dark_theme.dart';
import 'package:nya_diary/utils/storage.dart';

class SettingsDrawer extends StatelessWidget {
  final void Function(ThemeData) onThemeChange;
  final void Function(int) onTabChange;

  const SettingsDrawer({
    super.key,
    required this.onThemeChange,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: color.surface,
      child: Column(
        children: [
          const SizedBox(height: 210),
          Center(
            child: Text(
              'M E N U',
              style: textStyle.headlineMedium?.copyWith(
                color: color.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Divider(color: color.onPrimary, thickness: 1.2),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: color.onPrimary,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  ListTile(
                    leading: Icon(Icons.light_mode, color: color.onSurface),
                    title: _menuLabel('L I G H T', textStyle, color),
                    onTap: () {
                      onThemeChange(lightTheme);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode, color: color.onSurface),
                    title: _menuLabel('D A R K', textStyle, color),
                    onTap: () {
                      onThemeChange(darkTheme);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 40),
                  ListTile(
                    leading: Icon(Icons.delete, color: color.onSurface),
                    title: _menuLabel('C L E A R  A L L', textStyle, color),
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('기록 전체 삭제'),
                          content: const Text('모든 일기를 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('삭제'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        await DiaryStorage.clearEntries();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('기록이 모두 삭제되었습니다.')),
                        );
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, color: color.onSurface),
                    title: _menuLabel('A B O U T', textStyle, color),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => const CustomAboutDialog(),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  ListTile(
                    leading: Icon(Icons.close, color: color.onSurface),
                    title: _menuLabel('B Y E', textStyle, color),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) =>
                              LockPage(onThemeChange: onThemeChange),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuLabel(String text, TextTheme textStyle, ColorScheme color) {
    return Text(
      text,
      style: textStyle.bodyLarge?.copyWith(
        color: color.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
