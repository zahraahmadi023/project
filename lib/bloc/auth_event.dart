import 'package:country_picker/country_picker.dart';

abstract class LoginEvent {}

class CountrySelectedEvent extends LoginEvent {
  final Country country;
  CountrySelectedEvent(this.country, {required Country selectedCountry});
}

class PhoneChangedEvent extends LoginEvent {
  final String phone;
  PhoneChangedEvent(this.phone);
}

class SubmitPressedEvent extends LoginEvent {}
