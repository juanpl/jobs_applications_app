part of 'job_offer_bloc.dart';

@immutable
sealed class JobOfferState {}

final class JobOfferInitial extends JobOfferState {}

final class JobOfferLoading extends JobOfferState {}

final class LoadedJobOffer extends JobOfferState {
  final JobOffer jobOffer;

  LoadedJobOffer({required this.jobOffer});
}

final class LoadedJobOffersList extends JobOfferState {
  final List<JobOffer> jobOffersList;

  LoadedJobOffersList({required this.jobOffersList});
}

final class DeletedJobOffer extends JobOfferState {
  final bool jobOfferDeleted;

  DeletedJobOffer({required this.jobOfferDeleted});
}

final class JobOfferFailure extends JobOfferState {
  final Failure failure;

  JobOfferFailure({required this.failure});
}


