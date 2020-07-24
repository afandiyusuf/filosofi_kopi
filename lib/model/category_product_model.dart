class CategoryProductModel {
  List<CategoryProduct> _list = [
    CategoryProduct(id:0,name:"All",selected: true),
    CategoryProduct(id:1,name:"Coffe"),
    CategoryProduct(id:2,name:"Snack"),
    CategoryProduct(id:3,name:"Food"),
  ];
  int _selected = 0;
  int getSelected() {
    return _selected;
  }
  int count(){
    return _list.length;
  }

  void setSelected(int selected){
    _selected = selected;
  }

  List<CategoryProduct> getCategories(){
    return _list;
  }
  CategoryProduct getByIndex(int index){
    return _list[index];
  }
  CategoryProduct getById(int id){
    return _list.firstWhere((category) => category.id == id);
  }
  select(int index){
    _selected = index;
    _list.forEach((element) {element.selected = false;});
    _list[index].selected = true;
  }
}
class CategoryProduct{
  String name;
  int id;
  bool selected = false;
  CategoryProduct({this.id,this.name,this.selected});
}