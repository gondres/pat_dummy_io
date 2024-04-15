import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;

  static const tableName = 'likes_table';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/pat.db';

    return await openDatabase(path, onCreate: _onCreate, version: 2);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${tableName} (id TEXT PRIMARY KEY,image TEXT,likes INTEGER, publishDate TEXT,tags TEXT,text TEXT,owner_id TEXT, owner_title TEXT, owner_firstname TEXT, owner_lastname TEXT, owner_picture TEXT,is_liked INTEGER)');
    ('TABLE CREATED');
  }

  Future<void> insertLikes(LikesModel model) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert(
        'INSERT INTO ${tableName} (id,image,likes, publishDate,tags,text,owner_id, owner_title, owner_firstname, owner_lastname, owner_picture,is_liked) VALUES (?, ?, ?, ?, ?, ?, ?,?,?,?,?,?)',
        [
          model.id,
          model.image,
          model.likes,
          model.publishDate,
          model.tags!.join(','),
          model.text,
          model.owner_id,
          model.owner_title,
          model.owner_firstname,
          model.owner_lastname,
          model.owner_picture,
          1
        ]);
  }

  Future<void> deleteLikes(String id) async {
    final db = await _databaseService.database;
    await db.rawDelete('DELETE FROM ${tableName} WHERE id = ?', [id]);
  }

  Future<List<LikesModel>> getLikesList() async {
    final db = await _databaseService.database;
    var data = await db.rawQuery('SELECT * FROM ${tableName}');
    List<LikesModel> likes = List.generate(data.length, (index) => LikesModel.fromJson(data[index]));

    return likes;
  }
}
