import 'package:supercharged/supercharged.dart';
class Gosend {
  final String shipmentMethod;
  final String shipmentMethodDescription;
  final bool serviceable;
  final bool active;
  final double distance;
  final double price;
  Gosend(
      {this.shipmentMethod,
      this.shipmentMethodDescription,
      this.serviceable,
      this.active,
      this.distance,
      this.price});

  factory Gosend.fromJson(data) {
    double price = 0;
    if(data['price'] != null){
      price =  "${data['price']['total_price']}".toDouble();
    }
    return Gosend(
        shipmentMethod: data['shipment_method'] ?? null,
        shipmentMethodDescription: data['shipment_method_description']?? null,
        serviceable: data['serviceable']?? null,
        active: data['active'] == null ? null : data['active'],
        distance: data['distance'] ==  null ? null : "${data['distance']}".toDouble(),
        price: price
    );
  }
}
