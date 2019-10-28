import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CommonScaffold extends StatelessWidget {
  final Widget bodyData;

  CommonScaffold(
      {
      this.bodyData,
      });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      preferredSize:  Size.fromHeight(90.0),
          child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              UIData.image_frinks,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 70.0,
            ),
            Text(
              UIData.label_welcome,
              style: TextStyle(fontFamily: UIData.font_nunito_sans, fontSize: 14,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
            )
            // Your widgets here
          ],
        ),
        actions: <Widget>[

          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => _onAlertWithCustomContentPressed(context),
                          child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    // size: 30.0,
                  ),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.only(bottom: 20.0, left: 10.0),
                    alignment: Alignment.center,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 8.0,fontFamily: UIData.font_nunito_sans,fontWeight: FontWeight.w700),
                    ),
                    decoration:
                        BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  // size: 30.0,
                ),
                Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.only(bottom: 20.0, left: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: TextStyle(fontSize: 8.0,fontFamily: UIData.font_nunito_sans,fontWeight: FontWeight.w700),
                  ),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                )
              ],
            ),
          ),
          Container(
             margin: EdgeInsets.only(right: 24),
            alignment: Alignment.centerRight,
            child: RaisedButton(
              //  padding: EdgeInsets.fromLTRB(48.0,15.0,48.0,15.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              highlightColor: Colors.white,
              highlightElevation: 4.0,
              child: Text(
                UIData.label_exit,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: UIData.font_nunito_sans,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0),
              ),
              color: Color.fromRGBO(248, 89, 18, 1.0),
              elevation: 4.0,
              onPressed: () {
              //  Navigator.of(context).pushNamed(PAYMENT_SCREEN);
              },
            ),
          ),
        ],
      ),
    ),
      body: bodyData,
    );
  }


    // Alert custom content
   _onAlertWithCustomContentPressed(BuildContext context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

}
