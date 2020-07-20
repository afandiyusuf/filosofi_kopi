class CategoryProductModel {
  List<Category> _list = [
    Category(id:0,name:"All",selected: true),
    Category(id:1,name:"Coffe"),
    Category(id:2,name:"Snack"),
    Category(id:3,name:"Food"),
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

  List<Category> getCategories(){
    return _list;
  }
  Category getByIndex(int index){
    return _list[index];
  }
  Category getById(int id){
    return _list.firstWhere((category) => category.id == id);
  }
  select(int index){
    _selected = index;
    _list.forEach((element) {element.selected = false;});
    _list[index].selected = true;
  }
}
class Category{
  String name;
  int id;
  bool selected = false;
  Category({this.id,this.name,this.selected});
}