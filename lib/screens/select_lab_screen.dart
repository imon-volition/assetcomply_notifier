import 'package:assetcomply_notifier/constants/colors.dart';
import 'package:assetcomply_notifier/screens/otp_screen.dart';
import 'package:assetcomply_notifier/utils/ui_utils.dart';
import 'package:assetcomply_notifier/widgets/circular_card_buttons_widget.dart';
import 'package:flutter/material.dart';

class SelectLabScreen extends StatefulWidget {
  const SelectLabScreen({Key? key}) : super(key: key);

  @override
  State<SelectLabScreen> createState() => _SelectLabScreenState();
}

class _SelectLabScreenState extends State<SelectLabScreen> {
  TextEditingController countryController = TextEditingController();

  

  @override
  void initState() {
    super.initState();
    UiUtils.setMaxBrightnessAndWakeLock();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/select.png',
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Select Cath Lab",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please select Cath Lab number to proceed!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const CircularCardButtons(),
              const SizedBox(
                height: 20,
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OtpScreen()));
                    },
                    child: const Text("Proceed")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
