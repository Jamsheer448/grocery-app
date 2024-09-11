import 'package:main_project/model/responsemodel.dart';

class responseviemodel{
  final ResponseModel response;
  responseviemodel({required this.response});
  String get msgx{
    return this.response.msg;
  }}