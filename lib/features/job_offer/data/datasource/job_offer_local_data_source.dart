

import 'dart:io';

import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/data/models/job_offer_model.dart';
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class JobOfferLocalDataSource {

  Future<bool> createJobOffer(JobOffer jobOffer);
  Future<List<JobOffer>> loadJobOffersList();
  Future<JobOffer> loadJobOffer(int id);
  Future<bool> editJobOffer(JobOffer jobOffer);
  Future<bool> deleteJobOffer(int id);

}

class SqliteDataSourceImpl implements JobOfferLocalDataSource {
  
  static Database? _database;
  static final SqliteDataSourceImpl db = SqliteDataSourceImpl();

  SqliteDataSourceImpl() {
    SqliteDataSourceImpl();
  }


  Future<Database?> get database async{

    if(_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{

    //Path donde se almacena la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'jobOffersDB.db');


    //created data base
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version) async{

        await db.execute('''
          CREATE TABLE JobOffers(
            id INTEGER PRIMARY KEY,
            job_title TEXT,
            company_name TEXT,
            postulation_date TEXT,
            plataform_where_applied TEXT,
            password TEXT,
            web_page TEXT,
            apply_on_the_official_web_site INTEGER,
          )
        ''');

        await db.execute('''
          CREATE TABLE TechnicalSkills(
            id INTEGER PRIMARY KEY,
            job_offer_id INTEGER,
            name TEXT 
          )
        ''');
      
        await db.execute('''
          CREATE TABLE NecessaryFrameworks(
            id INTEGER PRIMARY KEY,
            job_offer_id INTEGER,
            name TEXT 
          )
        ''');

      }
    );

  }


  @override
  Future<bool> createJobOffer(JobOffer jobOffer) async{
    try {
      
      final jobOfferDBMap = JobOfferModel.fromEntity(jobOffer).toSqliteDBJson();
      final db = await database;
      final jobOffer = await db!.insert('JobOffers', jobOfferDBMap);

    } catch (error) {
      throw CreateJobOfferFailure();
    }
  }

  @override
  Future<bool> deleteJobOffer(int id) {
    // TODO: implement deleteJobOffer
    throw UnimplementedError();
  }

  @override
  Future<bool> editJobOffer(JobOffer jobOffer) {
    // TODO: implement editJobOffer
    throw UnimplementedError();
  }

  @override
  Future<JobOffer> loadJobOffer(int id) {
    // TODO: implement loadJobOffer
    throw UnimplementedError();
  }

  @override
  Future<List<JobOffer>> loadJobOffersList() {
    // TODO: implement loadJobOffersList
    throw UnimplementedError();
  }

}