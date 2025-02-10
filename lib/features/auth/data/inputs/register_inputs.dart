class RegisterInputs {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  RegisterInputs({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'rePassword': rePassword,
        'phone': phone,
      };
}
