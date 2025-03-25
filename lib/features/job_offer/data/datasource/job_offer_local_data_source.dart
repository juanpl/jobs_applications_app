

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
  //Future<bool> editJobOffer(JobOffer jobOffer);
  Future<bool> deleteJobOffer(int id);

}

class SqliteDataSourceImpl implements JobOfferLocalDataSource {
  
  static Database? _database;

  SqliteDataSourceImpl();

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
            apply_on_the_official_web_site INTEGER
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

  Future<List<int>> addTechnicalSkillsList(int jobOfferId, List<String> technicalSkills, Database? db) async {
    List<int> technicalSkillsIdList = [];
    
    for(String technicalSkill in technicalSkills){

      Map<String, Object?> jsonTechnicalSkills = {
        'job_offer_id': jobOfferId,
        'name': technicalSkill
      };

      final technicalSkillId = await db!.insert('TechnicalSkills', jsonTechnicalSkills);
      technicalSkillsIdList.add(technicalSkillId);
    }

    return technicalSkillsIdList;
  }

  Future<List<int>> addNecessaryFrameworks(int jobOfferId, List<String> necessaryFrameworks, Database? db) async {
    List<int> necessaryFrameworksIdList = [];
    
    for(String necessaryFramework in necessaryFrameworks){

      Map<String, Object?> necessaryFrameworkSkills = {
        'job_offer_id': jobOfferId,
        'name': necessaryFramework
      };

      final necessaryFrameworkId = await db!.insert('NecessaryFrameworks', necessaryFrameworkSkills);
      necessaryFrameworksIdList.add(necessaryFrameworkId);
    }

    return necessaryFrameworksIdList;
  }

  List<String> getTechnicalSkillsList(List<Map<String, dynamic>> technicalSkillsListMap) {
    
    List<String> technicalSkillsList = [];

    for (Map<String, dynamic> technicalSkill in technicalSkillsListMap){
      technicalSkillsList.add(technicalSkill['name']);
    }

    return technicalSkillsList;
  }

  List<String> getNecessaryFrameworksList(List<Map<String, dynamic>> necessaryFrameworksListMap){

    List<String> necessaryFrameworksList = [];

    for (Map<String, dynamic> necessaryFramework in necessaryFrameworksListMap){
      necessaryFrameworksList.add(necessaryFramework['name']);
    }

    return necessaryFrameworksList;
  }

  @override
  Future<bool> createJobOffer(JobOffer jobOffer) async{
    try {

      final dbInstance = SqliteDataSourceImpl();
      final db = await dbInstance.database;
      final jobOfferDBMap = JobOfferModel.fromEntity(jobOffer).toSqliteDBJson();

      final jobOfferId = await db!.insert('JobOffers', jobOfferDBMap);
      List<int> technicalSkillsIdList = await addTechnicalSkillsList(jobOfferId,jobOffer.technicalSkills, db);
      List<int> necessaryFrameworksIdList = await addNecessaryFrameworks(jobOfferId, jobOffer.necessaryFrameworks, db);
      
      if(jobOfferId == 0) return false;
      if(technicalSkillsIdList.isEmpty) return false;
      if(necessaryFrameworksIdList.isEmpty) return false;

      return true;

    } catch (error) {
      throw CreateJobOfferFailure();
    }
  }

  @override
  Future<bool> deleteJobOffer(int id) async {
    try {
      
      final dbInstance = SqliteDataSourceImpl();
      final db = await dbInstance.database;
      final res = await db!.delete('JobOffers', where: 'id = ?', whereArgs: [id]);
      final res2 = await db.delete('TechnicalSkills', where: 'job_offer_id = ?', whereArgs: [id]);
      final res3 = await db.delete('NecessaryFrameworks', where: 'job_offer_id = ?', whereArgs: [id]);
      
      if(res == 0) return false;
      if(res2 == 0) return false;
      if(res3 == 0) return false;
      return true;
      
    } catch (error) {
      throw DeleteJobOfferFailure;
    }
  }


  @override
  Future<JobOffer> loadJobOffer(int id) async{
    try {

      final dbInstance = SqliteDataSourceImpl();
      final db = await dbInstance.database;
      final technicalSkillsMap = await db!.query('TechnicalSkills', where: 'job_offer_id = ?', whereArgs: [id]);
      List<String> technicalSkills = getTechnicalSkillsList(technicalSkillsMap);
      final necessaryFrameworksMap = await db.query('NecessaryFrameworks', where: 'job_offer_id = ?', whereArgs: [id]);
      List<String> necessaryFrameworks = getNecessaryFrameworksList(necessaryFrameworksMap);
      final res = await db.query('JobOffers', where: 'id = ?', whereArgs: [id]);
      Map<String, Object?> jobOfferMap = res.first;
      JobOfferModel jobOfferModel = JobOfferModel.fromJsonDB(jobOfferMap);
      
      for (String technicalSkill in technicalSkills){
        jobOfferModel.technicalSkills.add(technicalSkill);
      }

      for (String necessaryFramework in necessaryFrameworks){
        jobOfferModel.necessaryFrameworks.add(necessaryFramework);
      }

      return jobOfferModel;
    
    } catch (error) {
      throw LoadJobOfferFailure();
    }
    
  }

  @override
  Future<List<JobOffer>> loadJobOffersList() async{
    try {

      final dbInstance = SqliteDataSourceImpl();
      final db = await dbInstance.database;
      List<JobOffer> jobOffersList = [];
      List<int> idJobOffersList = [];
      final jobOffersJson = await db!.query('JobOffers');

      for(Map<String, Object?> jobOfferJson in jobOffersJson) {
        int jobOfferId = jobOfferJson['id'] as int;
        idJobOffersList.add(jobOfferId);
      }


      idJobOffersList.forEach((id) async{
        JobOffer jobOffer = await loadJobOffer(id);
        jobOffersList.add(jobOffer);
      });
      
      return jobOffersList;

    } catch (error) {
      throw LoadJobOffersFailure();
    }
    
  }
  
  /*@override
  Future<bool> editJobOffer(JobOffer jobOffer) async{
    try {

      final dbInstance = SqliteDataSourceImpl();
      final db = await dbInstance.database;
      final Map<String, dynamic> jobOfferMap = JobOfferModel.fromEntity(jobOffer).toSqliteDBJson();
      final res = await db!.update('JobOffers', jobOfferMap, where: 'id = ?', whereArgs: [jobOffer.id]);





    } catch (error) {
      throw EditJobOfferFailure();
    }
    
  }*/
  
}