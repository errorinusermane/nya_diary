import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nya_diary/pages/root_page.dart';

class LockPage extends StatefulWidget {
  final void Function(ThemeData) onThemeChange;

  const LockPage({super.key, required this.onThemeChange});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  String _input = '';
  String? _errorText;
  static const int maxLength = 4;

  Future<void> _submit() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPassword = prefs.getString('app_password') ?? '0000';

    if (_input == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RootPage(onThemeChange: widget.onThemeChange),
        ),
      );
    } else {
      setState(() {
        _errorText = '비밀번호가 틀렸어요';
        _input = '';
      });
    }
  }

  void _onPressed(String value) async {
    if (_input.length >= maxLength) return;

    setState(() {
      _input += value;
    });

    if (_input.length == maxLength) {
      await Future.delayed(const Duration(milliseconds: 100));
      _submit();
    }
  }

  void _onBackspace() {
    if (_input.isNotEmpty) {
      setState(() {
        _input = _input.substring(0, _input.length - 1);
      });
    }
  }

  Widget _buildKey(String value, {VoidCallback? onTap}) {
    final color = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap ?? () => _onPressed(value),
      child: Center(
        child: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: color.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text(
              'Enter Your Code',
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(maxLength, (index) {
                final filled = index < _input.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? color.primary : Colors.transparent,
                    border: Border.all(color: color.outline, width: 1.5),
                  ),
                );
              }),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(_errorText!, style: TextStyle(color: color.error)),
              ),
            const Spacer(),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1.3,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildKey('1'),
                _buildKey('2'),
                _buildKey('3'),
                _buildKey('4'),
                _buildKey('5'),
                _buildKey('6'),
                _buildKey('7'),
                _buildKey('8'),
                _buildKey('9'),
                const SizedBox.shrink(),
                _buildKey('0'),
                _buildKey('←', onTap: _onBackspace),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
