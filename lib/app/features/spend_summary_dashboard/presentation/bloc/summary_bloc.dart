import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/spend_summary_dashboard/data/repository/summary_repo.dart';
import '../../data/models/summary_model.dart';

abstract class SummaryEvent {}
class LoadSummary extends SummaryEvent {
  final String range;
  LoadSummary(this.range);
}

abstract class SummaryState {}
class SummaryLoading extends SummaryState {}
class SummaryLoaded extends SummaryState {
  final SummaryModel data;
  SummaryLoaded(this.data);
}
class SummaryError extends SummaryState {
  final String message;
  SummaryError(this.message);
}

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final SummaryRepository repository;

  SummaryBloc(this.repository) : super(SummaryLoading()) {
    on<LoadSummary>((event, emit) async {
      emit(SummaryLoading());
      try {
        final data = await repository.fetchSummary(event.range);
        emit(SummaryLoaded(data));
      } catch (e) {
        emit(SummaryError(e.toString()));
      }
    });
  }
}