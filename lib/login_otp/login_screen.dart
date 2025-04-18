// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:project/bloc/auth_bloc.dart';
// import 'package:project/bloc/auth_event.dart';
// import 'package:project/bloc/auth_state.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isButtonEnabled = false;
//   String? errorText;

//   String convertToFarsiWithIntl(String input) {
//     try {
//       final formatter = NumberFormat.decimalPattern('fa');
//       return formatter.format(int.parse(input));
//     } catch (e) {
//       return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
//         final num = match.group(0)!;
//         return String.fromCharCode(num.codeUnitAt(0) + 1728);
//       });
//     }
//   }

//   final TextEditingController phoneController = TextEditingController();

//   bool isBlack = false;

//   void _toggleColor() {
//     setState(() {
//       isBlack = !isBlack;
//     });
//   }

//   Country? selectedCountry;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.08,
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 100,
//               ),
//               const Text(
//                 "شماره همراه",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 25),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text("23.25.2"),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 " لطفا کشور و شماره همراه خود را وارد کنید ",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                     fontSize: 18),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               // GestureDetector(
//               //   onTap: () {
//               //     _toggleColor();

//               //     showCountryPicker(
//               //       context: context,
//               //       showPhoneCode: true,
//               //       countryListTheme: const CountryListThemeData(
//               //         flagSize: 40,
//               //       ),
//               //       onSelect: (value) {
//               //         setState(() {
//               //           selectedCountry = value as Country?;
//               //         });
//               //       },
//               //     );
//               //   },
//               //   child: Stack(clipBehavior: Clip.none, children: [
//               //     Container(
//               //       width: 300,
//               //       height: 50,
//               //       padding: const EdgeInsets.symmetric(horizontal: 12),
//               //       decoration: BoxDecoration(
//               //         border: Border.all(
//               //           color: isBlack ? Colors.black : Colors.blue,
//               //         ),
//               //         borderRadius: BorderRadius.circular(12),
//               //       ),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           Text(selectedCountry == null
//               //               ? "+98"
//               //               : "+${selectedCountry!.phoneCode}"),
//               //           const SizedBox(width: 8),
//               //           Text(selectedCountry == null
//               //               ? "Iran"
//               //               : "${selectedCountry!.name} ${selectedCountry!.flagEmoji}"),
//               //         ],
//               //       ),
//               //     ),
//               //     Positioned(
//               //       top: -10,
//               //       left: 16,
//               //       child: Container(
//               //         padding: const EdgeInsets.symmetric(horizontal: 8),
//               //         color: Colors.white,
//               //         child: const Text(
//               //           "کشور",
//               //           style: TextStyle(
//               //             fontSize: 14,
//               //             color: Colors.black,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ]),
//               // ),
//               // const SizedBox(height: 30.0),
//               // Column(
//               //   crossAxisAlignment: CrossAxisAlignment.end,
//               //   children: [
//               //     SizedBox(
//               //       width: 300,
//               //       child: TextField(
//               //         controller: phoneController,
//               //         keyboardType: TextInputType.number,
//               //         maxLength: 8,
//               //         onChanged: (value) {
//               //           final farsi = convertToFarsiWithIntl(value);

//               //           if (value != farsi) {
//               //             phoneController.value = TextEditingValue(
//               //               text: farsi,
//               //               selection:
//               //                   TextSelection.collapsed(offset: farsi.length),
//               //             );
//               //           }

//               //           final english = value.replaceAllMapped(
//               //             RegExp(r'[۰-۹]'),
//               //             (match) =>
//               //                 (match.group(0)!.codeUnitAt(0) - 1728).toString(),
//               //           );

//               //           setState(() {
//               //             isButtonEnabled = int.tryParse(english) != null;
//               //           });
//               //         },

//               //         textAlign: TextAlign.left,
//               //         //textAlign: TextAlign.right,
//               //         decoration: InputDecoration(
//               //           //hintTextDirection: Alignment.centerLeft,
//               //           floatingLabelBehavior: FloatingLabelBehavior.always,
//               //           alignLabelWithHint: true,
//               //           labelText: "شماره همراه",
//               //           labelStyle: TextStyle(color: Colors.black),
//               //           hintText: "۹۱۹۹۸۹۸۹۸",
//               //           hintStyle: const TextStyle(
//               //             color: Colors.grey,
//               //           ),

//               //           prefixText: selectedCountry != null
//               //               ? "  ${selectedCountry!.phoneCode} + "
//               //               : "+  ۹۸ |",
//               //           prefixStyle:
//               //               const TextStyle(fontWeight: FontWeight.bold),
//               //           border: OutlineInputBorder(
//               //             borderSide: BorderSide(color: Colors.black),
//               //             borderRadius: BorderRadius.circular(12),
//               //           ),
//               //           focusedBorder: OutlineInputBorder(
//               //             borderSide: BorderSide(color: Colors.blue),
//               //             borderRadius: BorderRadius.circular(12),
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //     if (errorText != null)
//               //       Text(
//               //         textAlign: TextAlign.right,
//               //         errorText!,
//               //         style: const TextStyle(color: Colors.red, fontSize: 13),
//               //       ),
//               //   ],
//               // ),
//               // const Spacer(),
//               BlocProvider(
//                 create: (_) => LoginBloc(),
//                 child: BlocBuilder<LoginBloc, LoginState>(
//                   builder: (context, state) {
//                     final bloc = context.read<LoginBloc>();

//                     return Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             showCountryPicker(
//                               context: context,
//                               showPhoneCode: true,
//                               onSelect: (country) {
//                                 bloc.add(CountrySelectedEvent(country));
//                               },
//                             );
//                           },
//                           child: Text(
//                             state.selectedCountry?.name ?? "ایران",
//                           ),
//                         ),
//                         TextField(
//                           onChanged: (val) {
//                             bloc.add(PhoneChangedEvent(val));
//                           },
//                         ),
//                         if (state.errorText != null)
//                           Text(state.errorText!,
//                               style: TextStyle(color: Colors.red)),
//                         ElevatedButton(
//                           onPressed: state.isButtonEnabled
//                               ? () {
//                                   bloc.add(SubmitPressedEvent());
//                                   // بعدش از BlocListener استفاده کن تا بر اساس state.errorText == null بروی به /otp
//                                 }
//                               : null,
//                           child: Text("تایید"),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: SizedBox(
//                   width: 300,
//                   height: 50,
//                   child: TextButton(
//                     onPressed: isButtonEnabled
//                         ? () {
//                             String input =
//                                 convertToFarsiWithIntl(phoneController.text);
//                             String? phoneCode =
//                                 selectedCountry?.phoneCode ?? '۹۸';

//                             if (input.length != 8 ||
//                                 (phoneCode == '98' &&
//                                     !(input.startsWith('90') ||
//                                         input.startsWith('91') ||
//                                         input.startsWith('93')))) {
//                               setState(() {
//                                 errorText = 'شماره همراه درست وارد نشده است ';
//                               });
//                             } else {
//                               setState(() {
//                                 errorText = null;
//                               });
//                               final input = phoneController.text;

//                               context.go('/otp/$input');
//                             }
//                           }
//                         : null,
//                     style: TextButton.styleFrom(
//                       backgroundColor: isButtonEnabled
//                           ? const Color(0xff3674B5)
//                           : const Color(0xffC6E7FF),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       "تایید و ادامه",
//                       style: TextStyle(
//                         color: isButtonEnabled ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  late PhoneAuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PhoneAuthBloc();
    phoneController.addListener(() {
      _bloc.add(PhoneChanged(phoneController.text));
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "شماره همراه",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    const Text("23.25.2"),
                    const SizedBox(height: 20),
                    const Text(
                      " لطفا کشور و شماره همراه خود را وارد کنید ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        _bloc.add(ToggleCountryBorder());
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme:
                              const CountryListThemeData(flagSize: 40),
                          onSelect: (value) {
                            _bloc.add(CountrySelected(value));
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
                                color: state.isCountryBorderBlack
                                    ? Colors.black
                                    : Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.selectedCountry == null
                                    ? "+98"
                                    : "+${state.selectedCountry!.phoneCode}"),
                                const SizedBox(width: 8),
                                Text(state.selectedCountry == null
                                    ? "Iran"
                                    : "${state.selectedCountry!.name} ${state.selectedCountry!.flagEmoji}"),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -10,
                            left: 16,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.white,
                              child: const Text(
                                "کشور",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
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
                          width: 300,
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              labelText: "شماره همراه",
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "۹۱۹۹۸۹۸۹۸",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixText: state.selectedCountry != null
                                  ? "  ${state.selectedCountry!.phoneCode} + "
                                  : "+  ۹۸ |",
                              prefixStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        if (state.error != null)
                          Text(
                            textAlign: TextAlign.right,
                            state.error!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 13),
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
                          onPressed: state.isButtonEnabled
                              ? () {
                                  _bloc.add(SubmitPressed());

                                  if (state.error == null) {
                                    final phone = phoneController.text;
                                    context.go('/otp/$phone');
                                  }
                                }
                              : null,
                          style: TextButton.styleFrom(
                            backgroundColor: state.isButtonEnabled
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
                              color: state.isButtonEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isBlack = false;

//   void _toggleColor() {
//     setState(() {
//       isBlack = !isBlack;
//     });
//   }

//   Country? selectedCountry;

//   bool isButtonEnabled = false;
//   String? errorText;

//   // String convertToFarsiWithIntl(String input) {
//   //   try {
//   //     final formatter = NumberFormat.decimalPattern('fa');
//   //     return formatter.format(int.parse(input));
//   //   } catch (e) {
//   //     return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
//   //       final num = match.group(0)!;
//   //       return String.fromCharCode(num.codeUnitAt(0) + 1728);
//   //     });
//   //   }
//   // }

//   final TextEditingController phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 //crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   BlocBuilder<AuthBloc, AuthState>(
//                     builder: (context, state) {
//                       final bloc = context.read<AuthBloc>();
//                       return Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _toggleColor();
//                                 showCountryPicker(
//                                   context: context,
//                                   showPhoneCode: true,
//                                   countryListTheme: const CountryListThemeData(
//                                     flagSize: 40,
//                                   ),
//                                   onSelect: (country) {
//                                     setState(() {
//                                       selectedCountry = country;
//                                     });
//                                     bloc.add(CountryChanged(
//                                       phoneCode: country.phoneCode,
//                                       countryName: country.name,
//                                     ));
//                                   },
//                                 );
//                               },
//                               child: Stack(
//                                 clipBehavior: Clip.none,
//                                 children: [
//                                   Container(
//                                     width: 300,
//                                     height: 50,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: isBlack
//                                             ? Colors.black
//                                             : Colors.blue,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("+${state.phoneCode}"),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           selectedCountry != null
//                                               ? "${selectedCountry!.name} ${selectedCountry!.flagEmoji}"
//                                               : state.countryName,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: -10,
//                                     left: 16,
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8),
//                                       color: Colors.white,
//                                       child: const Text(
//                                         "کشور",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 30),

//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 SizedBox(
//                                   width: 300,
//                                   child: TextField(
//                                     controller: phoneController,
//                                     keyboardType: TextInputType.number,
//                                     maxLength: 8,
//                                     onChanged: (value) {
//                                       final english = value;
//                                       final isNumeric = RegExp(r'^\d{1,8}$')
//                                           .hasMatch(english);

//                                       setState(() {
//                                         isButtonEnabled = isNumeric;
//                                       });

//                                       bloc.add(PhoneNumberChanged(english));
//                                     },
//                                     textAlign: TextAlign.left,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                           FloatingLabelBehavior.always,
//                                       alignLabelWithHint: true,
//                                       labelText: "شماره همراه",
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                       hintText: "۹۱۹۹۸۹۸۹۸",
//                                       hintStyle: const TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                       prefixText: selectedCountry != null
//                                           ? "  ${selectedCountry!.phoneCode} + "
//                                           : "+  ۹۸ |",
//                                       prefixStyle: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                       border: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.black),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.blue),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 if (errorText != null)
//                                   Text(
//                                     textAlign: TextAlign.right,
//                                     errorText!,
//                                     style: const TextStyle(
//                                         color: Colors.red, fontSize: 13),
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),

//                             BlocBuilder<AuthBloc, AuthState>(
//                               builder: (context, state) {
//                                 final isButtonEnabled = state.isValid;

//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                   child: SizedBox(
//                                     width: 300,
//                                     height: 50,
//                                     child: TextButton(
//                                       onPressed: isButtonEnabled
//                                           ? () {
//                                               context
//                                                   .read<AuthBloc>()
//                                                   .add(SubmitPhoneNumber());

//                                               if (state.error == null) {
//                                                 final input = state.phoneNumber;
//                                                 final code = state.phoneCode;
//                                                 final fullNumber =
//                                                     '+$code$input';
//                                                 context.go('/otp/$fullNumber');
//                                               }
//                                             }
//                                           : null,
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: isButtonEnabled
//                                             ? const Color(0xff3674B5)
//                                             : const Color(0xffC6E7FF),
//                                         foregroundColor: Colors.white,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 6),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         "تایید و ادامه",
//                                         style: TextStyle(
//                                           color: isButtonEnabled
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),

//                             // ElevatedButton(
//                             //   onPressed: state.isValid
//                             //       ? () {
//                             //           bloc.add(SubmitPhoneNumber());
//                             //           if (state.error == null) {
//                             //             final fullNumber =
//                             //                 '+${state.phoneCode}${state.phoneNumber}';
//                             //             context.go('/otp/$fullNumber');
//                             //           }
//                             //         }
//                             //       : null,
//                             //   child: const Text("تایید و ادامه"),
//                             // ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
