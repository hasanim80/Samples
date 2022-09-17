import 'package:flutter/material.dart';
import '../../components/crud.dart';
import '../../components/customtextform.dart';
import '../../constant/linkapi.dart';
import 'package:intl/intl.dart';

class EditOrders extends StatefulWidget {
  final dataeditorders;
  const EditOrders({Key? key, this.dataeditorders}) : super(key: key);

  @override
  State<EditOrders> createState() => _EditOrdersState();
}

class _EditOrdersState extends State<EditOrders> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>(); // for validator
  TextEditingController length = TextEditingController();
  //TextEditingController qualityName = TextEditingController();

  bool isLoading = false;

  editOrders() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkEditOrders, {
        //"quality_name": qualityName.text,
        "length": length.text,
        "id": widget.dataeditorders['orders_id'].toString()
      });
      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("Faild");
      }
    }
  }

  // the default values of controller
  @override
  void initState() {
    length.text = widget.dataeditorders['length'];
    //qualityName.text = widget.orders['quality_name'];

    super.initState();
  }

  // Empty note alert dialog function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Warning!",
            style: TextStyle(color: Colors.red),
          ),
          content: new Text(
            "The feild cannot be empty.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey, primary: Colors.indigo),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
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
        title: Text("Edit Order"),
        backgroundColor: Colors.indigo,
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(children: [
                  CustomTextFormSign(
                      keyboardType: TextInputType.number,
                      hint: "length",
                      height: 50,
                      mycontroller: length,
                      valid: (val) {
                        //return validInput(val!, 0, 45);
                      },
                      icon: IconButton(
                          onPressed: null, icon: Icon(Icons.abc_rounded)),
                      icon2: IconButton(
                          onPressed: () {
                            length.clear();
                          },
                          icon: Icon(Icons.clear))),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (length.text.isNotEmpty) {
                        await editOrders();
                        length.text = "";
                        Navigator.of(context).pushReplacementNamed("home");
                      } else {
                        _showDialog();
                      }
                    },
                    child: Text("Save"),
                    textColor: Colors.black,
                    color: Colors.indigo,
                  )
                ]),
              ),
            ),
    );
  }
}
