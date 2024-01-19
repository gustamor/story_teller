import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/ui/core/providers/date_picker_provider.dart';

/// A class to display a Cupertino-style date picker dialog.
class NiceDatePickerDialog {

  /// Displays a date picker dialog in the [context] with the provided [ref].
  ///
  /// This method shows a modal popup with a Cupertino date picker allowing the user
  /// to select a date. The selected date is managed by a state notifier referenced by [ref].
  /// 
  /// - [context]: The build context in which to display the date picker.
  /// - [ref]: A WidgetRef object used to interact with the state of the date picker.
  ///
  /// The date picker allows selection of dates between January 1, 1910, and December 31, 2023.
  /// Once a date is selected, it updates the state notifier provided by [ref] and the dialog
  /// can be dismissed by pressing the 'OK' button.
  showDatePicker(BuildContext context, WidgetRef ref) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        color: Theme.of(context).datePickerTheme.rangePickerSurfaceTintColor,
        child: Container(
          height: 300,
          color: Theme.of(context).dialogBackgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  minimumDate: DateTime(1910, 1, 1),
                  initialDateTime: DateTime(2023, 12, 30),
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
              // Button to close the modal
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
