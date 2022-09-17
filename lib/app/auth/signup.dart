import 'package:flutter/material.dart';
import 'package:samplesorder/components/crud.dart';
import 'package:samplesorder/components/customtextform.dart';
import 'package:samplesorder/components/valid.dart';
import 'package:samplesorder/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();

  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController telephone = TextEditingController();
  signUp() async {
    if (formstate.currentState!
            .validate() /*&&
        (password.text == confirmPassword.text)*/
        ) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
        "address": address.text,
        "telephone": telephone.text,
        //"confirm password": confirmPassword,
      });

      isLoading = false;
      setState(() {});
      if (password.text == confirmPassword.text) {
        if (response['status'] == "success") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("success", (route) => false);
        } else {
          print("Signing up faild");
        }
      } else {
        print("The passwords don't match");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Container(
                            height: 15,
                          ),
                          Image.asset(
                            "images/logo.png",
                            width: 150,
                            height: 150,
                          ),
                          Container(
                            height: 25,
                          ),
                          CustomTextFormSign(
                              keyboardType: TextInputType.multiline,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.person)), //Icons.person,
                              valid: (val) {
                                return validInput(val!, 5, 20);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    username.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: username,
                              height: 40,
                              hint: "username"),
                          CustomTextFormSign(
                              keyboardType: TextInputType.multiline,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.email)), //Icons.email,
                              valid: (val) {
                                return validInput(val!, 11, 40);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    email.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: email,
                              height: 40,
                              hint: "email"),
                          CustomTextFormSign(
                              keyboardType: TextInputType.multiline,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons
                                      .location_city)), //Icons.location_city,
                              valid: (val) {
                                return validInput(val!, 10, 100);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    address.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: address,
                              height: 40,
                              hint: "address"),
                          CustomTextFormSign(
                              keyboardType: TextInputType.number,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons
                                      .contact_phone)), //Icons.contact_phone,
                              valid: (val) {
                                return validInput(val!, 10, 15);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    telephone.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: telephone,
                              height: 40,
                              hint: "telephone"),
                          CustomTextFormSign(
                              keyboardType: TextInputType.multiline,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.password)), //Icons.password,
                              valid: (val) {
                                return validInput(val!, 5, 15);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    password.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: password,
                              height: 40,
                              hint: "password"),
                          CustomTextFormSign(
                              keyboardType: TextInputType.multiline,
                              icon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.password)), //Icons.password,
                              valid: (val) {
                                return validInput(val!, 5, 15);
                              },
                              icon2: IconButton(
                                  onPressed: () {
                                    confirmPassword.clear();
                                  },
                                  icon: Icon(Icons.close)), //Icons.abc,
                              mycontroller: confirmPassword,
                              height: 40,
                              hint: "confirm password"),
                          MaterialButton(
                            color: Colors.indigo,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            onPressed: () async {
                              await signUp();
                            },
                            child: Text("SignUp"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: Text(
                              "have an account ?, Login",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("login");
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
