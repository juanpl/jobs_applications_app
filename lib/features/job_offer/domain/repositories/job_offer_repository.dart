

import 'package:dartz/dartz.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';

abstract class JobOfferRepository {

  Future<Either<Failure, bool>> createJobOffer(JobOffer jobOffer);
  Future<Either<Failure, List<JobOffer>>> loadJobOffersList();
  Future<Either<Failure, JobOffer>> loadJobOffer(int id);
  Future<Either<Failure, bool>> editJobOffer(JobOffer jobOffer);
  Future<Either<Failure, bool>> deleteJobOffer(int id);
    
}