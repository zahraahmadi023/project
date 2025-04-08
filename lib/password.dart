import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Pass extends StatefulWidget {
  final String number;
  Pass({super.key, required this.number});

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  bool isButtonEnabled = false;
  String? errorText;

  String convertToEnglishNumbers(String input) {
    const Map<String, String> numbersMap = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    numbersMap.forEach((key, value) {
      input = input.replaceAll(key, value);
    });

    return input;
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
                " ارسال شده است 0${widget.number}کد به این شماره ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        onChanged: (value) {
                          String english = convertToEnglishNumbers(value);

                          if (english != value) {
                            phoneController.value = TextEditingValue(
                              text: english,
                              selection: TextSelection.collapsed(
                                  offset: english.length),
                            );
                          }

                          setState(() {
                            isButtonEnabled = int.tryParse(value) != null;
                          });
                        },
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "کد ورود",
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: "123456",
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
                                convertToEnglishNumbers(phoneController.text);
                            String? phoneCode =
                                selectedCountry?.phoneCode ?? '98';

                            if (input.length != 8 ||
                                (phoneCode == '98' &&
                                    !(input.startsWith('90') ||
                                        input.startsWith('91') ||
                                        input.startsWith('93')))) {
                              setState(() {
                                errorText = ' کد وارد شده استباه است ';
                              });
                            } else {
                              setState(() {
                                errorText = null;
                              });
                              context.go('/second');
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
