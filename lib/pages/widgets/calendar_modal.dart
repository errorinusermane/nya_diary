import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModal extends StatelessWidget {
  final Map<DateTime, int> entryCountByDate;

  const CalendarModal({super.key, required this.entryCountByDate});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: color.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: SizedBox(
        width: double.infinity,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  daysOfWeekVisible: true,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: textStyle.titleMedium!.copyWith(
                      color: color.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: color.primary,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: color.primary,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: color.primary.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: textStyle.bodyMedium!,
                    weekendTextStyle: textStyle.bodyMedium!.copyWith(
                      color: color.secondary,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, _) {
                      final normalizedDay = DateTime(
                        day.year,
                        day.month,
                        day.day,
                      );
                      final hasEntry = entryCountByDate[normalizedDay] != null;

                      return Center(
                        child: Text(
                          hasEntry ? '·' : '${day.day}',
                          style: TextStyle(
                            fontSize: hasEntry ? 32 : 14, // 점은 크게!
                            fontWeight: FontWeight.bold,
                            color: hasEntry ? color.primary : color.onSurface,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: color.primary,
                    foregroundColor: color.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('닫기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
