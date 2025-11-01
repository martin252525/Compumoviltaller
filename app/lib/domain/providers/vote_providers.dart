import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../data/repositories/vote_repository.dart';
import '../../data/models/vote_model.dart';
import '../states/vote_state.dart';

final _logger = Logger();

/// Provider del repositorio
final voteRepositoryProvider = Provider((ref) => VoteRepository());

/// Provider para la lista de votaciones
final voteListProvider =
    StateNotifierProvider<VoteListNotifier, VoteListState>((ref) {
  return VoteListNotifier(ref.watch(voteRepositoryProvider));
});

/// Notifier para manejar la lista de votaciones
class VoteListNotifier extends StateNotifier<VoteListState> {
  final VoteRepository _repository;
  final List<VoteModel> _votes = [];
  int _currentPage = 0;
  String? _currentSearch;
  String? _currentStatus;

  VoteListNotifier(this._repository)
      : super(const VoteListState.initial());

  /// Cargar votaciones iniciales
  Future<void> loadVotes({String? search, String? status}) async {
    state = const VoteListState.loading();
    _currentPage = 0;
    _votes.clear();
    _currentSearch = search;
    _currentStatus = status;

    try {
      final response = await _repository.getVotes(
        page: _currentPage,
        size: 10,
        search: search,
        status: status,
      );

      _votes.addAll(response.content);
      state = VoteListState.loaded(
        votes: List.from(_votes),
        hasMore: !response.last,
        currentPage: _currentPage,
      );
    } catch (e, stackTrace) {
      _logger.e("Error al cargar votaciones", error: e, stackTrace: stackTrace);
      state = VoteListState.error(_getErrorMessage(e));
    }
  }

  /// Cargar más votaciones (infinite scroll)
  Future<void> loadMore() async {
    if (state is! _Loaded) return;

    final currentState = state as _Loaded;
    if (!currentState.hasMore) return;

    _currentPage++;

    try {
      final response = await _repository.getVotes(
        page: _currentPage,
        size: 10,
        search: _currentSearch,
        status: _currentStatus,
      );

      _votes.addAll(response.content);
      state = VoteListState.loaded(
        votes: List.from(_votes),
        hasMore: !response.last,
        currentPage: _currentPage,
      );
    } catch (e, stackTrace) {
      _logger.e("Error al cargar más votaciones", error: e, stackTrace: stackTrace);
      // Mantener el estado actual en caso de error al cargar más
    }
  }

  /// Refrescar la lista
  Future<void> refresh() async {
    await loadVotes(search: _currentSearch, status: _currentStatus);
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return 'Error de conexión. Verifica tu internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Tiempo de espera agotado. Intenta nuevamente.';
    } else if (error.toString().contains('401')) {
      return 'No autorizado. Inicia sesión nuevamente.';
    } else if (error.toString().contains('403')) {
      return 'Acceso denegado.';
    } else if (error.toString().contains('404')) {
      return 'Recurso no encontrado.';
    } else if (error.toString().contains('5')) {
      return 'Error del servidor. Intenta más tarde.';
    }
    return 'Ha ocurrido un error inesperado.';
  }
}

/// Provider para el detalle de una votación
final voteDetailProvider = StateNotifierProvider.family<VoteDetailNotifier,
    VoteDetailState, String>((ref, voteId) {
  return VoteDetailNotifier(ref.watch(voteRepositoryProvider), voteId);
});

/// Notifier para el detalle de votación
class VoteDetailNotifier extends StateNotifier<VoteDetailState> {
  final VoteRepository _repository;
  final String _voteId;

  VoteDetailNotifier(this._repository, this._voteId)
      : super(const VoteDetailState.initial()) {
    loadDetail();
  }

  Future<void> loadDetail() async {
    state = const VoteDetailState.loading();

    try {
      final vote = await _repository.getVoteDetail(_voteId);
      state = VoteDetailState.loaded(vote);
    } catch (e, stackTrace) {
      _logger.e("Error al cargar detalle", error: e, stackTrace: stackTrace);
      state = VoteDetailState.error(_getErrorMessage(e));
    }
  }

  Future<void> refresh() async {
    await loadDetail();
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return 'Error de conexión. Verifica tu internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Tiempo de espera agotado. Intenta nuevamente.';
    } else if (error.toString().contains('404')) {
      return 'Votación no encontrada.';
    } else if (error.toString().contains('5')) {
      return 'Error del servidor. Intenta más tarde.';
    }
    return 'Ha ocurrido un error inesperado.';
  }
}

/// Provider para el historial de votos del usuario
final voteHistoryProvider =
    StateNotifierProvider<VoteHistoryNotifier, VoteHistoryState>((ref) {
  return VoteHistoryNotifier(ref.watch(voteRepositoryProvider));
});

/// Notifier para el historial de votos
class VoteHistoryNotifier extends StateNotifier<VoteHistoryState> {
  final VoteRepository _repository;

  VoteHistoryNotifier(this._repository)
      : super(const VoteHistoryState.initial());

  Future<void> loadHistory(String token) async {
    state = const VoteHistoryState.loading();

    try {
      final votes = await _repository.getUserVoteHistory(token);
      if (votes.isEmpty) {
        state = const VoteHistoryState.empty();
      } else {
        state = VoteHistoryState.loaded(votes);
      }
    } catch (e, stackTrace) {
      _logger.e("Error al cargar historial", error: e, stackTrace: stackTrace);
      state = VoteHistoryState.error(_getErrorMessage(e));
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return 'Error de conexión. Verifica tu internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Tiempo de espera agotado. Intenta nuevamente.';
    } else if (error.toString().contains('401')) {
      return 'No autorizado. Inicia sesión nuevamente.';
    } else if (error.toString().contains('5')) {
      return 'Error del servidor. Intenta más tarde.';
    }
    return 'Ha ocurrido un error inesperado.';
  }
}

