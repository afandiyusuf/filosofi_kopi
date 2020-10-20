import 'dart:async';

import 'package:filkop_mobile_apps/model/address_model.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/screen/address_form.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class AddressPick extends StatefulWidget {
  final UserAddress userAddress;
  const AddressPick({Key key, this.userAddress}) : super(key: key);
  @override
  _AddressPickState createState() => _AddressPickState();
}

class _AddressPickState extends State<AddressPick> {
  GoogleMapController _controller;
  CameraPosition _cameraPosition;
  String currentAddress = '';
  CameraPosition lastCameraPosition;

  LatLng _center = const LatLng(-6.20876331457728, 106.84559896588326);

  final Set<Marker> _markers = {};
  Future<String> selectMapState;

  Future<String> updateMapState(String state) async {
    return state;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  void initState() {
    if(widget.userAddress != null){
      _center =  LatLng(widget.userAddress.latitude, widget.userAddress.longitude);
    }

    _cameraPosition = CameraPosition(
      target: _center,
      zoom: 11.0,
    );

    lastCameraPosition = _cameraPosition;
    _markers.add(
      Marker(
        markerId: MarkerId("cursor"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    super.initState();
  }



  void _updatePosition(CameraPosition _position) {
    lastCameraPosition = _position;



    MarkerId id = MarkerId('cursor');
    final marker = _markers.firstWhere((item) => item.markerId == id);
    Marker _marker = Marker(
      markerId: marker.markerId,
      onTap: () {},
      position: LatLng(_position.target.latitude, _position.target.longitude),
      icon: marker.icon,
      infoWindow: InfoWindow(title: 'Here'),
    );
//    updateAddress(_position);
    setState(() {
      Marker oldMarker =
          _markers.firstWhere((element) => element.markerId == id);
      _markers.remove(oldMarker);
      _markers.add(_marker);
    });
  }

  void updateAddress() async {
    final coordinates = new Coordinates(lastCameraPosition.target.latitude,
        lastCameraPosition.target.longitude);
    print("POSISI");

    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${coordinates.latitude} POSISI ${coordinates.longitude}");
    print(addresses.first.addressLine);
    setState(() {
      currentAddress = first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Create Address',
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 70,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _cameraPosition,
                zoomControlsEnabled: false,
                markers: _markers,
                onCameraMove: _updatePosition,
                myLocationButtonEnabled: true,
                onCameraIdle: () {
                  updateAddress();
                },
              )),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: SearchMapPlaceWidget(
              apiKey: 'AIzaSyCEkxzfBfmTsAlyUAYtPmDpbKMwf2g0Ybw',
              onSelected: (Place place) async {
                final geolocation = await place.geolocation;
                setState(() {
                  _controller.animateCamera(
                      CameraUpdate.newLatLngZoom(geolocation.coordinates, 15));
                });
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alamat:"),
                        Divider(height: 5,),
                        Text(currentAddress),
                      ],
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: PrimaryButton(label: 'Pilih',onPressed: (){
                     gotoDetailAddress(context);
                    },)),
              ],
            ),
          )
        ],
      ),
    );
  }
  void gotoDetailAddress(BuildContext context){
    UserAddress userAddress;
    bool isUpdate = false;
    if(widget.userAddress == null) {
       userAddress = UserAddress(
        id: 0.toString(),
        longitude: lastCameraPosition.target.longitude,
        latitude: lastCameraPosition.target.latitude,
        address: currentAddress,
      );
       isUpdate = false;
    }else{
      userAddress = widget.userAddress;
      userAddress.longitude = lastCameraPosition.target.longitude;
      userAddress.latitude = lastCameraPosition.target.latitude;
      userAddress.address = currentAddress;
      isUpdate = true;
    }
    Navigator.push(context,MaterialPageRoute(
        builder: (context) => AddressForm(address: userAddress,isUpdate: isUpdate,)
    ));
  }
}
