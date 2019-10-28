import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/top_food_hashtag_bloc.dart';
import 'package:finesse/model/comment.dart';
import 'package:finesse/model/status.dart';
import 'package:finesse/util/uidata.dart';
import 'package:finesse/widgets/ExpandableListView.dart';
import 'package:flutter/material.dart';

class CommentContent extends StatefulWidget {
  CommentContent({
    Key key,
    this.comments,
  }) : super(key: key);

  final List<String> comments;

  @override
  _CommentContentState createState() => new _CommentContentState();
}

class _CommentContentState extends State<CommentContent> {

  TopFoodHashTagBloc topFoodHashTagBloc = TopFoodHashTagBloc();

  String currentTagLine = UIData.label_what_are_you_thinking;

  TextStyle commentTextStyle = TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontStyle: FontStyle.italic,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              );

  TextEditingController additionalcommentController = TextEditingController();

  @override
  void initState() {

    topFoodHashTagBloc.gethashTags();
    super.initState();
  }

  _getContent() {
    if (widget.comments.length == 0) {
      return new Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,      
      children: <Widget>[
       Expanded(child: commentRow(),flex: 1,),
       Expanded(child: bodyData(),flex: 8,),
      ],
    );
  }

  Widget bodyData(){
    // ---------------------------------- hash tags ------------------------------
    return Container(
      decoration:  new BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
      child: hasTagRow()
    );
  }

  // -- get hashtags from server and feed the extendable list ------------------

  Widget hashTagListView(List<Status> statusList){
          return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return new ExpandableListView(status: statusList[index],wallTagController:additionalcommentController);
      },
      itemCount: statusList.length,
          );
  }


  Widget hasTagRow() {
    
    return StreamBuilder<List<Status>>(
        stream: topFoodHashTagBloc.hashTags,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? hashTagListView(snapshot.data)//hashTagGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }
  // ------------------------------------------

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget commentRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 24.0),
            child: TextField(
              controller: additionalcommentController,
              style: commentTextStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: currentTagLine,
                hintStyle: commentTextStyle,
                filled: true,
                fillColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 2.0, style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 2.0, style: BorderStyle.solid),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
              ),
              cursorColor: Colors.black,
            ),
          ),
          flex: 6,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Icon(
                const IconData(0xe902, fontFamily: 'icomoon'),
                color: Colors.white,
                size:20,
              ), //Image.asset(name),
              shape: CircleBorder(),
              color: Colors.black,
              splashColor: Colors.white,
              disabledColor: Colors.black,
              onPressed: () {
                _actionAddCommentButton();
              },
            ),
          ),
          flex: 2,
        )
      ],
    );
  }

    void _actionAddCommentButton(){

    StatusComment commentRequest = StatusComment();

    commentRequest.caffeId = caffeID;
    commentRequest.timeStamp = currentUser.timestamp;
    commentRequest.foodHashtag = UPVOTED_HASHTAG;
    commentRequest.clientName = currentUser.clientName;
    commentRequest.foodComment = additionalcommentController.text;
    commentRequest.like = 0;

    api.makeCommentRequest(commentRequest).then((resp) {

      if(resp.sendCommentReqResponse.compareTo("success")==0){

        topFoodHashTagBloc.gethashTags();

      }

    });
  }

}