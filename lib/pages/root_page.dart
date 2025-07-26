import 'package:flutter/material.dart';
import 'package:nya_diary/pages/home_page.dart';
import 'package:nya_diary/pages/record_page.dart';
import 'package:nya_diary/pages/widgets/settings_drawer.dart';

class RootPage extends StatefulWidget {
  final void Function(ThemeData) onThemeChange;

  const RootPage({super.key, required this.onThemeChange});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = [const HomePage(), const RecordPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: color.primary,
      appBar: AppBar(
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        title: Text(
          'Nya Diary',
          style: textStyle.titleMedium?.copyWith(
            color: color.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: SettingsDrawer(
        onThemeChange: widget.onThemeChange,
        onTabChange: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color.primary,
        selectedItemColor: color.secondary,
        unselectedItemColor: color.onPrimary,
        selectedLabelStyle: textStyle.labelLarge?.copyWith(
          color: color.secondary,
        ),
        unselectedLabelStyle: textStyle.labelLarge?.copyWith(
          color: color.onPrimary,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '기록'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
