import 'package:flutter/material.dart';

class CardOrder extends StatelessWidget {
  final void Function()? ontap;
  /*final String qualityName;
  final String length;
  final String color;
  final String finishType;

  final void Function()? onDelete;*/

  const CardOrder({
    Key? key,
    this.ontap,
    /*required this.qualityName,
      required this.length,
      this.onDelete,
      required this.color,
      required this.finishType*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("\$2300 per month"),
                  subtitle: Text("2 bed, 1 bath, 1300 sqft"),
                  trailing: Icon(Icons.favorite_outline),
                ),
                Container(
                  height: 200.0,
                  child: Ink.image(
                    image: NetworkImage(
                        'https://source.unsplash.com/random/800x600?house'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Beautiful home to rent, recently refurbished with modern appliances..."),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      child: const Text('CONTACT AGENT'),
                      onPressed: () {/* ... */},
                    ),
                    TextButton(
                      child: const Text('LEARN MORE'),
                      onPressed: () {/* ... */},
                    )
                  ],
                )
              ],
            )));
  }
}
