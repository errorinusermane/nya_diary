import 'package:flutter/material.dart';
import 'package:nya_diary/utils/storage.dart';
import 'package:nya_diary/pages/widgets/calendar_modal.dart'; // 모달 위젯 import

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  List<String> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    final entries = await DiaryStorage.loadEntries();
    setState(() {
      _entries = entries.reversed.toList(); // 최신 순
    });
  }

  String extractEmoji(String content) {
    final runes = content.runes.toList();
    if (runes.isEmpty) return '';
    final emoji = String.fromCharCodes(runes.take(2));
    return emoji;
  }

  void _showCalendarModal(BuildContext context) {
    final entryCountByDate = <DateTime, int>{};

    for (final entry in _entries) {
      final parts = entry.split('|');
      if (parts.length < 2) continue;

      final dateStr = parts[0];

      try {
        final date = DateTime.parse(dateStr);
        final normalizedDate = DateTime(date.year, date.month, date.day);

        entryCountByDate.update(
          normalizedDate,
          (count) => count + 1,
          ifAbsent: () => 1,
        );
      } catch (_) {}
    }

    showDialog(
      context: context,
      builder: (_) => CalendarModal(entryCountByDate: entryCountByDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return _entries.isEmpty
        ? Center(
            child: Text(
              '아직 작성된 일기가 없어요 🐾',
              style: textStyle.titleMedium?.copyWith(color: color.surface),
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '아랫집에서 고양이 보고 갈래?', // 👈 원하는 텍스트
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    IconButton(
                      onPressed: () => _showCalendarModal(context),
                      icon: const Icon(Icons.calendar_month),
                      color: color.onPrimary,
                      iconSize: 22,
                      tooltip: '이모지 달력 보기',
                      padding: EdgeInsets.zero, // 여백 제거
                      constraints: const BoxConstraints(), // 사이즈 최소화
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/images/upper_cloud.png',
                  fit: BoxFit.contain,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ..._entries.asMap().entries.map((entryMap) {
                final reversedIndex = entryMap.key;
                final entry = entryMap.value;

                final parts = entry.split('|');
                final date = parts.length > 1 ? parts[0] : '날짜 없음';
                final content = parts.length > 1 ? parts[1] : entry;
                final emoji = content.isNotEmpty ? content.substring(0, 2) : '';
                final text = content.length > 2 ? content.substring(2) : '';

                final originalIndex = _entries.length - 1 - reversedIndex;

                return Column(
                  children: [
                    Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: color.error,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.delete, color: color.onError),
                      ),
                      onDismissed: (_) async {
                        setState(() {
                          _entries.removeAt(reversedIndex);
                        });
                        await DiaryStorage.deleteEntry(originalIndex);
                      },
                      child: Card(
                        color: color.surface,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          leading: Text(
                            emoji,
                            style: textStyle.bodyLarge?.copyWith(fontSize: 24),
                          ),
                          title: Text(
                            text,
                            style: textStyle.bodyLarge?.copyWith(
                              color: color.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            date,
                            style: textStyle.bodySmall?.copyWith(
                              color: color.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Image.asset(
                  'assets/images/cloud.png',
                  fit: BoxFit.contain,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 180),
                      child: Text(
                        '야옹 ~',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color.onPrimary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        'assets/images/cat.png',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
