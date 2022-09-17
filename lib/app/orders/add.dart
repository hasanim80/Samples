import 'package:flutter/material.dart';
import '../../components/crud.dart';
import '../../components/customtextform.dart';
import '../../components/valid.dart';
import '../../constant/linkapi.dart';
import '../../main.dart';

//import 'package:noteapp/components/crud.dart';
//import 'package:noteapp/components/customtextform.dart';
//import 'package:noteapp/components/valid.dart';
//import 'package:noteapp/constant/linkapi.dart';
//import 'package:noteapp/main.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>(); // for validator
  TextEditingController qualityType = TextEditingController();
  TextEditingController qualityName = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController finishType = TextEditingController();

  bool isLoading = false;

  AddOrder() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkAddOrders, {
        "type": qualityType.text,
        "name": qualityName.text,
        "length": length.text,
        "color": color.text,
        "finish": finishType.text,
        "id": sharedPref.getString("id")
      });
      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  // Empty note alert dialog function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Warning!",
            style: TextStyle(color: Colors.red),
          ),
          content: new Text(
            "It is not possible to add a missing order.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: new Text("Ok"),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 209, 211, 212),
                  primary: Colors.indigo),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Order"),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(children: [
                  CustomTextFormSign(
                      hint: "Quality Type",
                      height: 50,
                      mycontroller: qualityType,
                      valid: (val) {
                        return validInput(val!, 0, 45);
                      },
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.high_quality)), //Icons.high_quality,
                      icon2: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.close))), //Icons.close),
                  CustomTextFormSign(
                      hint: "Quality",
                      height: 50,
                      mycontroller: qualityName,
                      valid: (val) {
                        return validInput(val!, 0, 45);
                      },
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.high_quality)), //Icons.high_quality,
                      icon2: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.close))), //Icons.close),
                  CustomTextFormSign(
                      hint: "Length           m",
                      height: 50,
                      mycontroller: length,
                      valid: (val) {
                        return validInput(val!, 0, 1000);
                      },
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons
                              .interpreter_mode)), //Icons.interpreter_mode,
                      icon2: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.close))), //Icons.close),
                  CustomTextFormSign(
                      hint: "Color",
                      height: 50,
                      mycontroller: color,
                      valid: (val) {
                        return validInput(val!, 0, 45);
                      },
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.color_lens)), //Icons.color_lens,
                      icon2: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.close))), //Icons.close),
                  CustomTextFormSign(
                      hint: "Finish",
                      height: 50,
                      mycontroller: finishType,
                      valid: (val) {
                        return validInput(val!, 0, 45);
                      },
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.attach_email)), //Icons.attach_email,
                      icon2: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.close))), //Icons.close),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (qualityName.text.isNotEmpty &&
                          length.text.isNotEmpty &&
                          color.text.isNotEmpty &&
                          finishType.text.isNotEmpty) {
                        await AddOrder();
                        qualityName.text = "";
                        length.text = "";
                        color.text = "";
                        finishType.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      } else {
                        _showDialog();
                      }
                    },
                    child: Text("Add"),
                    textColor: Colors.black,
                    color: Colors.blue,
                  )
                ]),
              ),
            ),
    );
  }
}
