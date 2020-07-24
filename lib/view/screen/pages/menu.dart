import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/category_button.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:filkop_mobile_apps/view/screen/detail_page_screen.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  CategoryProductModel categoryProductModel = CategoryProductModel();
  ProductModel products = ProductModel();
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery
        .of(context)
        .size;

    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth*1.4;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 12,left: 12),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50,bottom: 0),
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProductModel.count(),
                  itemBuilder: (BuildContext context, int index) {
                    CategoryProduct category = categoryProductModel.getByIndex(index);
                    return CategoryButton(name:category.name, selected:category.selected, onTap: (){
                      _selectCategory(index);
                    },);
                  }
              ),
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
                    children: List.generate(products.getTotal(), (index) {
                      Product _product = products.getByIndex(index);
                      return ProductCard(id:_product.id,
                        name:_product.name,
                        price:_product.price,
                        category: _product.category,
                        image: _product.image,
                        onTap: (){
                          _goToDetail(_product, context);
                        },
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
  _goToDetail(Product product, BuildContext context){
    Navigator.pushNamed(context, DetailPageScreen.tag, arguments: {
      DetailPageScreen.argTitle: product.name,
      DetailPageScreen.argImage: product.image,
      DetailPageScreen.argPrice: product.price.toString()
    });
  }
  _selectCategory(int index) {
    setState(() {
      categoryProductModel.select(index);
      if(index != 0)
        {
          products.setByCateogory(index);
        }else{
        products.reset();
      }
    });
  }
}
