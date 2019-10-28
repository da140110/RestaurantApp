import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/model/status.dart';


class TopFoodHashTagBloc {
  final hasTagController = StreamController<List<Status>>();
  Stream<List<Status>> get hashTags => hasTagController.stream;
  StreamSink<List<Status>> get hashTagsSink => hasTagController.sink;
  List<Status> hashTagList = [];

  TopFoodHashTagBloc();

  gethashTags() {
    hashTagList.clear();
    api.gethashTags().then((list) {
      list.forEach((hashTag) {
        hashTagList.add(hashTag);
      });

      hashTagsSink.add(hashTagList);
    });
    
  }
  
}
