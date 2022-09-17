import 'package:flutter/material.dart';
import 'package:samplesorder/components/crud.dart';

class CardOrders extends StatefulWidget {
  final Function()? edit;
  final String qualityType;
  final String qualityName;
  final String finishType;
  final String color;
  final String length;
  final String note;
  final String orderDate;
  final String? orderStatus;
  final void Function()? onDelete;

  const CardOrders(
      {Key? key,
      this.edit,
      required this.qualityType,
      required this.qualityName,
      required this.length,
      required this.color,
      required this.finishType,
      required this.note,
      required this.orderDate,
      this.orderStatus,
      this.onDelete})
      : super(key: key);
  @override
  State<CardOrders> createState() => _CardOrdersState();
}

class _CardOrdersState extends State<CardOrders> with Crud {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${widget.qualityName}",
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.indigo,
                        ),
                        onPressed: widget.edit,
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
                child: RichText(
                    text: TextSpan(
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Color  : ${widget.color}\n",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(
                          text: "Length : ${widget.length} m\n",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(
                          text: "Finish : ${widget.finishType}\n",
                          style: TextStyle(color: Colors.black87)),
                      TextSpan(
                          text: "Order Date : ${widget.orderDate}",
                          style: TextStyle(color: Colors.black87)),
                    ]))

                /*Text(
                "Color : ${widget.color}\nLength : ${widget.length} m\nFinish Type : ${widget.finishType}",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),*/
                ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 400,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo),
                  //color: Colors.black,
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Order Note : ${widget.note}\n",
                          style: TextStyle(
                              color: Color.fromARGB(255, 6, 101, 197))),
                      TextSpan(
                          text: widget.orderStatus == "Waiting"
                              ? "\nOrder Status : ${widget.orderStatus}......"
                              : "\nOrder Status : ${widget.orderStatus}",
                          style: TextStyle(
                            color: widget.orderStatus == "Approved"
                                ? Color.fromARGB(255, 2, 195, 101)
                                : widget.orderStatus == "Rejected"
                                    ? Color.fromARGB(255, 228, 21, 6)
                                    : Colors.black,
                          )),
                    ],
                  )),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                /*TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: widget.edit,
                ),*/
                /*TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                    child: const Text(
                      '  Onayla  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {/* ... */},
                  )*/
              ],
            )
          ],
        ));
  }
}
