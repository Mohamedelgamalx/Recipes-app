// import 'package:contacts/contact_provider.dart';
//
// class Contact {
//   int? id;
//   late String name;
//   late String number;
//   late String url;
//
//   Contact({
//     this.id,
//     required this.name,
//     required this.number,
//     required this.url
//   });
//
//   Contact.fromMap(Map<String, dynamic> map) {
//     if (map[columnId] != null) {
//       id = map[columnId];
//     }
//     name = map[columnName];
//     number = map[columnNumber];
//     url = map[columnUrl];
//   }
//
//   Map<String,dynamic> toMap() {
//     Map<String,dynamic> map = {};
//     if (id != null) {
//       map[columnId] = id;
//     }
//     map[columnName] = name;
//     map[columnNumber] = number;
//     map[columnUrl] = url;
//     return map;
//   }
// }