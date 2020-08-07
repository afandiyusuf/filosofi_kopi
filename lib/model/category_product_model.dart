class CategoryProductModel {
  int _selected = 0;
  List<CategoryProduct> categoryProducts;
  CategoryProductModel({this.categoryProducts});

  factory CategoryProductModel.fromJson(data){

    List<CategoryProduct> listCategoryProduct = List<CategoryProduct>.from(
        data.map((item) => CategoryProduct.fromJson(item))
    );
    //add all category
    listCategoryProduct.insert(0,CategoryProduct(
      id:0,
      name: "All",
      selected: true,
    ));

    return CategoryProductModel(
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

  List<CategoryProduct> getCategories(){
    return categoryProducts;
  }

  CategoryProduct getByIndex(int index){
    return categoryProducts[index];
  }

  CategoryProduct getById(int id){
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

class CategoryProduct{
  final String name;
  final int id;
  bool selected;

  CategoryProduct({this.id,this.name,this.selected = false});

  factory CategoryProduct.fromJson(Map<String, dynamic> map){
    return CategoryProduct(
      name: map['category_name'],
      id: map['category_id'],
        selected: false
    );
  }
}
