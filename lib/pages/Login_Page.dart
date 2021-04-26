import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:wooadmin/models/login_model.dart';
import 'package:wooadmin/pages/Home_Page.dart';
import 'package:wooadmin/services/api_service.dart';
import '../utils/FormHelper.dart';
import '../utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicall = false;
  late LoginModel loginModel;

  @override
  void initState() {
    super.initState();
    loginModel = new LoginModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApicall,
          child: Form(
            key: globalFormKey,
            child: _loginui(context),
          ),
        ),
      ),
    );
  }

  Widget _loginui(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'WooAdmin',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                top: 20,
              ),
              child: Text(
                "Admin Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.web),
              'host',
              'Host URL',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "Host can't be empty";
                }
                return null;
              },
              (onSaved) {
                this.loginModel.host = onSaved;
              },
              initialValue: this.loginModel.host,
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.lock),
              'consumerkey',
              'Consumer Key',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "Consumer Key can't be empty";
                }
                return null;
              },
              (onSaved) {
                this.loginModel.consumerKey = onSaved;
              },
              initialValue: this.loginModel.consumerKey,
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.security),
              'consumersecret',
              'Consumer Secret',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "Consumer Secret can't be empty";
                }
                return null;
              },
              (onSaved) {
                this.loginModel.consumerSecret = onSaved;
              },
              initialValue: this.loginModel.consumerSecret,
              borderFocusColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              child: Icon(
                Icons.qr_code,
                size: 100,
              ),
              onTap: () async {
                await scanQR();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateandsave()) {
                  setState(() {
                    this.isApicall = true;
                  });
                  APIService.checklogin(this.loginModel).then((value) {
                    setState(() {
                      this.isApicall = false;
                    });
                    if (value) {
                      Get.offAll(() => HomePage());
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        "WooAdmin",
                        "Invalid Details",
                        "Try Again",
                        () {
                          setState(() {
                            this.loginModel.consumerKey = "";
                            this.loginModel.consumerSecret = "";
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    String? barcoderes;
    try {
      barcoderes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancle",
        true,
        ScanMode.QR,
      );
    } on PlatformException {}
    if (!mounted) return;
    setState(() {
      if (barcoderes != null &&
          barcoderes.isNotEmpty &&
          barcoderes.split("|").length == 2) {
        this.loginModel.consumerKey = barcoderes.split("|")[0];
        this.loginModel.consumerSecret = barcoderes.split("|")[1];
      } else {
        SnackBar(
          content: Text("Wrong QR code"),
          backgroundColor: Colors.red,
        );
      }
    });
  }

  bool validateandsave() {
    var form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
