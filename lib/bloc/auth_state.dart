class AuthState {
  final String phoneCode;
  final String countryName;
  final String phoneNumber;
  final bool isValid;
  final String? error;
  final bool isBlack;

  AuthState({
    this.phoneCode = '98',
    this.countryName = 'ایران 🇮🇷',
    this.phoneNumber = '',
    this.isValid = false,
    this.error,
    this.isBlack = false,
  });

  AuthState copyWith({
    String? phoneCode,
    String? countryName,
    String? phoneNumber,
    bool? isValid,
    String? error,
    bool? isBlack,
  }) {
    return AuthState(
      phoneCode: phoneCode ?? this.phoneCode,
      countryName: countryName ?? this.countryName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
      error: error,
      isBlack: isBlack ?? this.isBlack,
    );
  }
}
