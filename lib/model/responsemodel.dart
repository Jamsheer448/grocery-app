import 'dart:convert';

class ResponseModel {
  final String msg;

  ResponseModel({required this.msg});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
    };
  }
}
