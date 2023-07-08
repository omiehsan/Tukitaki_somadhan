class createUserEmailPassExceptions {
  final String errorMessage;

  const createUserEmailPassExceptions([this.errorMessage = "An Unknown Error Occurred!"]);

  factory createUserEmailPassExceptions.code(String code) {
    switch (code) {
      case 'weak-password':
        return const createUserEmailPassExceptions('Enter Strong Password!');

      case 'invalid-email':
        return const createUserEmailPassExceptions('Email Not Valid or Badly Formatted');

      case 'email-already-in-use':
        return const createUserEmailPassExceptions('User Exists w/ This Email');

      case 'operation-not-allowed':
        return const createUserEmailPassExceptions('Operation Not Allowed. Contact Support');

      case 'user-disabled':
        return const createUserEmailPassExceptions('Your Account Has Been Disabled! Contact Support');

      default:
        return const createUserEmailPassExceptions();
    }
  }
}
