import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:samplesorder/components/crud.dart';
import 'package:samplesorder/components/customtextform.dart';
import 'package:samplesorder/constant/linkapi.dart';
import 'package:samplesorder/main.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;
  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });

      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString("userstype", response['data']['users_type']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            btnOkOnPress: () {},
            title: "Attention",
            body: Text(
              "The email or password is incorrect",
              style: TextStyle(color: Color.fromARGB(255, 245, 3, 3)),
            ))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                      ),
                      Image.asset(
                        "images/sharabati.png",
                        width: 200,
                        height: 200,
                        color: Colors.indigo,
                      ),
                      Container(
                        height: 0.0,
                      ),
                      CustomTextFormSign(
                          keyboardType: TextInputType.emailAddress,
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          icon2: IconButton(
                              onPressed: () {
                                email.clear();
                              },
                              icon: Icon(Icons.close)), //Icons.abc,
                          icon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.email)), //Icons.email,
                          mycontroller: email,
                          height: 40,
                          hint: "email"),
                      CustomTextFormSign(
                          keyboardType: TextInputType.visiblePassword,
                          icon2: IconButton(
                              onPressed: () {
                                password.clear();
                              },
                              icon: Icon(Icons.close)), //Icons.abc,
                          icon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.password)), //Icons.password,
                          valid: (val) {
                            return validInput(val!, 5, 15);
                          },
                          mycontroller: password,
                          height: 40,
                          hint: "password"),
                      MaterialButton(
                        color: Colors.indigo,
                        textColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        onPressed: () async {
                          await login();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: Text(
                          "Don't have an account? , Click for signup",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
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
