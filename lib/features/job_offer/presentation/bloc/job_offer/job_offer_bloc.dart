import 'package:bloc/bloc.dart';
import 'package:jobs_applications_app/core/error/failures.dart';
import 'package:jobs_applications_app/features/job_offer/domain/entities/job_offer.dart';
import 'package:jobs_applications_app/features/job_offer/domain/use_cases/delete_job_offer.dart';
import 'package:jobs_applications_app/features/job_offer/domain/use_cases/load_job_offer.dart';
import 'package:jobs_applications_app/features/job_offer/domain/use_cases/load_job_offers_list.dart';
import 'package:meta/meta.dart';

part 'job_offer_event.dart';
part 'job_offer_state.dart';

class JobOfferBloc extends Bloc<JobOfferEvent, JobOfferState> {

  final LoadJobOfferUseCase _loadJobOfferUseCase;
  final LoadJobOffersListUseCase _loadJobOffersListUseCase;
  final DeleteJobOfferUseCase _deleteJobOfferUseCase;


  JobOfferBloc(
    this._loadJobOfferUseCase, 
    this._loadJobOffersListUseCase, 
    this._deleteJobOfferUseCase) 
    : super(JobOfferInitial()) {
    
    on<OnGetJobOffer>((event, emit) async {
      emit(JobOfferLoading());

      final resp = await _loadJobOfferUseCase(event.idOfferJobs);

      resp.fold((f) => emit(JobOfferFailure(failure: f)), 
      (p) => emit(LoadedJobOffer(jobOffer: p)));
    });

    on<OnGetJobOffersList>((event, emit) async {
      emit(JobOfferLoading());

      final resp = await _loadJobOffersListUseCase();

      resp.fold((f) => emit(JobOfferFailure(failure: f)),
      (jl) => emit(LoadedJobOffersList(jobOffersList: jl)));
    });

    on<OnDeleteJobOffer>((event, emit) async {
      emit(JobOfferLoading());

      final resp = await _deleteJobOfferUseCase(event.idOfferJobs);

      resp.fold((f) => emit(JobOfferFailure(failure: f)), 
      (b) => emit(DeletedJobOffer(jobOfferDeleted: b)));
    });


  }
}
