// import 'package:country_picker/country_picker.dart';

// abstract class PhoneAuthEvent {}

// class CountrySelected extends PhoneAuthEvent {
//   final Country country;
//   CountrySelected(this.country);
// }

// class PhoneChanged extends PhoneAuthEvent {
//   final String phone;
//   PhoneChanged(this.phone);
// }

// class ToggleCountryBorder extends PhoneAuthEvent {}

// class SubmitPressed extends PhoneAuthEvent {}
// phone_auth_event.dart
import 'package:country_picker/country_picker.dart';

abstract class PhoneAuthEvent {}

class CountrySelected extends PhoneAuthEvent {
  final Country country;
  CountrySelected(this.country);
}

class PhoneChanged extends PhoneAuthEvent {
  final String phone;
  PhoneChanged(this.phone);
}

class ToggleCountryBorder extends PhoneAuthEvent {}

class SubmitPressed extends PhoneAuthEvent {}
