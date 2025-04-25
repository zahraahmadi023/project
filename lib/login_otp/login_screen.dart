import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  Country? selectedCountry;
  bool isBlack = false;
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
                      "لطفاکشور و شماره همراه خودرا وارد کنید",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        bloc.add(ToggleColor());
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: const CountryListThemeData(
                            flagSize: 40,
                          ),
                          onSelect: (country) {
                            setState(() {
                              selectedCountry = country;
                            });
                            bloc.add(CountryChanged(
                                phoneCode: country.phoneCode,
                                countryName: country.name));
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
                    BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.isValid && state.error == null) {
                            final fullNumber =
                                "+${state.phoneCode}${state.phoneNumber}";
                            context.go('/otp/$fullNumber');
                          }
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 300,
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      onChanged: (value) {
                                        final english = value.replaceAllMapped(
                                          RegExp(r'[۰-۹]'),
                                          (match) =>
                                              (match.group(0)!.codeUnitAt(0) -
                                                      1728)
                                                  .toString(),
                                        );
                                        bloc.add(PhoneNumberChanged(
                                          english,
                                        ));
                                      },
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        labelText: "شماره همراه",
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                        hintText: "912 677 7890",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixText: "+${state.phoneCode} | ",
                                        prefixStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if (state.error != null) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20.0, top: 4),
                                      child: Text(
                                        state.error!,
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 13),
                                        textAlign: TextAlign.right,
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ])),
                    const Spacer(),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          final english = phoneController.text.replaceAllMapped(
                            RegExp(r'[۰-۹]'),
                            (match) => (match.group(0)!.codeUnitAt(0) - 1728)
                                .toString(),
                          );

                          bloc.add(PhoneNumberChanged(english));
                          bloc.add(SubmitPhoneNumber());
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff3674B5),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "تایید و ادامه",
                          style: TextStyle(color: Colors.white),
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
////