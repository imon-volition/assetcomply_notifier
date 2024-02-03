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
      width: 80, // Increased size for TV
      height: 80, // Increased size for TV
      textStyle: const TextStyle(
        fontSize: 24, // Increased font size for TV
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    // ... other theme modifications ...

    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2, // Adjust the flex ratio as needed for desired sizing
                  child: Image.asset(
                    'assets/images/otp.png',
                    fit: BoxFit.fitWidth, // Adjust image fit as needed
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(40), // Adjust padding as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "OTP Verification",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Please enter your OTP to proceed. You can find it on the Assetcomply web portal.",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          Pinput(
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                            // ... other pin themes ...
                            showCursor: true,
                            onCompleted: (pin) => dataProvider.otp = int.parse(pin),
                          ),
                          const SizedBox(height: 60),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: !dataProvider.isLoading
                                ? () {
                                    dataProvider.connectToServer(context);
                                  }
                                : null,
                              child: Text(
                                dataProvider.isLoading ? "Fetching Data..." : "Connect Now",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: const Text(
                          //     "Can't Find OTP ?",
                          //     style: TextStyle(color: Colors.black, fontSize: 18),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




