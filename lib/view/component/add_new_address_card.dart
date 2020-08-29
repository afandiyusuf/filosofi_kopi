import 'package:flutter/material.dart';

class AddNewAddressCard extends StatelessWidget {
  final Function onTap;

  const AddNewAddressCard({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       onTap();
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [Icon(Icons.add), Text("Tambah Alamat")],
            ),
          ),
        ),
      ),
    );
  }
}
