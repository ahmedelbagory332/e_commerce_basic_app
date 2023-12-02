import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/cart_model.dart';



class CashCart{

  static Database? _db ;


  Future<Database?> get db async {
    if(_db == null){
      _db = await _createDatabase();
      return _db;
    }else{
      return _db;
    }
  }

  static const tableCart = '''
    CREATE TABLE cart_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      price TEXT,
      quantity TEXT,
      category TEXT,
      image TEXT
    )
  ''';


  _createDatabase() async{
    //define the path to the database
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(tableCart);
        });
  }


  Future<int> insertProduct(CartModel cartModel) async {
    Database? myDb = await db;
    return myDb!.insert('cart_data', cartModel.toJson());
  }

  Future<int> emptyCart() async {
    Database? myDb = await db;
    return myDb!.delete('cart_data');
  }

  Future<List<CartModel>?> getProducts() async {
    Database? myDb = await db;
    List<Map<String, dynamic>> results = await myDb!.query('cart_data');
    if (results.isNotEmpty) {
      return List.generate(results.length, (i) {
        return CartModel.fromJson(results[i]);
      });
    }
    if (results.isEmpty) {
      return [];
    }
    return null;
  }

  Future<int> removeProduct(int id) async{
    Database? myDb = await db;
    return myDb!.delete('cart_data', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> productsUpdate(CartModel cartModel) async{
    Database? myDb = await db;
    return await myDb!.update('cart_data', cartModel.toJson(),where: 'id = ?', whereArgs: [cartModel.id]);
  }
}