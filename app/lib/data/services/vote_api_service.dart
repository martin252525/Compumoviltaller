import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/vote_model.dart';

/// Servicio para consumir la API de votación
class VoteApiService {
  static final Dio _client = Dio();
  static final Logger _logger = Logger();

  static const String _baseUrl = "https://api.sebastian.cl/vote";
  static const String _jsonMime = "application/json";

  /// Configurar interceptores
  static void initialize() {
    if (!_client.interceptors.any(
      (interceptor) => interceptor is LogInterceptor,
    )) {
      _client.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
        ),
      );
    }

    // Configurar timeout
    _client.options.connectTimeout = const Duration(seconds: 30);
    _client.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// Obtener lista de votaciones con paginación
  static Future<PaginatedResponse<VoteModel>> getVotes({
    int page = 0,
    int size = 10,
    String? search,
    String? status,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'size': size,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final Response response = await _client.get(
        '$_baseUrl/votes',
        queryParameters: queryParams,
        options: Options(headers: {'accept': _jsonMime}),
      );

      if (response.statusCode == 200) {
        return PaginatedResponse.fromJson(
          response.data,
          (json) => VoteModel.fromJson(json as Map<String, dynamic>),
        );
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error al obtener votaciones", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Obtener detalle de una votación
  static Future<VoteModel> getVoteDetail(String voteId) async {
    try {
      final Response response = await _client.get(
        '$_baseUrl/votes/$voteId',
        options: Options(headers: {'accept': _jsonMime}),
      );

      if (response.statusCode == 200) {
        return VoteModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error al obtener detalle de votación", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Realizar un voto (requiere autenticación)
  static Future<void> castVote({
    required String voteId,
    required String optionId,
    required String token,
  }) async {
    try {
      final VoteRequest voteRequest = VoteRequest(optionId: optionId);

      final Response response = await _client.post(
        '$_baseUrl/votes/$voteId/cast',
        data: voteRequest.toJson(),
        options: Options(
          headers: {
            'accept': _jsonMime,
            'Content-Type': _jsonMime,
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error al realizar voto", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Obtener historial de votos del usuario (requiere autenticación)
  static Future<List<UserVote>> getUserVoteHistory(String token) async {
    try {
      final Response response = await _client.get(
        '$_baseUrl/user/votes',
        options: Options(
          headers: {
            'accept': _jsonMime,
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserVote.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error al obtener historial de votos", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Obtener resultados de una votación
  static Future<VoteModel> getVoteResults(String voteId) async {
    try {
      final Response response = await _client.get(
        '$_baseUrl/votes/$voteId/results',
        options: Options(headers: {'accept': _jsonMime}),
      );

      if (response.statusCode == 200) {
        return VoteModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error al obtener resultados", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

