import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/admob_services_impl.dart';
import 'package:story_teller/domain/abstract/services/abstract_admob_services.dart';

final admobServicesProvider = Provider<AbstractAdmobServices>((ref) {
  return AdmobServicesImpl() ;
});