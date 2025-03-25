

import 'package:dartz/dartz.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/data/datasource/job_offer_local_data_source.dart';
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';
import 'package:jobs_applications_app/features/job_offer/domain/repositories/job_offer_repository.dart';

class JobOfferRepositoryImpl implements JobOfferRepository{
  
  
  final JobOfferLocalDataSource jobOfferLocalDataSource;

  JobOfferRepositoryImpl({
    required this.jobOfferLocalDataSource
  });
  
  @override
  Future<Either<Failure, bool>> createJobOffer(JobOffer jobOffer) async {
    try {
      final bool resp = await jobOfferLocalDataSource.createJobOffer(jobOffer);
      return Right(resp);
    } on CreateJobOfferFailure {
      return Left(CreateJobOfferFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteJobOffer(int id) async {
    try {

      final bool resp = await jobOfferLocalDataSource.deleteJobOffer(id); 
      return Right(resp);

    } on DeleteJobOfferFailure {
      return Left(DeleteJobOfferFailure());
    }
  }

  @override
  Future<Either<Failure, JobOffer>> loadJobOffer(int id) async {
    try {

      final JobOffer jobOffer = await jobOfferLocalDataSource.loadJobOffer(id);
      return Right(jobOffer);

    } on LoadJobOfferFailure {
      return Left(LoadJobOfferFailure());
    }
  }

  @override
  Future<Either<Failure, List<JobOffer>>> loadJobOffersList() async {
    try {

      final List<JobOffer> jobOfferList = await jobOfferLocalDataSource.loadJobOffersList();
      return Right(jobOfferList); 

    } on LoadJobOffersFailure {
      return Left(LoadJobOffersFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editJobOffer(JobOffer jobOffer) {
    // TODO: implement editJobOffer
    throw UnimplementedError();
  }

}