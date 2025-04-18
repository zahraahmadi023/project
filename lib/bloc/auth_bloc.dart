import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/auth_event.dart';
import 'package:project/bloc/auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<CountrySelectedEvent>((event, emit) {
      emit(state.copyWith(selectedCountry: event.country));
    });

    on<PhoneChangedEvent>((event, emit) {
      final phone = event.phone;
      final englishPhone = phone.replaceAllMapped(
        RegExp(r'[۰-۹]'),
        (match) => (match.group(0)!.codeUnitAt(0) - 1728).toString(),
      );
      final isEnabled = int.tryParse(englishPhone) != null;

      emit(state.copyWith(phone: phone, isButtonEnabled: isEnabled));
    });

    on<SubmitPressedEvent>((event, emit) {
      final phone = state.phone;
      final phoneCode = state.selectedCountry?.phoneCode ?? '98';

      if (phone.length != 8 ||
          (phoneCode == '98' &&
              !(phone.startsWith('90') ||
                  phone.startsWith('91') ||
                  phone.startsWith('93')))) {
        emit(state.copyWith(errorText: 'شماره همراه درست وارد نشده است'));
      } else {
        emit(state.copyWith(errorText: null));
        // اینجا باید Navigator یا context.go رو صدا بزنی از UI
      }
    });
  }
}
