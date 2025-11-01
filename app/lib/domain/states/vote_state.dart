import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/vote_model.dart';

part 'vote_state.freezed.dart';

/// Estado para la lista de votaciones
@freezed
class VoteListState with _$VoteListState {
  const factory VoteListState.initial() = _Initial;
  const factory VoteListState.loading() = _Loading;
  const factory VoteListState.loaded({
    required List<VoteModel> votes,
    required bool hasMore,
    required int currentPage,
  }) = _Loaded;
  const factory VoteListState.error(String message) = _Error;
}

/// Estado para el detalle de una votación
@freezed
class VoteDetailState with _$VoteDetailState {
  const factory VoteDetailState.initial() = _DetailInitial;
  const factory VoteDetailState.loading() = _DetailLoading;
  const factory VoteDetailState.loaded(VoteModel vote) = _DetailLoaded;
  const factory VoteDetailState.error(String message) = _DetailError;
}

/// Estado para el proceso de votación
@freezed
class VotingState with _$VotingState {
  const factory VotingState.initial() = _VotingInitial;
  const factory VotingState.submitting() = _VotingSubmitting;
  const factory VotingState.success() = _VotingSuccess;
  const factory VotingState.error(String message) = _VotingError;
}

/// Estado para el historial de votos del usuario
@freezed
class VoteHistoryState with _$VoteHistoryState {
  const factory VoteHistoryState.initial() = _HistoryInitial;
  const factory VoteHistoryState.loading() = _HistoryLoading;
  const factory VoteHistoryState.loaded(List<UserVote> votes) = _HistoryLoaded;
  const factory VoteHistoryState.empty() = _HistoryEmpty;
  const factory VoteHistoryState.error(String message) = _HistoryError;
}

