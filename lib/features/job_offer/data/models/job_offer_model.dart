
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';

class JobOfferModel extends JobOffer{
  
  JobOfferModel({
    required super.id, 
    required super.jobTitle, 
    required super.companyName, 
    required super.postulationDate,
    required super.plataformWhereApplied,
    required super.technicalSkills, 
    required super.necessaryFrameworks, 
    required super.webPage, 
    required super.applyOnTheOfficialWebSite
  });

  factory JobOfferModel.fromJson(json) {
    return JobOfferModel(
      id: json['id'],
      jobTitle: json['job_title'], 
      companyName: json['company_name'],
      postulationDate: json['company_name'],
      plataformWhereApplied: json['company_name'],
      technicalSkills: List<String>.from(json["technical_skills"].map((x) => x)),
      necessaryFrameworks: List<String>.from(json["necessary_frameworks"].map((x) => x)),
      webPage: json['company_name'],
      applyOnTheOfficialWebSite: json['apply_on_the_official_web_site']
    );
  }

  factory JobOfferModel.fromEntity( JobOffer jobOffer) {
    return JobOfferModel(
      id: jobOffer.id, 
      jobTitle: jobOffer.jobTitle, 
      companyName: jobOffer.companyName, 
      postulationDate: jobOffer.postulationDate, 
      plataformWhereApplied: jobOffer.plataformWhereApplied, 
      technicalSkills: jobOffer.technicalSkills, 
      necessaryFrameworks: jobOffer.necessaryFrameworks, 
      webPage: jobOffer.webPage, 
      applyOnTheOfficialWebSite: jobOffer.applyOnTheOfficialWebSite
    );
  }

  Map<String, dynamic> toSqliteDBJson() {

    return{
      'id' : id, 
      'jobTitle' : jobTitle, 
      'companyName' : companyName, 
      'postulationDate' : postulationDate, 
      'plataformWhereApplied' : plataformWhereApplied, 
      'webPage': webPage, 
      'applyOnTheOfficialWebSite': applyOnTheOfficialWebSite
    };
    
  }

  factory JobOfferModel.fromJsonDB(json) {
    return JobOfferModel(
      id: json['id'],
      jobTitle: json['job_title'], 
      companyName: json['company_name'],
      postulationDate: json['company_name'],
      plataformWhereApplied: json['company_name'],
      technicalSkills: [],
      necessaryFrameworks: [],
      webPage: json['company_name'],
      applyOnTheOfficialWebSite: json['apply_on_the_official_web_site']
    );
  }
  



}