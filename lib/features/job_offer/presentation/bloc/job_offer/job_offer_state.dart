part of 'job_offer_bloc.dart';

@immutable
sealed class JobOfferState {}

final class JobOfferInitial extends JobOfferState {}

final class JobOfferLoading extends JobOfferState {}

final class JobOffer extends JobOfferState {
  final JobOffer jobOffer;

  JobOffer({required this.jobOffer});
}

final class JobOffersList extends JobOfferState {
  final List<JobOffer> jobOffersList;

  JobOffersList({required this.jobOffersList});
}

final class JobOfferFailure extends JobOfferState {
  final Failure failure;

  JobOfferFailure({required this.failure});
}


