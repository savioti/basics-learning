import 'package:study_flutter_mvvm/src/core/error/error.dart';
import 'package:study_flutter_mvvm/src/core/state/state.dart';
import 'package:study_flutter_mvvm/src/core/view_model/view_model_base.dart';
import 'package:study_flutter_mvvm/src/modules/home/model/user_model.dart';
import 'package:study_flutter_mvvm/src/modules/home/repositories/users_repository.dart';

class UsersViewModel extends ViewModelBase {
  final List<UserModel> users = [];
  final UsersRepository _userRepository = UsersRepository();

  UsersViewModel() {
    getUsers();
  }

  Future<void> getUsers() async {
    state = EState.loading;
    final response = await _userRepository.getUsers();

    response.fold(
      (left) {
        error = Error(
          error: left,
          errorMessage: left.error.toString(),
        );

        state = EState.error;
      },
      (right) {
        users.addAll(right);
        state = EState.finished;
      },
    );

    notifyListeners();
  }
}
