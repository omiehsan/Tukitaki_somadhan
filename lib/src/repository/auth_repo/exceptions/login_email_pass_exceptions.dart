class loginUserEmailPassExceptions {
  final String errorMessage;

  const loginUserEmailPassExceptions([this.errorMessage = "An Unknown Error Occurred!"]);

  factory loginUserEmailPassExceptions.code(String code) {
    switch (code) {
      case 'unverified-email':
        return const loginUserEmailPassExceptions('Email Is  Not Verified');

      case 'invalid-email':
        return const loginUserEmailPassExceptions('Email Not Valid or Badly Formatted');

      case 'wrong-password':
        return const loginUserEmailPassExceptions('Wrong Password Entered!');

      default:
        return const loginUserEmailPassExceptions();
    }
  }
}
