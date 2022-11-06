import 'package:database/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDbHelper {
  static Future<Database> intDb() async {
    var dbPath = await getDatabasesPath();

    String path = join(dbPath, 'contact.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static _onCreate(Database db, int version) async {
    final sql =
        ''' CREATE TABLE tbl_contact(id INTEGER PRIMARY KEY , name Text, phone Text)''';

    await db.execute(sql);
  }

  static Future<int> CreateContact(Contact contact) async {
    Database db = await MyDbHelper.intDb();
    return await db.insert('tbl_contact', contact.toMap());
  }

  static Future<List<Contact>> readContact() async {
    Database db = await MyDbHelper.intDb();

    var contact = await db.query('tbl_contact');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }

  static Future<int> updateContact(Contact contact) async {
    Database db = await MyDbHelper.intDb();
    return await db.update('tbl_contact', contact.toMap(),
        where: 'id=?', whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id) async {
    Database db = await MyDbHelper.intDb();
    return await db.delete('tbl_contact', where: 'id=?', whereArgs: [id]);
  }
}
