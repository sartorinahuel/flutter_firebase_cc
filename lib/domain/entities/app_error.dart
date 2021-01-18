class AppError extends Error {
  String code;
  String message;

  AppError({this.code, this.message});

  static AppError noConnection() {
    AppError appError = AppError(
      code: 'No Conectivity',
      message: 'Check your internet connection!',
    );
    //TODO translation
    return appError;
  }

  static AppError genericError({String message}) {
    AppError appError = AppError(
      code: 'Something went Wrong',
      message: message,
    );
    //TODO translation
    return appError;
  }

  static AppError noUserFound() {
    AppError appError = AppError(
      code: 'No User Found',
      message: 'No user found for that email',
    );
    //TODO translation
    return appError;
  }

  static AppError emailInUse() {
    AppError appError = AppError(
      code: 'Email already in use',
      message: 'The account already exists for that email',
    );
    //TODO translation
    return appError;
  }

  static AppError wrongPassword() {
    AppError appError = AppError(
      code: 'Wrong password',
      message:
          'Wrong password provided for that user. Try again or recover it.',
    );
    //TODO translation
    return appError;
  }

  static AppError weekPassword() {
    AppError appError = AppError(
      code: 'Week password',
      message: 'The password provided is too weak',
    );
    //TODO translation
    return appError;
  }

  static AppError userDisabled() {
    AppError appError = AppError(
      code: 'User disabled',
      message: 'The user account is disabled. Please contact support.',
    );
    //TODO translation
    return appError;
  }

  static AppError connectionTimeout() {
    AppError appError = AppError(
      code: 'Connection Timeout',
      message:
          'Reach timeout trying to contact server. Check internet connection.',
    );
    //TODO translation
    return appError;
  }
}
