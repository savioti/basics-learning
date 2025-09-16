import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {});
  }

  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  bool showPassword = false;

  @action
  void togglePasswordVisibility() => showPassword = !showPassword;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  Future<void> login() async {
    isLoading = true;

    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    isLoggedIn = true;
    email = '';
    password = '';
  }

  @action
  void logout() {
    isLoggedIn = false;
  }

  @computed
  Function get onLoginAttempt => (isFormValid && !isLoading) ? login : null;

  @computed
  bool get isFormValid =>
      email.length > 6 && email.contains('@') && password.length >= 8;
}
