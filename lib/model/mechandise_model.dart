class MerchandiseModel {
  List<Merchandise> _list = [
    Merchandise(id:1,name:"Special Sale Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:2,name:"Apparel T-shirt",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Merchandise(id:3,name:"Special Sale Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:4,name:"Special new arrival",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:5,name:"Apparel Hoodie",image:"https://picsum.photos/250?image=1",price: "75000",category: 2, subCategory: 2),
    Merchandise(id:6,name:"Special new arrival Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:7,name:"Accesories new Arrival",image:"https://picsum.photos/250?image=1",price: "75000",category: 3),
    Merchandise(id:8,name:"Accesories Sale",image:"https://picsum.photos/250?image=1",price: "75000",category: 3, subCategory: 2),
    Merchandise(id:9,name:"Special new arrival Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:10,name:"Apparel T-shirt",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Merchandise(id:11,name:"Perfecto new arrival Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:12,name:"Perfecto new arrival Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:13,name:"Apparel T-shirt",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Merchandise(id:14,name:"Perfecto  Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:15,name:"Accesories new Arrival",image:"https://picsum.photos/250?image=1",price: "75000",category: 3),
    Merchandise(id:16,name:"Accesories Sale",image:"https://picsum.photos/250?image=1",price: "75000",category: 3, subCategory: 2),
    Merchandise(id:17,name:"Perfecto Sale Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:18,name:"Apparel Hoodie",image:"https://picsum.photos/250?image=1",price: "75000",category: 2, subCategory: 2),
    Merchandise(id:19,name:"Special Sale Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:20,name:"Special new arrival Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1),
    Merchandise(id:21,name:"Apparel T-shirt",image:"https://picsum.photos/250?image=1",price: "75000",category: 2),
    Merchandise(id:22,name:"Special Sale Iced Black",image:"https://picsum.photos/250?image=1",price: "75000",category: 1, subCategory: 2),
    Merchandise(id:23,name:"Accesories Sale",image:"https://picsum.photos/250?image=1",price: "75000",category: 3, subCategory: 2),
    Merchandise(id:24,name:"Accesories new Arrival",image:"https://picsum.photos/250?image=1",price: "75000",category: 3),
  ];
  List<Merchandise> _finalList;
  List<Merchandise> _initProducts;
  int _subCategorySelected = 0;

  MerchandiseModel(){
    _initProducts = List.of(_list);
    _finalList = List.of(_list);
  }
  int getTotal(){
    return _finalList.length;
  }

  Merchandise getById(int id){
    return _list.firstWhere((element) => element.id == id);
  }
  Merchandise getByIndex(int index){
    return _finalList[index];
  }
  setByCateogory(int category){
    _subCategorySelected = 0;
    if(category == 0){
      reset();
    }else {
      _list = List.of(
          _initProducts.where((element) => element.category == category));
      _finalList = List.of(_list);
    }
  }
  setBySubCategory(int subCategory){
    _subCategorySelected = subCategory;
    if(_subCategorySelected != 0)
      _finalList = List.of(_list.where((element) => element.subCategory == subCategory));
    else
      _finalList = List.of(_list);
  }
  reset(){
    _list = List.of(_initProducts);
    _finalList = List.of(_initProducts);
  }

}

class Merchandise{
  int id;
  String name;
  String image;
  String price;
  int category;
  int subCategory;
  Merchandise({this.id, this.name, this.image, this.price, this.category, this.subCategory=1 });
}