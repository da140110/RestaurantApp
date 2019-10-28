import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/screens/FoodMenuScreen.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final FoodCategory item;

  final double bottomBarScale = .087239;

  const CategoryList({@required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        currentCategory.title = item.title;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoodMenuScreen(item.title),
              ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12.0),
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 300 / 210,

                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: size.height * bottomBarScale,
                  color: Color.fromRGBO(0, 0, 0, .85),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12.0,
                        ),
                        child: Text(
                          item.title.toUpperCase(),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: UIData.font_nunito_sans,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12.0,
                        ),
                        child: Text(
                          item.subtitle,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontFamily: UIData.font_nunito_sans,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
