import 'package:flutter/material.dart';
import 'package:nya_diary/pages/widgets/alert_message.dart';
import 'package:nya_diary/utils/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedEmoji = '🐱';

  final List<String> _emojiList = ['🐱', '😸', '🙀', '😹', '😻'];

  void showAlert(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => AnimatedAlertMessage(message: message),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 2100), entry.remove);
  }

  void _submitDiary() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      showAlert(context, '내용을 입력해 주세요! 🐾');
      return;
    }

    final entry = '$_selectedEmoji $text';
    await DiaryStorage.saveEntry(entry);

    showAlert(context, 'Meowmorized! 🐾');

    _controller.clear();
    setState(() {
      _selectedEmoji = '🐱';
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 빈 공간도 터치 감지
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 140),
            Center(
              child: Text(
                'How was your day?',
                style: textStyle.headlineLarge?.copyWith(
                  color: color.secondary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 23,
                children: _emojiList.map((emoji) {
                  final bool isSelected = _selectedEmoji == emoji;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = emoji;
                      });
                    },
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      tween: Tween<double>(
                        begin: isSelected ? 1.0 : 1.0,
                        end: isSelected ? 1.3 : 1.0,
                      ),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Text(
                                emoji,
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: 310, // 👉 가로 폭 고정 (필요시 더 줄여도 됨)
                child: TextField(
                  controller: _controller,
                  maxLength: 50,
                  minLines: 1, // 👉 세로로 더 넓게
                  maxLines: 5, // 선택사항
                  cursorColor: color.surface,
                  style: TextStyle(
                    color: color.surface,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Meow your thoughts...',
                    hintStyle: TextStyle(
                      color: color.surface,
                      fontStyle: FontStyle.italic,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color.surface, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color.surface, width: 2.3),
                    ),
                    filled: true,
                    fillColor: color.primary,
                    counterStyle: TextStyle(color: color.surface),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14, // 👉 세로 패딩도 증가
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100, // ⬅ 원하는 원 크기
                height: 100,
                child: FilledButton(
                  onPressed: _submitDiary,
                  style: FilledButton.styleFrom(
                    backgroundColor: color.surface,
                    foregroundColor: color.onSurface,
                    overlayColor: color.primary, // 눌렀을 때 색상
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  child: const Text("Meow it!"), // ⬅ 텍스트만
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
