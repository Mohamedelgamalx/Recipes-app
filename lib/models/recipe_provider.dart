// import 'package:contacts/contact.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// const String tableContact = 'contact';
// const String columnId = 'id';
// const String columnName = 'name';
// const String columnNumber = 'number';
// const String columnUrl = 'url';
//
// class ContactProvider {
//   late Database db;
//
//   static final ContactProvider instance = ContactProvider._internal();
//   factory ContactProvider() {
//     return instance;
//   }
//   ContactProvider._internal();
//
//   Future open() async {
//     db = await openDatabase(join(await getDatabasesPath(), 'contacts.db'), version: 1,
//         onCreate: (Database db, int version) async {
//           await db.execute('''
// create table $tableContact (
//   $columnId integer primary key autoincrement,
//   $columnName text not null,
//   $columnNumber text not null,
//   $columnUrl text not null
//   )
// ''');
//         });
//   }
//
//   Future<Contact> insertContact(Contact contact) async {
//     contact.id = await db.insert(tableContact, contact.toMap());
//     return contact;
//   }
//
//   Future<int> deleteContact(int id) async {
//     return await db.delete(tableContact, where: '$columnId = ?', whereArgs: [id] );
//   }
//
//   Future<int> update(Contact contact) async {
//     return await db.update(tableContact, contact.toMap(),
//         where: '$columnId = ?', whereArgs: [contact.id]);
//   }
//
//   Future<List<Contact>> getAllContacts() async {
//     List<Map<String, dynamic>> contactMaps = await db.query(tableContact);
//     if (tableContact.length == 0 ) {
//       return [];
//     } else {
//       List<Contact> contacts = [];
//       contactMaps.forEach((element) {
//         contacts.add(Contact.fromMap(element));
//       });
//       return contacts;
//     }
//   }
//
//   Future close() async => db.close();
//
//
// }