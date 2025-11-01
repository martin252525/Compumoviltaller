import '../models/vote_model.dart';
import '../services/vote_api_service.dart';

/// Repositorio para manejar datos de votaciones
class VoteRepository {
  /// Obtener lista de votaciones con paginación
  Future<PaginatedResponse<VoteModel>> getVotes({
    int page = 0,
    int size = 10,
    String? search,
    String? status,
  }) async {
    return await VoteApiService.getVotes(
      page: page,
      size: size,
      search: search,
      status: status,
    );
  }

  /// Obtener detalle de una votación
  Future<VoteModel> getVoteDetail(String voteId) async {
    return await VoteApiService.getVoteDetail(voteId);
  }

  /// Realizar un voto
  Future<void> castVote({
    required String voteId,
    required String optionId,
    required String token,
  }) async {
    return await VoteApiService.castVote(
      voteId: voteId,
      optionId: optionId,
      token: token,
    );
  }

  /// Obtener historial de votos del usuario
  Future<List<UserVote>> getUserVoteHistory(String token) async {
    return await VoteApiService.getUserVoteHistory(token);
  }

  /// Obtener resultados de una votación
  Future<VoteModel> getVoteResults(String voteId) async {
    return await VoteApiService.getVoteResults(voteId);
  }
}

