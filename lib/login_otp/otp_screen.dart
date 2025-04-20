import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  OtpScreen({super.key, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isButtonEnabled = false;
  String? errorText;

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
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                "کد ورود",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "کد به این شماره ${widget.number.replaceAll(RegExp(r'[^0-9]'), '')}+ ارسال شده است",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 16,
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
                      maxLength: 6,
                      onChanged: (value) {
                        final english = value.replaceAllMapped(
                          RegExp(r'[۰-۹]'),
                          (match) =>
                              (match.group(0)!.codeUnitAt(0) - 1728).toString(),
                        );

                        setState(() {
                          isButtonEnabled = int.tryParse(english) != null &&
                              english.length == 6;
                        });
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: "کد ورود",
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: "123456",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
              const SizedBox(height: 70),
              const Text("دریافت کد جدید"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextButton(
                    onPressed: isButtonEnabled
                        ? () {
                            final input = phoneController.text;

                            if (input.length == 6) {
                              context.go('/home');
                            } else {
                              setState(() {
                                errorText = "کد وارد شده باید ۶ رقمی باشد";
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
