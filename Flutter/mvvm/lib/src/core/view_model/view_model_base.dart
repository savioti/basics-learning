import 'package:flutter/widgets.dart';
import 'package:study_flutter_mvvm/src/core/error/error.dart';
import 'package:study_flutter_mvvm/src/core/state/state.dart';

abstract class ViewModelBase with ChangeNotifier {
  EState state = EState.initial;
  Error? error;
}
