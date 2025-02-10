class LoginInputs {
  final String email;
  final String password;

  LoginInputs({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() => {
        'email': email,
        'password': password,
      };
}
