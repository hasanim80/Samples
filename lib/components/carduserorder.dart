import 'package:flutter/material.dart';

class CardUserOrder extends StatefulWidget {
  final void Function()? ontap;
  final String qualityType;
  final String qualityName;
  final String finishType;
  final String color;
  final String length;
  final String note;
  final void Function()? onDelete;
  const CardUserOrder(
      {Key? key,
      this.ontap,
      required this.qualityType,
      required this.qualityName,
      required this.length,
      required this.color,
      required this.finishType,
      required this.note,
      this.onDelete})
      : super(key: key);

  @override
  State<CardUserOrder> createState() => _CardUserOrderState();
}

class _CardUserOrderState extends State<CardUserOrder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  color: Color.fromARGB(255, 213, 205, 205),
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Container(
                        // color: Color.fromARGB(255, 213, 205, 205),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Image.asset(
                                  "images/logo.png",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.scaleDown,
                                )),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "${widget.qualityType}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${widget.qualityName}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: widget.onDelete,
                                ),
                                /*trailing: IconButton(
                                          focusColor: Colors.red,
                                          color: Colors.indigo,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed("editorder");
                                          },
                                          icon: Icon(Icons.edit))*/
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Color : ${widget.color}\nLength : ${widget.length} m\nFinish Type : ${widget.finishType}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.indigo),
                            //color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Order Note : ${widget.note}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Container(height: 25),
                      /*ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              /*TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.indigo),
                                child: const Text(
                                  'Contact',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {/* ... */},
                              ),*/
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.indigo),
                                child: const Text(
                                  '  Onayla  ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {/* ... */},
                              )
                            ],
                          )*/
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
