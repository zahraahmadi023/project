import 'package:country_picker/country_picker.dart';

class LoginState {
  final Country? selectedCountry;
  final String phone;
  final bool isButtonEnabled;
  final String? errorText;

  LoginState({
    this.selectedCountry,
    this.phone = '',
    this.isButtonEnabled = false,
    this.errorText,
  });

  LoginState copyWith({
    Country? selectedCountry,
    String? phone,
    bool? isButtonEnabled,
    String? errorText,
  }) {
    return LoginState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phone: phone ?? this.phone,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      errorText: errorText,
    );
  }
}
