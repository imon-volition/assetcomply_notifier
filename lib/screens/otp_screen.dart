import 'package:assetcomply_notifier/constants/colors.dart';
import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // Set minimum height equal to screen height
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/images/otp.png',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "OTP Verification",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please enter your OTP to proceed. You can find it on the Assetcomply web portal. ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Pinput(
                      length: 4,
                      // defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,

                      showCursor: true,
                      onCompleted: (pin) => dataProvider.otp = int.parse(pin),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: !dataProvider.isLoading
                            ? () {
                                dataProvider.connectToServer(context);
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LabStatusScreen()));
                              }
                            : null,
                        child: Text(
                          dataProvider.isLoading ? (dataProvider.totalPages == 1 ? "Fetching Data..." : "Fetching Data (${dataProvider.currentPage} / ${dataProvider.totalPages})") : "Connect Now",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !dataProvider.isLoading,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Edit Cath Lab Number ?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
