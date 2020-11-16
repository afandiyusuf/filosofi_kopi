class CategoryApparelModel {
  int _selected = 0;
  List<CategoryApparel> categoryProducts;
  CategoryApparelModel({this.categoryProducts});

  factory CategoryApparelModel.fromJson(data){

    List<CategoryApparel> listCategoryProduct = List<CategoryApparel>.from(
        data.map((item) => CategoryApparel.fromJson(item))
    );
    //add all category
    listCategoryProduct.insert(0,CategoryApparel(
      id:0,
      name: "All",
      selected: true,
    ));

    return CategoryApparelModel(
        categoryProducts: listCategoryProduct
    );
  }

  int getSelected() {
    return _selected;
  }

  int count(){
    return categoryProducts.length;
  }

  void setSelected(String categoryName){
    int selected = 0;
    for(int i=0;i<categoryProducts.length;i++){
      if(categoryProducts[i].name == categoryName){
        selected = i;
      }
    }
    _selected = selected;
  }

  List<CategoryApparel> getCategories(){
    return categoryProducts;
  }

  CategoryApparel getByIndex(int index){
    return categoryProducts[index];
  }

  CategoryApparel getById(int id){
    return categoryProducts.firstWhere((category) => category.id == id);
  }

  int getIndexByName(String categoryName){
    for(int i=0;i<categoryProducts.length;i++){
      if(categoryProducts[i].name == categoryName){
        return categoryProducts[i].id;
      }
    }
    return 0;
  }

  select(String categoryName){
    _selected = getIndexByName(categoryName);
    categoryProducts.forEach((element) {element.selected = false;});
    categoryProducts[_selected].selected = true;
  }
}

class CategoryApparel{
  final String name;
  final int id;
  bool selected;

  CategoryApparel({this.id,this.name,this.selected = false});

  factory CategoryApparel.fromJson(Map<String, dynamic> map){
    return CategoryApparel(
        name: map['category_name'],
        id: map['category_id'],
        selected: false
    );
  }
}
