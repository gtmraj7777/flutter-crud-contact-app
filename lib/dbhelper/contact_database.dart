import 'package:flutter_crud/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactDatabase {
  static final ContactDatabase instance = ContactDatabase._init();

  static Database? _database;
  ContactDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
     CREATE TABLE $tableContacts(
     ${ContactFields.id} $idType,
     ${ContactFields.contactName} $textType,
     ${ContactFields.contactNumber} $textType,
     ${ContactFields.contactAddress} $textType
     )
    ''');
  }

  Future<Contact> create(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert(tableContacts, contact.toJson());
    return contact.copy(id: id);
  }

  Future<Contact> readFriend(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableContacts,
      columns: ContactFields.values,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contact.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    // final orderBy = '${FriendF}'
    final result = await db.query(tableContacts);

    return result.map((json) => Contact.fromJson(json)).toList();
  }

  Future<int> update(Contact contact) async {
    print("++++++   Inside update  ++++++");
    final db = await instance.database;
    return db.update(
      tableContacts,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableContacts,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
