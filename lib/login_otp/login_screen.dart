import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:project/bloc/auth_bloc.dart';
import 'package:project/bloc/auth_event.dart';
import 'package:project/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isBlack = false;

  void _toggleColor() {
    setState(() {
      isBlack = !isBlack;
    });
  }

  String convertToFarsiWithIntl(String input) {
    try {
      final formatter = NumberFormat.decimalPattern('fa');
      return formatter.format(int.parse(input));
    } catch (e) {
      return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
        final num = match.group(0)!;
        return String.fromCharCode(num.codeUnitAt(0) + 1728);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final bloc = context.read<AuthBloc>();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),

                    const Text(
                      "شماره همراه  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "لطفا شماره همراه خودرا وارد کنید",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// Country Picker Box
                    GestureDetector(
                      onTap: () {
                        _toggleColor();
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: const CountryListThemeData(
                            flagSize: 40,
                          ),
                          onSelect: (country) {
                            bloc.add(CountryChanged(
                              phoneCode: country.phoneCode,
                              countryName:
                                  "${country.name} ${country.flagEmoji}",
                            ));
                          },
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 300,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isBlack ? Colors.black : Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("+${state.phoneCode}"),
                                const SizedBox(width: 8),
                                Text(state.countryName.isNotEmpty
                                    ? state.countryName
                                    : "Iran 🇮🇷"),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: -10,
                            left: 16,
                            child: ColoredBox(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "کشور",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 300,
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            onChanged: (value) {
                              final english = value.replaceAllMapped(
                                RegExp(r'[۰-۹]'),
                                (match) =>
                                    (match.group(0)!.codeUnitAt(0) - 1728)
                                        .toString(),
                              );

                              bloc.add(PhoneNumberChanged(english));
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              labelText: "شماره همراه",
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: "۹۱۹۹۸۹۸۹۸",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixText: "+${state.phoneCode} | ",
                              prefixStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        if (state.error != null)
                          Text(
                            state.error!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                      ],
                    ),

                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: TextButton(
                          onPressed: state.isValid
                              ? () {
                                  if (state.error == null) {
                                    final input = state.phoneNumber;
                                    final code = state.phoneCode;
                                    final fullNumber = '+$code$input';
                                    context.go('/otp/$fullNumber');
                                    bloc.add(SubmitPhoneNumber());
                                    if (state.error == null) {
                                      final full =
                                          "+${state.phoneCode}${state.phoneNumber}";
                                      context.go('/otp/$full');
                                    }
                                  }
                                }
                              : null,
                          style: TextButton.styleFrom(
                            backgroundColor: state.isValid
                                ? const Color(0xff3674B5)
                                : const Color(0xffC6E7FF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "تایید و ادامه",
                            style: TextStyle(
                              color:
                                  state.isValid ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
