import 'package:flutter/material.dart';

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
        final formattedTime = "${_selectedTime.format(context)}";
        hourController.text = formattedTime; // Atualiza o campo de texto
        widget.onHourSelected(formattedTime); // Chama a função de retorno
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = "${_selectedTime.format(context)}";
    hourController.text = formattedTime; // Atualiza o campo de texto
    widget.onHourSelected(formattedTime);
    return Column(
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          readOnly: true,
          onTap: () => _selectTime(context),
          controller: hourController = TextEditingController(
            text: "${_selectedTime.format(context)}",
          ),
          decoration: const InputDecoration(
            labelText: 'Selecionar Horário',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            //suffixIcon: Icon(Icons.access_time),
            border: OutlineInputBorder(),
            hintText: 'Definir Horário',
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      ],
    );
  }
}
