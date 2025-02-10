import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/config.dart';

class PocketBaseService {
  final PocketBase _pb = PocketBase(pocketBaseUrl);

  PocketBase get pb => _pb;
}
