import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelpert {
  Database? db;

  Future<void> init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('pos.db');
      } else {
        db = await openDatabase('pos.db', version: 1, onCreate: (db, version) {
          print('database created successfuly');
        });
      }
    } catch (e) {
      print('Error in creating database: $e');
    }
  }

  Future<bool> createTables() async {
    try {
      var batch = db!.batch();
      batch.execute("""
           Create table if not exists categories(
            id integer primary key,
            name text not null,
            description text not null
           )
           """);

      batch.execute("""
           Create table if not exists products(
            id integer primary key,
            name text not null,
            description text not null,
            price double not null,
            stock integer not null,
            isAvaliable boolean not null,
            image blob,
            categortId integer not null
           )
           """);
      batch.execute("""
           Create table if not exists categories(
            id integer primary key,
            name text not null,
            email text,
            phone text
           )
           """);

      var result = await batch.commit();
      print('result = $result');
      return true;
    } catch (e) {
      print('Error ic creating table: $e');
      return false;
    }
  }
}
