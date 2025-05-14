part of 'job_offer_bloc.dart';

@immutable
sealed class JobOfferEvent {}

class OnGetJobOffer extends JobOfferEvent {
  final int idOfferJobs;

  OnGetJobOffer({required this.idOfferJobs});
}

class OnGetJobOffersList extends JobOfferEvent {
  OnGetJobOffersList();
}

class OnDeleteJobOffer extends JobOfferEvent {
  final int idOfferJobs;

  OnDeleteJobOffer({required this.idOfferJobs});
}
