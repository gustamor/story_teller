import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/ui/core/providers/date_picker_provider.dart';

class NiceDatePickerDialog {

  showDatePicker(BuildContext context, WidgetRef ref) {
   
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        color:Theme.of(context).datePickerTheme.rangePickerSurfaceTintColor,
        child: Container(
          height: 300,
          color: Theme.of(context).dialogBackgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
        
                  minimumDate: DateTime(1910, 1, 1),
                  initialDateTime:  DateTime(2023, 12, 30),
                  maximumDate: DateTime(2023, 12, 31),
                  minimumYear: 1910,
                  maximumYear: 2024,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date) {
                    ref
                        .read(datePickerState.notifier)
                        .update((state) => state = date);
                  },
                ),
              ),
              // Close the modall
              CupertinoButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
