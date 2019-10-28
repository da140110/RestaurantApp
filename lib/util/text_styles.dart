import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle TEXT_FIELD_LABLE_STYLE = TextStyle(
    fontFamily: UIData.font_nunito_sans,  fontSize: 19.0, fontStyle: FontStyle.italic, color: Color.fromRGBO(157, 157, 157, 100.0)
    );
  
  static const TextStyle TEXT_FIELD_INPUT_STYLE = TextStyle(
    fontFamily: UIData.font_nunito_sans, color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w300);

  static const TextStyle ITEMS_TEXT_STYLE = TextStyle(
    fontSize: 17.0,
    fontFamily: UIData.font_nunito_sans,
    color: Colors.black,
  );

    static const TextStyle FOOD_ITEMS_TEXT_STYLE = TextStyle(
    fontFamily: UIData.font_nunito_sans,  fontSize: 13.0, fontStyle: FontStyle.italic, color: Colors.black
    );

    static const TextStyle FOOD_ITEMS_TITLE_TEXT_STYLE = TextStyle(
    fontSize: 17.0,
    fontFamily: UIData.font_nunito_sans,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );

    static const TextStyle COMMENT_TEXT_STYLE = TextStyle(
    fontSize: 17.0,
     fontFamily: UIData.font_nunito_sans,
     fontWeight: FontWeight.w600,
     fontStyle: FontStyle.normal ,
    color: Colors.black,
  );

      static const TextStyle DIALOG_COMMENT_TEXT_STYLE = TextStyle(
    fontSize: 14.0,
     fontFamily: UIData.font_nunito_sans,
     fontWeight: FontWeight.w600,
     fontStyle: FontStyle.normal ,
    color: Colors.white,
  );

}
