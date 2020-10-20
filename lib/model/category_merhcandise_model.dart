class CategoryMerchandiseModel {
  List<CategoryMerchandise> _list = [
  CategoryMerchandise(id: 0, selected: true,name: "All", subCategoryMerchandise:[]),
    CategoryMerchandise(id: 1,name: "Special", subCategoryMerchandise: [
      SubCategoryMerchandise(
          id: 0,
          name: "All",
          selected: true
      ),SubCategoryMerchandise(
        id: 1,
        name: "New Arrival",
      ),
      SubCategoryMerchandise(
        id: 2,
        name: "Sale",
      ),
    ]),
    CategoryMerchandise(id: 2, name: "Apparel", subCategoryMerchandise: [
      SubCategoryMerchandise(
        id: 0,
        name: "All",
        selected: true
      ),
      SubCategoryMerchandise(
        id: 1,
        name: "T-shirt",
      ),
      SubCategoryMerchandise(
        id: 2,
        name: "Hoodie",
      ),
    ]),
    CategoryMerchandise(id: 3, name: "Accessories", subCategoryMerchandise: [
      SubCategoryMerchandise(
          id: 0,
          name: "All",
          selected: true
      ),SubCategoryMerchandise(
        id: 1,
        name: "New Arrival",
      ),
      SubCategoryMerchandise(
        id: 2,
        name: "Sale",
      ),
    ]),
  ];
  String _selected = '';

  String getSelected() {
    return _selected;
  }

  int count() {
    return _list.length;
  }

  int countSubCategory(){
    return _list[getIndexCategory(_selected)].subCategoryMerchandise.length;
  }

  void setSelected(String selected) {
    _selected = selected;
  }

  void setSelectedSub(int selected){
  }

  List<CategoryMerchandise> getCategories() {
    return _list;
  }

  CategoryMerchandise getByIndex(int index) {
    return _list[index];
  }

  SubCategoryMerchandise getSubByIndex(int index){
    return _list[getIndexCategory(_selected)].subCategoryMerchandise[index];
  }

  int getIndexCategory(String categoryName){
    for(int i=0;i<_list.length;i++){
      if(_list[i].name == categoryName){
        return i;
      }
    }

    return 0;
  }

  CategoryMerchandise getById(int id) {
    return _list.firstWhere((category) => category.id == id);
  }

  select(String category) {
    _selected = category;
    _list.forEach((element) {
      element.selected = false;
      if(element.name == category){
        element.selected = true;
      }
    });
  }

  selectSub(String subCategory){
    _list[getIndexCategory(_selected)].subCategoryMerchandise.forEach((element) {
      element.selected = false;
    });

    _list[getIndexCategory(_selected)].subCategoryMerchandise.forEach((element) {
      if(element.name == subCategory){
        element.selected = true;
      }
    });
  }
}

class CategoryMerchandise {
  String name;
  int id;
  bool selected = false;
  List<SubCategoryMerchandise> subCategoryMerchandise;

  CategoryMerchandise(
      {this.id, this.name, this.selected, this.subCategoryMerchandise});
}

class SubCategoryMerchandise {
  String name;
  int id;
  bool selected;

  SubCategoryMerchandise({this.id, this.name, this.selected = false});
}
