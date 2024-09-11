import 'package:main_project/model/getusermodel.dart';

class getuserviewmodel{
  final GetUser getuser;
  getuserviewmodel({required this.getuser});
 
  String get naame {
    return this.getuser.name;
  }
  
String get phoone {
    return this.getuser.phone;
  }
}