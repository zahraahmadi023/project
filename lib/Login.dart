import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  final TextEditingController phoneController = TextEditingController();

  bool isRed = false;

  void _toggleColor() {
    setState(() {
      isRed = !isRed;
    });
  }

  Country? selectedCountry;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "شماره همراه",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("23.25.2"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                " لطفا کشور و شماره همراه خود را وارد کنید ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  _toggleColor();

                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: const CountryListThemeData(
                      flagSize: 40,
                    ),
                    onSelect: (value) {
                      setState(() {
                        selectedCountry = value as Country?;
                      });
                    },
                  );
                },
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isRed ? Colors.black : Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCountry == null
                            ? "+98"
                            : "+${selectedCountry!.phoneCode}"),
                        const SizedBox(width: 8),
                        Text(selectedCountry == null
                            ? "Iran"
                            : "${selectedCountry!.name} ${selectedCountry!.flagEmoji}"),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                ]),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 8,
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
                        decoration: InputDecoration(
                          //hintTextDirection: Alignment.centerLeft,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // alignLabelWithHint: true,
                          labelText: "شماره همراه",
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: "  912865423",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          suffixText: selectedCountry != null
                              ? " |  ${selectedCountry!.phoneCode} + "
                              : "|  98 +",
                          suffixStyle:
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
                  ),
                  if (errorText != null)
                    Text(
                      textAlign: TextAlign.right,
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
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
                    onPressed: isButtonEnabled
                        ? () {
                            //context.go('/second');
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
                                errorText = 'شماره همراه درست وارد نشده است ';
                              });
                            } else {
                              setState(() {
                                errorText = null;
                              });
                              final input = phoneController.text;
                              // رفتن به صفحه دوم و فرستادن مقدار داخل URL
                              context.go('/second/$input');
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
