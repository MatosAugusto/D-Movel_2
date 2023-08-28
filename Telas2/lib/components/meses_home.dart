import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthYearSelector extends StatefulWidget {
  final Function(String year, String month) onDateChanged;

  const MonthYearSelector({required this.onDateChanged, super.key});

  @override
  MonthYearSelectorState createState() => MonthYearSelectorState();
}

class MonthYearSelectorState extends State<MonthYearSelector> {
  DateTime selectedDate = DateTime.now();

  void _changeMonth(int change) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + change);
      widget.onDateChanged(selectedDate.year.toString(),
          selectedDate.month.toString().padLeft(2, '0'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _changeMonth(-1),
          icon: Icon(Icons.arrow_left),
          iconSize: 36,
        ),
        SizedBox(width: 16),
        Text(
          '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 16),
        IconButton(
          onPressed: () => _changeMonth(1),
          icon: Icon(Icons.arrow_right),
          iconSize: 36,
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    final months = [
      AppLocalizations.of(context).janeiro,
      AppLocalizations.of(context).fevereiro,
      AppLocalizations.of(context).marco,
      AppLocalizations.of(context).abril,
      AppLocalizations.of(context).maio,
      AppLocalizations.of(context).junho,
      AppLocalizations.of(context).julho,
      AppLocalizations.of(context).agosto,
      AppLocalizations.of(context).setembro,
      AppLocalizations.of(context).outubro,
      AppLocalizations.of(context).novembro,
      AppLocalizations.of(context).dezembro
    ];
    return months[month - 1];
  }
}
