import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/ui/core/date_picker.dart';

final datePickerProvider = Provider<NiceDatePickerDialog>((ref) {
  final datePicker = NiceDatePickerDialog();
  return datePicker;
});

final datePickerState = StateProvider<DateTime>((ref) {
  Timestamp? date;
  final userAsyncValue = ref.watch(userProvider);
  userAsyncValue.whenData((value) => date = value!.birthDate!);
  return  date?.toDate() ?? DateTime.now(); // Inicializa con la fecha actual
});
