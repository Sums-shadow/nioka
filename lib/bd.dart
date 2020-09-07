import 'package:nioka/model.dart';
import 'package:sqflite/sqflite.dart'; // package sqflite
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //utile pour concatner les path
import 'model.dart'; //importer la class memo
import 'dart:io';
import 'dart:async';

class NokiaBd{
    var table="nokiaTable";
    var db_name="nokiadb.db";
Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); // renvoi un dossier qui stock les fichiers de maniere permanente
    final path = join(directory.path,db_name); //creer le chemin ers la base de donnée

      return await openDatabase( //ouvre la base de donnée ou l'ouvre si elle n'existe pas
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE $table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nom TEXT,
          score TEXT)"""
      );
    });
  }
 

  Future<int> addScore(NokiaModel item) async{ //renvoi le nombre d'item inserer 
    final db = await init(); //ouverture de la base de donée
    return db.insert(table, item.toMap(), //la fonction toMap() du model
    conflictAlgorithm: ConflictAlgorithm.ignore, // ignore certaines duplications d'entrée 
    );
 }

 Future<List<NokiaModel>> fetchScore() async{ //renvoi le model comme une liste
    
    final db = await init();
    var maps = await db.rawQuery("SELECT * from $table"); // interroge la bd sur toutes les row dans la table comme un tableau de maps

    return List.generate(maps.length, (i) { //cree une liste du model
      return NokiaModel(              
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        score: maps[i]['score'],
      );
  });
  }

  Future<int> deleteScore(int id) async{ //renvoi le numero de l'element supprimer
    final db = await init();
  
    int result = await db.delete(
      table, //nom de la table
      where: "id = ?",
      whereArgs: [id] // utilise whereArgs pour echapper au sql injection
    );

    return result;
  }

  
Future<int> updateScore(int id, NokiaModel item) async{ // renvoi le numero de 'lelement mise a jours
  
    final db = await init();
  
    int result = await db.update(
      table, 
      item.toMap(),
      where: "id = ?",
      whereArgs: [id]
      );
      return result;
 }
    
}