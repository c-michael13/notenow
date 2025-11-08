import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:note_now/view_model/model/create_account.dart';

class CreateAccountNotifier extends StateNotifier<CreateAccount>{
  CreateAccountNotifier() : super(CreateAccount(
    email: '', 
    password: '', 
    username: '',
  ));

  void setEmail(String email) {
    state = state.copyWith(email: email);
    print("This is th registered email: $email");
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
    print("This is th registered password: $password");
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
    print("This is th registered username: $username");
  }
}

final createAccountProvider = StateNotifierProvider<CreateAccountNotifier, CreateAccount>(
  (ref) => CreateAccountNotifier(),
);