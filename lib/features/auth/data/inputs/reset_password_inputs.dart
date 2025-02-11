class ResetPasswordInputs {
  final String email;
  final String newPassword;

  ResetPasswordInputs({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': newPassword,
      }; // <String, dynamic>
}
