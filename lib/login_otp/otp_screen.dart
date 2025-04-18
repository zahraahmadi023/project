import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  OtpScreen({super.key, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isButtonEnabled = false;
  String? errorText;

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

  Country? selectedCountry;

  final TextEditingController phoneController = TextEditingController();

  bool isRed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.go('/');
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "کد ورود ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "کد به این شماره ${widget.number} ارسال شده است",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      onChanged: (value) {
                        final farsi = convertToFarsiWithIntl(value);

                        if (value != farsi) {
                          phoneController.value = TextEditingValue(
                            text: farsi,
                            selection:
                                TextSelection.collapsed(offset: farsi.length),
                          );
                        }

                        final english = value.replaceAllMapped(
                          RegExp(r'[۰-۹]'),
                          (match) =>
                              (match.group(0)!.codeUnitAt(0) - 1728).toString(),
                        );

                        setState(() {
                          isButtonEnabled = int.tryParse(english) != null;
                        });
                      },
                      textAlign: TextAlign.left,
                      //textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        //hintTextDirection: Alignment.centerLeft,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: "کد ورود",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: " ۱۸۸۹۸۸",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),

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
                  if (errorText != null)
                    Text(
                      textAlign: TextAlign.right,
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              const Text("دریافت کد جدید"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextButton(
                    onPressed: isButtonEnabled
                        ? () {
                            String input =
                                convertToFarsiWithIntl(phoneController.text);
                            if (input.length != 6 || input.isNotEmpty) {
                              context.go('/home');
                            } else {
                              setState(() {
                                errorText = null;
                              });
                            }
                          }
                        : null,
                    style: TextButton.styleFrom(
                      backgroundColor: isButtonEnabled
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
                        color: isButtonEnabled ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/////
////////