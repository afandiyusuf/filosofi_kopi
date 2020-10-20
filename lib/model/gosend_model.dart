class Gosend {
  final String shipmentMethod;
  final String shipmentMethodDescription;
  final bool serviceable;
  final bool active;
  final double distance;
  final int price;
  Gosend(
      {this.shipmentMethod,
      this.shipmentMethodDescription,
      this.serviceable,
      this.active,
      this.distance,
      this.price});

  factory Gosend.fromJson(data) {
    int price = 0;
    if(data['price'] != null){
      price = data['price']['total_price'];
    }
    return Gosend(
        shipmentMethod: data['shipment_method'],
        shipmentMethodDescription: data['shipment_method_description'],
        serviceable: data['serviceable'],
        active: data['active'],
        distance: data['distance'],
        price: price
    );
  }
}
