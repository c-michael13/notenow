
class CreateAccount {
  final String email;
  final String password; 
  final String username;


  CreateAccount({
    required this.email,
    required this.password,
    required this.username,
  });

  CreateAccount copyWith({
    String? email,
    String? password,
    String? username,
  }) {
    return CreateAccount(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
    );
  }
}