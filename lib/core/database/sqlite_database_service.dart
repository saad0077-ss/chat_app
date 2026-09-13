import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class SqliteDatabaseService {
  static final SqliteDatabaseService instance =
      SqliteDatabaseService._internal();
  static Database? _database;

  SqliteDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nebula_chat.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE local_messages (
      messageId TEXT PRIMARY KEY,
      chatRoomId TEXT NOT NULL,
      senderId TEXT NOT NULL,
      receiverId TEXT NOT NULL,
      content TEXT NOT NULL,
      timestamp INTEGER NOT NULL,
      type TEXT NOT NULL,
      syncStatus TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE local_conversations (
        chatRoomId TEXT PRIMARY KEY,
        otherUserId TEXT NOT NULL,
        otherUserName TEXT,
        otherUserEmail TEXT NOT NULL,
        lastMessage TEXT NOT NULL,
        lastMessageTimestamp INTEGER NOT NULL,
        unreadCount INTEGER DEFAULT 0
      )
    ''');

    await db.execute(
      'CREATE INDEX idx_messages_room ON local_messages(chatRoomId)',
    );
    await db.execute(
      'CREATE INDEX idx_messages_timestamp ON local_messages(timestamp DESC)',
    );
  }
}
