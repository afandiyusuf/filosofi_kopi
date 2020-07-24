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
  int _selected = 0;
  int _subSelected = 0;

  int getSelected() {
    return _selected;
  }

  int count() {
    return _list.length;
  }

  int countSubCategory(){
    return _list[_selected].subCategoryMerchandise.length;
  }

  void setSelected(int selected) {
    _selected = selected;
  }

  void setSelectedSub(int selected){
    _subSelected = selected;
  }

  List<CategoryMerchandise> getCategories() {
    return _list;
  }

  CategoryMerchandise getByIndex(int index) {
    return _list[index];
  }

  SubCategoryMerchandise getSubByIndex(int index){
    return _list[_selected].subCategoryMerchandise[index];
  }

  CategoryMerchandise getById(int id) {
    return _list.firstWhere((category) => category.id == id);
  }

  select(int index) {
    _selected = index;
    _list.forEach((element) {
      element.selected = false;
    });
    _list[index].selected = true;
  }

  selectSub(int index){
    _subSelected = index;
    _list[_selected].subCategoryMerchandise.forEach((element) {
      element.selected = false;
    });
    _list[_selected].subCategoryMerchandise[index].selected = true;
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
