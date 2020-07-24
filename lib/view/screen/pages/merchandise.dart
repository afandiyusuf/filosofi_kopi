import 'package:filkop_mobile_apps/model/category_merhcandise_model.dart';
import 'package:filkop_mobile_apps/model/mechandise_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/category_button.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:flutter/material.dart';

class MerchandisePage extends StatefulWidget {
  @override
  _MerchandisePageState createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  CategoryMerchandiseModel categoryMerchandiseModel = CategoryMerchandiseModel();
  MerchandiseModel merchandiseModel = MerchandiseModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth*1.4;
    Size screen = MediaQuery.of(context).size;

    return Container(
        child: Padding(
            padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 0),
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryMerchandiseModel.count(),
                    itemBuilder: (BuildContext context, int index) {
                      CategoryMerchandise category = categoryMerchandiseModel.getByIndex(index);
                      return CategoryButton(
                        name: category.name,
                        selected: category.selected,
                        width: screen.width * 0.28,
                        onTap: () {
                          _selectCategory(index);
                        },
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 0),
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryMerchandiseModel.countSubCategory(),
                    itemBuilder: (BuildContext context, int index) {
                      SubCategoryMerchandise category = categoryMerchandiseModel.getSubByIndex(index);
                      return CategoryButton(
                        name: category.name,
                        selected: category.selected,
                        width: screen.width * 0.28,
                        onTap: () {
                          _selectSubCategory(index);
                        },
                      );
                    }),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top:30),
                  child: GridView.count(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(merchandiseModel.getTotal(), (index) {
                        Merchandise _merchandise = merchandiseModel.getByIndex(index);
                        return ProductCard(id:_merchandise.id,
                            name:_merchandise.name,
                            price:_merchandise.price,
                            category: _merchandise.category,
                            image: _merchandise.image,
                          onTap: (){
                            _goToDetail(_merchandise,context);
                          },
                        );
                      })),
                ),
              )
            ])));
  }

  _selectCategory(int index) {
    setState(() {
      categoryMerchandiseModel.select(index);
      merchandiseModel.setByCateogory(index);
    });
  }

  _selectSubCategory(int index){
    setState(() {
      categoryMerchandiseModel.selectSub(index);
      merchandiseModel.setBySubCategory(index);
    });
  }

  _goToDetail(Merchandise product, BuildContext context){
    Navigator.pushNamed(context, DetailPageScreen.tag, arguments: {
      DetailPageScreen.argTitle: product.name,
      DetailPageScreen.argImage: product.image,
      DetailPageScreen.argPrice: product.price.toString()
    });
  }
}
