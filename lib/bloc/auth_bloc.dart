import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/auth_event.dart';
import 'package:project/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<CountryChanged>((event, emit) {
      emit(state.copyWith(
        phoneCode: event.phoneCode,
        countryName: event.countryName,
      ));
    });
    on<ToggleColor>((event, emit) {
      emit(state.copyWith(isBlack: !state.isBlack));
    });
    on<PhoneNumberChanged>((event, emit) {
      emit(state.copyWith(
        phoneNumber: event.phone,
        error: null,
        isValid: false,
      ));
    });

    on<SubmitPhoneNumber>((event, emit) {
      final phone = state.phoneNumber;
      final phoneCode = state.phoneCode;
      if (phone.length < 10) {
        emit(state.copyWith(
          error: "شماره وارد شده معتبر نیست",
          isValid: false,
        ));
        return;
      }
      if (phoneCode == '98') {
        final prefix = phone.substring(0, 2);
        if (!(prefix == '90' ||
            prefix == '91' ||
            prefix == '93' ||
            prefix == '92')) {
          emit(state.copyWith(
            error: "پیش‌شماره معتبر نیست",
            isValid: false,
          ));
          return;
        }
      }
      emit(state.copyWith(
        error: null,
        isValid: true,
      ));
    });
  }
}
