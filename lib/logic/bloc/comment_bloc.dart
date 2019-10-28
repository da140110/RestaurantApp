import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/model/comment.dart';



class CommentBloc {
  final commentController = StreamController<List<StatusComment>>();
  Stream<List<StatusComment>> get commentss => commentController.stream;
  StreamSink<List<StatusComment>> get commentsSink => commentController.sink;
  List<StatusComment> commentList = [];

  CommentBloc();

  getComments(String foodhashtag) {
    commentList.clear();
    api.getComments(foodhashtag).then((list) {
      list.forEach((comment) {
        commentList.add(comment);
      });

      commentsSink.add(commentList);
    });
    
  }
  
}
