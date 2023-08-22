import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  final Function(String) onDateSelected;

  const DatePickerExample({required this.onDateSelected, super.key});

  @override
  DatePickerExampleState createState() => DatePickerExampleState();
}

class DatePickerExampleState extends State<DatePickerExample> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        final formattedDate = "${_selectedDate.toLocal()}".split(' ')[0];
        dateController.text = formattedDate; // Atualiza o campo de texto
        widget.onDateSelected(formattedDate); // Chama a função de retorno
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = "${_selectedDate.toLocal()}".split(' ')[0];
    dateController.text = formattedDate; // Atualiza o campo de texto
    widget.onDateSelected(formattedDate); //
    return Column(
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          readOnly: true,
          onTap: () => _selectDate(context),
          controller: dateController = TextEditingController(
            text: "${_selectedDate.toLocal()}".split(' ')[0],
          ),
          decoration: const InputDecoration(
            labelText: 'Selecionar Data',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            border: OutlineInputBorder(),
            hintText: 'Definir Data',
            fillColor: Colors.white70,
            filled: true,
          ),
        ),
      ],
    );
  }
}
