import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimePickerExample extends StatefulWidget {
  final Function(String) onHourSelected;

  const TimePickerExample({required this.onHourSelected, super.key});

  @override
  TimePickerExampleState createState() => TimePickerExampleState();
}

class TimePickerExampleState extends State<TimePickerExample> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController hourController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final formattedTime = _selectedTime.format(context);
        hourController.text = formattedTime; // Atualiza o campo de texto
        widget.onHourSelected(formattedTime); // Chama a função de retorno
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _selectedTime.format(context);
    hourController.text = formattedTime; // Atualiza o campo de texto
    widget.onHourSelected(formattedTime);
    return Column(
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          readOnly: true,
          onTap: () => _selectTime(context),
          controller: hourController = TextEditingController(
            text: _selectedTime.format(context),
          ),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).hora_evento,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            //suffixIcon: Icon(Icons.access_time),
            border: const OutlineInputBorder(),
            hintText: AppLocalizations.of(context).definir_hora,
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      ],
    );
  }
}
