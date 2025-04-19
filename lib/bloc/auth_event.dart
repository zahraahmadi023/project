abstract class AuthEvent {}

class CountryChanged extends AuthEvent {
  final String phoneCode;
  final String countryName;

  CountryChanged({required this.phoneCode, required this.countryName});
}

class PhoneNumberChanged extends AuthEvent {
  final String phoneNumber;

  PhoneNumberChanged(this.phoneNumber);
}

class SubmitPhoneNumber extends AuthEvent {}

class ToggleColor extends AuthEvent {}
