
import 'package:dartz/dartz.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/domain/repositories/job_offer_repository.dart';

class DeleteJobOfferUseCase {
  
  final JobOfferRepository repository;

  DeleteJobOfferUseCase({required this.repository});

  Future<Either<Failure, bool>> call(int id){
    return repository.deleteJobOffer(id);
  }

}