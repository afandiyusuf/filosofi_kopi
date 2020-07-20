import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/view/component/product_card.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  CategoryProductModel categoryModel = CategoryProductModel();
  ProductModel products = ProductModel();
  TextStyle selectedTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold
  );
  TextStyle idleTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold
  );
  BoxDecoration selectedBoxDecoration = BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 2, color: Colors.black)
  );
  BoxDecoration idleBoxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 2, color: Colors.black)
  );


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
                  itemCount: categoryModel.count(),
                  itemBuilder: (BuildContext context, int index) {
                    Category category = categoryModel.getByIndex(index);
                    return InkWell(
                      onTap: () {
                        _selectCategory(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Center(child: Text(category.name,
                            style: category.selected == true
                                ? selectedTextStyle
                                : idleTextStyle,)),
                        ),
                        decoration: category.selected == true
                            ? selectedBoxDecoration
                            : idleBoxDecoration,
                      ),
                    );
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
                        image: _product.image
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectCategory(int index) {
    setState(() {
      categoryModel.select(index);
      if(index != 0)
        {
          products.setByCateogory(index);
        }else{
        products.reset();
      }
    });
  }
}
