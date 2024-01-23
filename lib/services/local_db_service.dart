import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDBService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "AssetComplyDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE SerialNumbers (id INTEGER PRIMARY KEY, serial_no TEXT, epc TEXT)');
    });
  }

  Future<void> insertSerialNumbers(
      List<Map<String, dynamic>> serialNumbers) async {
    // Print the list of serial numbers to be inserted
    print("Inserting serial numbers: $serialNumbers");

    final db = await database;

    // Loop through each serial number in the list
    for (var item in serialNumbers) {
      // Print the current item being inserted
      print("Inserting item: $item");

      // Insert the item into the database
      try {
        await db.insert('SerialNumbers', item,
            conflictAlgorithm: ConflictAlgorithm.replace);
        // Print a success message if the insert is successful
        print("Successfully inserted item: $item");
      } catch (e) {
        // Print an error message if the insert fails
        print("Error inserting item: $e");
      }
    }
    // Print a message after all items have been processed
    print("Finished inserting serial numbers.");
  }

  Future<String> getSerialNumberByEPC(String epc) async {
    final db = await database;
    var res =
        await db.query('SerialNumbers', where: 'epc = ?', whereArgs: [epc]);
    print(res);
    if (res.isNotEmpty) {
      return res.first['serial_no'] as String? ?? "Not Found";
    }
    return "Not Found";
  }
}
