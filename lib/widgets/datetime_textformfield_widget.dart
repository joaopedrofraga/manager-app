// ignore_for_file: use_build_context_synchronously

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:manager_app/widgets/sizedbox_widget.dart';
import 'package:manager_app/widgets/textformfield_widget.dart';

// ignore: must_be_immutable
class DateTimeTextFormFieldWidget extends StatefulWidget {
  DateTime dataHora;
  Function(DateTime) updateDataHora;
  DateTimeTextFormFieldWidget({
    super.key,
    required this.dataHora,
    required this.updateDataHora,
  });

  @override
  State<DateTimeTextFormFieldWidget> createState() =>
      _DateTimeTextFormFieldWidgetState();
}

class _DateTimeTextFormFieldWidgetState
    extends State<DateTimeTextFormFieldWidget> {
  late String init;
  MaskedTextController dataHoraController = MaskedTextController(
    mask: '00/00/0000 - 00:00',
  );
  FocusNode focusNode = FocusNode();

  void updateController(DateTime novaData) {
    setState(() {
      dataHoraController.text =
          '${novaData.day.toString().padLeft(2, '0')}/${novaData.month.toString().padLeft(2, '0')}/${novaData.year} - ${novaData.hour.toString().padLeft(2, '0')}:${novaData.minute.toString().padLeft(2, '0')}';
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: 'Selecione a Data',
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      helpText: 'Selecione o Horário',
    );

    if (pickedTime == null) return;

    final newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      updateController(newDateTime);
      widget.updateDataHora(newDateTime);
    });
  }

  void _validateAndFormatInput() {
    final text = dataHoraController.text;
    if (text.length < 16) {
      setState(() {
        updateController(widget.dataHora);
      });
      return;
    }

    try {
      final dateParts = text.substring(0, 10).split('/');
      final timeParts = text.substring(13).split(':');

      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      final newDateTime = DateTime(year, month, day, hour, minute);

      if (newDateTime.year != year ||
          newDateTime.month != month ||
          newDateTime.day != day) {
        throw const FormatException("Data inválida.");
      }

      setState(() {
        widget.dataHora = newDateTime;
        updateController(widget.dataHora);
      });
      widget.updateDataHora(widget.dataHora);
    } catch (e) {
      setState(() {
        updateController(widget.dataHora);
      });
    }
  }

  @override
  void initState() {
    updateController(widget.dataHora);
    focusNode.addListener(_validateAndFormatInput);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_validateAndFormatInput);
    focusNode.dispose();
    dataHoraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _selectDateTime(context),
          tooltip: 'Abrir Calendário',
          icon: Icon(Icons.calendar_month, size: 30),
          style: IconButton.styleFrom(
            side: BorderSide(color: AppColors.primary, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
        ),
        const SizedBoxWidget.xxs(),
        Expanded(
          child: TextFormFieldWidget(
            controller: dataHoraController,
            focusNode: focusNode,
            inputLabel: 'Data/Hora do Orçamento',
            onChanged: (String novoTexto) {},
          ),
        ),
      ],
    );
  }
}
