import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/cafe_info.dart';


class CafeInfoBloc {
  final cafeInfoController = StreamController<CafeInfo>();
  Stream<CafeInfo> get cafeInfo => cafeInfoController.stream;
  StreamSink<CafeInfo> get cafeInfoSink => cafeInfoController.sink;
  String caffeid = caffeID;
  CafeInfoBloc();

  getCafeInfoFromRemote(){

    // cafeInfoSink.add(CafeInfo(
    //   caffename: "Beyond Coffee",
    //   caffeAddress: "Jubilee Hills",
    //   type: "Cafe"
    // ));

    api.getCafeInfoById().then(
    (response){
      //debugPrint("Cafe detail from remote "+ response.caffename);
      response.caffeId = caffeid;
      cafeInfoSink.add(response);

    }
  );

  }

}
