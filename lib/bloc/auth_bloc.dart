import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

// phone_auth_bloc.dart
class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc() : super(PhoneAuthState()) {
    on<CountrySelected>((event, emit) {
      emit(state.copyWith(selectedCountry: event.country));
    });

    on<ToggleCountryBorder>((event, emit) {
      emit(state.copyWith(isCountryBorderBlack: !state.isCountryBorderBlack));
    });

    on<PhoneChanged>((event, emit) {
      final englishPhone = _convertToEnglish(event.phone);
      final countryCode = state.selectedCountry?.phoneCode ?? '98';

      final isValid = _validatePhone(englishPhone, countryCode);

      emit(state.copyWith(
        phone: event.phone,
        isPhoneValid: isValid,
        isButtonEnabled: isValid,
        error: null,
      ));
    });

    on<SubmitPressed>((event, emit) {
      final englishPhone = _convertToEnglish(state.phone);
      final code = state.selectedCountry?.phoneCode ?? '98';

      if (!_validatePhone(englishPhone, code)) {
        emit(state.copyWith(error: 'شماره همراه درست وارد نشده است'));
      } else {
        emit(state.copyWith(error: null));
        // ✅ Ready to navigate to OTP
      }
    });
  }

  /// تبدیل کامل همه ارقام فارسی به انگلیسی
  String _convertToEnglish(String input) {
    return input.replaceAllMapped(RegExp(r'[۰-۹]'), (match) {
      return (match.group(0)!.codeUnitAt(0) - 1728).toString();
    }).replaceAllMapped(RegExp(r'[٠-٩]'), (match) {
      return (match.group(0)!.codeUnitAt(0) - 1632).toString(); // برای عربی
    });
  }

  /// اعتبارسنجی: فقط ۸ رقم + پیش‌شماره‌های معتبر برای ایران
  bool _validatePhone(String phone, String phoneCode) {
    if (phone.length != 8) return false;

    if (phoneCode == '98') {
      final fullNumber = "9$phone";
      return RegExp(r'^(90|91|93)').hasMatch(fullNumber);
    }

    return true; // برای سایر کشورها فقط چک می‌کنیم 8 رقمه باشه
  }
}




// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/bloc/auth_event.dart';
// import 'package:project/bloc/auth_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginState()) {
//     on<CountrySelectedEvent>((event, emit) {
//       emit(state.copyWith(selectedCountry: event.country));
//     });

//     on<PhoneChangedEvent>((event, emit) {
//       final phone = event.phone;
//       final englishPhone = phone.replaceAllMapped(
//         RegExp(r'[۰-۹]'),
//         (match) => (match.group(0)!.codeUnitAt(0) - 1728).toString(),
//       );
//       final isEnabled = int.tryParse(englishPhone) != null;

//       emit(state.copyWith(phone: phone, isButtonEnabled: isEnabled));
//     });

//     on<SubmitPressedEvent>((event, emit) {
//       final phone = state.phone;
//       final phoneCode = state.selectedCountry?.phoneCode ?? '98';

//       if (phone.length != 8 ||
//           (phoneCode == '98' &&
//               !(phone.startsWith('90') ||
//                   phone.startsWith('91') ||
//                   phone.startsWith('93')))) {
//         emit(state.copyWith(errorText: 'شماره همراه درست وارد نشده است'));
//       } else {
//         emit(state.copyWith(errorText: null));
//         // اینجا باید Navigator یا context.go رو صدا بزنی از UI
//       }
//     });
//   }
// }
