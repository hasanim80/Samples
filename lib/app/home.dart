import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samplesorder/app/orders/edit.dart';
import 'package:samplesorder/components/crud.dart';
import 'package:samplesorder/constant/linkapi.dart';
import 'package:samplesorder/main.dart';
import '../components/cardnote.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewOrders, {"id": sharedPref.getString("id")});

    return response;
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
  Color? switchColor;
  //TextEditingController note = TextEditingController();
  bool wantDelete = false;
  /*void showDialogDelete() {
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
          content: Text(
            "Are you sure you want to delete this order?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("Cancel"),
              color: Color.fromARGB(255, 209, 211, 212),
              onPressed: () {
                wantDelete = false;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes"),
              color: Color.fromARGB(255, 209, 211, 212),
              onPressed: () {
                wantDelete = true;
                Navigator.of(context).pushReplacementNamed("home");
              },
            )
          ],
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
        backgroundColor: Colors.indigo,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.question_answer),
              )),
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.of(context).pushNamed("mydropdown");
        },
        child: Icon(Icons.add_box),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail')
                      return Center(
                          child: Text(
                        "There are no orders here !",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ));

                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardOrders(
                            onDelete: () async {
                              //showDialogDelete();
                              var response =
                                  await postRequest(linkDeleteOrders, {
                                "orderid": snapshot.data['data'][i]['orders_id']
                                    .toString(),
                              });
                              if (response['status'] == "success") {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              } else {
                                print("Fail");
                              }
                            },
                            edit: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditOrders(
                                      dataeditorders: snapshot.data['data']
                                          [i])));
                            },

                            /*ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditOrders(
                                        orders: snapshot.data['data'][i])));
                            },*/
                            qualityType:
                                "${snapshot.data['data'][i]['quality_type']}",
                            qualityName:
                                "${snapshot.data['data'][i]['quality_name']}",
                            finishType:
                                "${snapshot.data['data'][i]['finish_type']}", // Here Just pass the string because Text wd cannot assign to string
                            color: "${snapshot.data['data'][i]['color']}",
                            length: "${snapshot.data['data'][i]['length']}",
                            note: "${snapshot.data['data'][i]['orders_notes']}",
                            orderStatus:
                                "${snapshot.data['data'][i]['orders_onay']}",
                            //snapshot.data['data'][i]['orders_time']
                            orderDate: snapshot.data['data'][i]['orders_time']
                                .toString(),
                          ); // Using  name in database
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading zzzzzz"),
                    );
                  }
                  return Center(
                    child: Text("Loading ....."),
                  );
                })
          ],
        ),
      ),
    );
  }
}
