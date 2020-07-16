class StoreDatas {
  List<Store> _stores = [
    Store(id:1,name:"Kedai Melawai",location: "Blok M", image:"https://picsum.photos/250?image=1"),
    Store(id:2,name: "Kedai Jogja", location: "Jogja",  image:"https://picsum.photos/250?image=2"),
    Store(id:3,name: "Kedai Semarang", location: "Semarang",  image:"https://picsum.photos/250?image=3"),
    Store(id:4,name: "",location: "Cilendak",  image:"https://picsum.photos/250?image=4"),
    Store(id:5,name: "Kedai Makassar",location: "Makassar",  image:"https://picsum.photos/250?image=5")
  ];
  List<Store> getStoreDatas(){
    return _stores;
  }
  int getTotalStore(){
    return _stores.length;
  }
  Store getStoreById(int id){
    return _stores.firstWhere((storeData) => storeData.id == id);
  }
  Store getStoreByIndex(int index){
    return _stores[index];
  }
}
class Store{
  final String name;
  final String location;
  final int id;
  final String image;
  Store({this.id, this.name,this.location , this.image});
}