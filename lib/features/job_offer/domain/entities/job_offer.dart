
class JobOffer {
  
  final int id;
  final String jobTitle;
  final String companyName;
  final String postulationDate;
  final String plataformWhereApplied;
  final List<String> technicalSkills;
  final List<String> necessaryFrameworks;
  final String webPage;
  final bool applyOnTheOfficialWebSite;


  JobOffer({
    required this.id, 
    required this.jobTitle, 
    required this.companyName, 
    required this.postulationDate, 
    required this.plataformWhereApplied,
    required this.technicalSkills, 
    required this.necessaryFrameworks,
    required this.webPage, 
    required this.applyOnTheOfficialWebSite
  });
  


}