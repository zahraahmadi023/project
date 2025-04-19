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

    on<PhoneNumberChanged>((event, emit) {
      final isValid = int.tryParse(event.phoneNumber) != null;
      emit(state.copyWith(
        phoneNumber: event.phoneNumber,
        isValid: isValid,
      ));
    });

    on<ToggleColor>((event, emit) {
      emit(state.copyWith(isBlack: !state.isBlack));
    });

    on<SubmitPhoneNumber>((event, emit) {
      if (state.phoneNumber.length < 8) {
        emit(state.copyWith(error: "شماره وارد شده معتبر نیست"));
      } else {
        emit(state.copyWith(error: null));
      }
    });
  }
}
