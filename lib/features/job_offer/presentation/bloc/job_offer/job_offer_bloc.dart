import 'package:bloc/bloc.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:meta/meta.dart';

part 'job_offer_event.dart';
part 'job_offer_state.dart';

class JobOfferBloc extends Bloc<JobOfferEvent, JobOfferState> {
  JobOfferBloc() : super(JobOfferInitial()) {
    on<JobOfferEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
