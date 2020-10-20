import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final UserAddress userAddress;
  final Function onSelect;
  final Function onEdit;
  final Function onDelete;
  final bool usingActionButton;
  const AddressCard({Key key, this.userAddress, this.onSelect, this.onEdit,this.onDelete,this.usingActionButton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        onSelect();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userAddress.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                          Container(
//                              margin: EdgeInsets.only(top: 10),
//                              child: Text(userAddress.namePerson)),
//                          Container(
//                              margin: EdgeInsets.only(top: 10),
//                              child: Text(userAddress.phoneNumber)),
//                          Container(
//                              margin: EdgeInsets.only(top: 10),
//                              child: Text(userAddress.labelAddress)),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(userAddress.address)),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: usingActionButton,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              onEdit();
                            },
                            child:Container(
                              margin: EdgeInsets.only(top: 15,bottom: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.edit,size: 15,),
                                  Text("Ubah Alamat",style: TextStyle(
                                    fontSize: 11
                                  ),)
                                ],
                              ),
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: InkWell(
                                onTap: () {
                                  onDelete();
                                },
                                child:Container(
                                  margin: EdgeInsets.only(top: 15,bottom: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,size: 15,),
                                      Text("Hapus Alamat",style: TextStyle(
                                          fontSize: 11
                                      ),)
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: usingActionButton,
                child: InkWell(
                  onTap: (){
                    onSelect();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black),
                        color: Colors.white
                      ),
                      child: Visibility(
                        visible: (userAddress.selected == 1)? true:false,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
