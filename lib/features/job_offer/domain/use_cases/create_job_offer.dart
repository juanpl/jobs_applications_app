
import 'package:dartz/dartz.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';
import 'package:jobs_applications_app/features/job_offer/domain/repositories/job_offer_repository.dart';

class CreateJobOfferUseCase {

  final JobOfferRepository repository;

  CreateJobOfferUseCase({required this.repository});

  Future<Either<Failure, bool>> call(JobOffer jobOffer){
    return repository.createJobOffer(jobOffer);
  }

}