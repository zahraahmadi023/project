// class AuthState {
//   final String phoneNumber;
//   final String phoneCode;
//   final String countryName;
//   final bool isValid;
//   final String? error;

//   AuthState({
//     this.phoneNumber = '',
//     this.phoneCode = '98',
//     this.countryName = 'Iran',
//     this.isValid = false,
//     this.error,
//   });

//   AuthState copyWith({
//     String? phoneNumber,
//     String? phoneCode,
//     String? countryName,
//     bool? isValid,
//     String? error,
//   }) {
//     return AuthState(
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       phoneCode: phoneCode ?? this.phoneCode,
//       countryName: countryName ?? this.countryName,
//       isValid: isValid ?? this.isValid,
//       error: error,
//     );
//   }
// }

// phone_auth_state.dart
import 'package:country_picker/country_picker.dart';

class PhoneAuthState {
  final Country? selectedCountry;
  final String phone;
  final bool isPhoneValid;
  final bool isButtonEnabled;
  final bool isCountryBorderBlack;
  final String? error;

  PhoneAuthState({
    this.selectedCountry,
    this.phone = '',
    this.isPhoneValid = false,
    this.isButtonEnabled = false,
    this.isCountryBorderBlack = false,
    this.error,
  });

  PhoneAuthState copyWith({
    Country? selectedCountry,
    String? phone,
    bool? isPhoneValid,
    bool? isButtonEnabled,
    bool? isCountryBorderBlack,
    String? error,
  }) {
    return PhoneAuthState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phone: phone ?? this.phone,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isCountryBorderBlack: isCountryBorderBlack ?? this.isCountryBorderBlack,
      error: error,
    );
  }
}


// import 'package:country_picker/country_picker.dart';

// class LoginState {
//   final Country? selectedCountry;
//   final String phone;
//   final bool isButtonEnabled;
//   final String? errorText;

//   LoginState({
//     this.selectedCountry,
//     this.phone = '',
//     this.isButtonEnabled = false,
//     this.errorText,
//   });

//   LoginState copyWith({
//     Country? selectedCountry,
//     String? phone,
//     bool? isButtonEnabled,
//     String? errorText,
//   }) {
//     return LoginState(
//       selectedCountry: selectedCountry ?? this.selectedCountry,
//       phone: phone ?? this.phone,
//       isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
//       errorText: errorText,
//     );
//   }
// }
