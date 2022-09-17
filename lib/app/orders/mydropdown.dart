import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samplesorder/components/crud.dart';
import 'package:samplesorder/components/customtextform.dart';
import 'package:samplesorder/components/valid.dart';
import 'package:samplesorder/constant/linkapi.dart';
import 'package:samplesorder/main.dart';
//import http package manually

class MyDropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDropDown();
  }
}

class _MyDropDown extends State<MyDropDown> with Crud {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController notevalue = TextEditingController();
  TextEditingController lengthvalue = TextEditingController();
  String? denimnamecompare,
      qualitynamecompare,
      finishnamecompare,
      colornamecompare,
      message; // bunlar dropdowndai degerleri karsilastirmak icin
  String? qualityvalue, finishvalue, colorvalue, doorvalue;
  bool? error;
  var data, datafinish, datacolor, datadoor;
  bool isLoading = false;
  void showDialogDrop(String str) {
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
            "$str",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new TextButton(
              child: new Text("Ok"),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 209, 211, 212),
                  primary: Colors.indigo),
              //color: Color.fromARGB(255, 209, 211, 212),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> AddOrder() async {
    isLoading = true;
    setState(() {});
    if (notevalue.text.isEmpty) {
      notevalue.text = "No note added";
    }

    var response = await postRequest(linkDropDownAddOrder, {
      "qualitytype": denimnamecompare,
      "qualityname": qualityvalue,
      "finishtype": finishvalue,
      "color": colorvalue,
      "length": lengthvalue.text,
      "ordernote": notevalue.text,
      "id": sharedPref.getString("id"),
    });
    isLoading = false;
    setState(() {});

    if (response['status'] == "success") {
      Navigator.of(context).pushReplacementNamed("home");
    }
  }

  List<String> fabric = ["Denim", "Gabardin"];
  //we make list of strings with the name of fabric
  @override
  void initState() {
    error = false;
    message = "";
    denimnamecompare = "Denim"; //default Fabric
    super.initState();
  }

  Future<void> getQuality() async {
    var res = await http.post(Uri.parse(linkDropDownQuality +
        "?fabric=" +
        Uri.encodeComponent(denimnamecompare!)));
    //attache denimname on parameter country in url
    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
        if (data["error"]) {
          //check if there is any error from server.
          error = true;
          message = data["errmsg"]; /*No any data to show.*/
        }
      });
    } else {
      //there is error
      setState(() {
        error = true;
        message = "Error during fetching data";
      });
    }
  }

  Future<void> getFinish() async {
    var res = await http.post(Uri.parse(linkDropDownFinish +
        "?quality=" +
        Uri.encodeComponent(qualitynamecompare!)));
    if (res.statusCode == 200) {
      setState(() {
        datafinish = json.decode(res.body);
        if (datafinish["error"]) {
          error = true;
          message = datafinish["errmsg"]; /*No any data to show. from town*/
        }
      });
    } else {
      //there is error
      setState(() {
        error = true;
        message = "error during fetching data";
      });
    }
  }

  Future<void> getColor() async {
    var res = await http.post(Uri.parse(linkDropDownColor +
        "?finish=" +
        Uri.encodeComponent(finishnamecompare!)));
    if (res.statusCode == 200) {
      setState(() {
        datacolor = json.decode(res.body);
        if (datacolor["error"]) {
          error = true;
          message = datacolor["errmsg"]; /*No any data to show. from street*/
        }
      });
    } else {
      //there is error
      setState(() {
        error = true;
        message = "error during fetching data";
      });
    }
  }

  /*Future<void> getDoor() async {
    var res = await http.post(Uri.parse(linkDropDownDoor +
        "?street=" +
        Uri.encodeComponent(colornamecompare!)));
    if (res.statusCode == 200) {
      setState(() {
        datadoor = json.decode(res.body);
        if (datadoor["error"]) {
          error = true;
          message = datadoor["errmsg"]; /*No any data to show. from door*/
        }
      });
    } else {
      //there is error
      setState(() {
        error = true;
        message = "error during fetching data";
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Qualities List"),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.orange,
                  backgroundColor: Colors.blueGrey,
                ))
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(children: <Widget>[
                        Container(
                          //wrapper for Country list
                          child: DropdownButton(
                            isExpanded: true,
                            value: denimnamecompare,
                            hint: Text("Select Fabric Type !"),
                            items: fabric.map((fabricone) {
                              return DropdownMenuItem(
                                child: Text(fabricone), //label of item
                                value: fabricone, //value of item
                              );
                            }).toList(),
                            onChanged: (value) {
                              denimnamecompare =
                                  value as String; //change the country name

                              setState(() async {
                                getQuality(); // get quality list
                                datafinish = null;
                                datacolor = null;
                                datadoor = null;
                                qualityvalue = null;
                                finishvalue = null;
                                colorvalue = null;
                                //doorvalue = null;
                              });
                            },
                          ),
                        ),
                        Container(
                          //wrapper for City list
                          margin: EdgeInsets.only(top: 30),
                          child: error!
                              ? Text(message!)
                              : data == null
                                  ? Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 231, 232, 235),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Choose Fabric Type !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : qualityList(),
                          //if there is error then show error message,
                          //else check if data is null,
                          //if not then show city list,
                        ),
                        Container(
                          //wrapper for Town list
                          margin: EdgeInsets.only(top: 30),
                          child: error!
                              ? Text(message!)
                              : datafinish == null
                                  ? Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 231, 232, 235),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Choose Quality !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : finishList(),
                          //if there is error then show error message,
                          //else check if data is null,
                          //if not then show town list,
                        ),
                        Container(
                          //wrapper for Street list
                          margin: EdgeInsets.only(top: 30),
                          child: error!
                              ? Text(message!)
                              : datacolor == null
                                  ? Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 231, 232, 235),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Choose Color !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : colorList(),
                          //if there is error then show error message,
                          //else check if data is null,
                          //if not then show street list,
                        ),
                        /*Container(
                          //wrapper for Door list
                          margin: EdgeInsets.only(top: 30),
                          child: error!
                              ? Text(message!)
                              : datadoor == null
                                  ? Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 231, 232, 235),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Choose Door No !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : doorList(),
                          //if there is error then show error message,
                          //else check if data is null,
                          //if not then show street list,
                        ),*/
                        Container(
                          height: 15,
                        ),
                        Container(
                            child: CustomTextFormSign(
                              keyboardType: TextInputType.number,
                                hint: "Length m",
                                height: 50,
                                mycontroller: lengthvalue,
                                valid: (val) {
                                  validInput(val!, 1, 3);
                                },
                                icon: IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons
                                        .align_vertical_center_rounded)), //Icons.note,
                                icon2: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.close))) //Icons.close),
                            ),
                        Container(
                            child: CustomTextFormSign(
                                hint: "note",
                                height: 50,
                                mycontroller: notevalue,
                                valid: (val) {
                                  //return validNote(notevalue.text);
                                },
                                icon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.note)), //Icons.note,
                                icon2: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.close))) //Icons.close),
                            ),
                        MaterialButton(
                          onPressed: () async {
                            if (qualityvalue != null &&
                                qualitynamecompare != null &&
                                finishvalue != null &&
                                colorvalue != null) {
                              if (lengthvalue.text.isEmpty) {
                                showDialogDrop("Empty length cannot be added");
                              } else {
                                await AddOrder();
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            } else {
                              showDialogDrop("Empty feild cannot be added");
                            }
                          },
                          child: Text(
                            "Order",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          textColor: Colors.white,
                          color: Colors.indigo,
                        ),
                      ]),
                    ),
                  ],
                ),
        ));
  }

  Widget qualityList() {
    //widget function for city list
    List<QualityOne> qualitylist = List<QualityOne>.from(data["data"].map((i) {
      return QualityOne.fromJSON(i);
    })); //searilize qualitylist json data to object model.
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          value: qualityvalue,
          hint: Text("Select Quality Name !"),
          isExpanded: true,
          items: qualitylist.map((qualityOne) {
            return DropdownMenuItem(
              child: Text(qualityOne.qualityname),
              value: qualityOne.qualityname,
            );
          }).toList(),
          onChanged: (NewValue) {
            setState(() {
              qualityvalue = NewValue as String;
              qualitynamecompare = qualityvalue;
              getFinish();
              datacolor = null;
              datadoor = null;
              finishvalue = null;
              colorvalue = null;
              //doorvalue = null;
              //data = null;
            });
            qualityvalue = NewValue as String;
            qualitynamecompare = qualityvalue;
            //print("Selected city is $Newalue");
          }),
    );
  }

  Widget finishList() {
    //widget function for town list
    List<FinishOne> finishlist =
        List<FinishOne>.from(datafinish["data"].map((i) {
      return FinishOne.fromJSON(i);
    })); //searilize town json data to object model.
    //String finishvalue = "Choose";
    return DropdownButton(
        value: finishvalue,
        hint: Text("Select Finish Type !"),
        isExpanded: true,
        items: finishlist.map((finishOne) {
          return DropdownMenuItem(
            child: Text(finishOne.finishname),
            value: finishOne.finishname,
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            finishvalue = newValue as String;
            finishnamecompare = finishvalue;
            getColor();
            datadoor = null;
            colorvalue = null;
            //doorvalue = null;
          });
          finishvalue = newValue as String;
          finishnamecompare = finishvalue;
          //print("Selected town is $newValue");
        });
  }

  Widget colorList() {
    //widget function for street list
    List<ColorOne> colorlist = List<ColorOne>.from(datacolor["data"].map((i) {
      return ColorOne.fromJSON(i);
    })); //searilize street json data to object model.

    return DropdownButton(
        value: colorvalue,
        hint: Text("Select Color"),
        isExpanded: true,
        items: colorlist.map((colorOne) {
          return DropdownMenuItem(
            child: Text(colorOne.colorname),
            value: colorOne.colorname,
          );
        }).toList(),
        onChanged: (NewValue) {
          setState(() {
            colorvalue = NewValue as String;
            colornamecompare = colorvalue;
            //getDoor();
            //doorvalue = null;
          });
          colorvalue = NewValue as String;
          colornamecompare = colorvalue;
          //print("Selected street is $value");
        });
  }

  /*Widget doorList() {
    //widget function for door list
    List<DoorOne> doorlist = List<DoorOne>.from(datadoor["data"].map((i) {
      return DoorOne.fromJSON(i);
    })); //searilize doorlist json data to object model.
    return DropdownButton(
        value: doorvalue,
        hint: Text("Door number"),
        isExpanded: true,
        items: doorlist.map((doorOne) {
          return DropdownMenuItem(
            child: Text(doorOne.doornumber),
            value: doorOne.doornumber,
          );
        }).toList(),
        onChanged: (NewValue) {
          setState(() {
            doorvalue = NewValue as String;
          });
          doorvalue = NewValue as String;
          //print("Selected street is $value");
        });
  }*/
}

//model class to searilize country list JSON data.
class QualityOne {
  String /*id, */ denimname, qualityname;
  QualityOne({
    //required this.id,
    required this.denimname,
    required this.qualityname,
  });

  factory QualityOne.fromJSON(Map<String, dynamic> json) {
    return QualityOne(
      //id: json["city_id"],
      denimname: json["quality_type"], //country_name
      qualityname: json["quality_name"], //city_name
    );
  }
}

class FinishOne {
  String quality, finishname;
  FinishOne({required this.quality, required this.finishname});

  factory FinishOne.fromJSON(Map<String, dynamic> json) {
    return FinishOne(
        quality: json["quality_name"], finishname: json["finish_type"]);
  }
}

class ColorOne {
  String finish, colorname;
  ColorOne({required this.finish, required this.colorname});

  factory ColorOne.fromJSON(Map<String, dynamic> json) {
    return ColorOne(finish: json["finish_type"], colorname: json["color"]);
  }
}

class DoorOne {
  String street, doornumber;
  DoorOne({required this.street, required this.doornumber});

  factory DoorOne.fromJSON(Map<String, dynamic> json) {
    return DoorOne(
        street: json["street_name"], doornumber: json["door_number"]);
  }
}
