// Modelos de datos para la API de votación
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_model.g.dart';

/// Modelo para una votación
@JsonSerializable()
class VoteModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<VoteOption> options;
  final int? totalVotes;

  VoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.options,
    this.totalVotes,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$VoteModelToJson(this);
}

/// Modelo para una opción de votación
@JsonSerializable()
class VoteOption {
  final String id;
  final String name;
  final String? description;
  final int votes;

  VoteOption({
    required this.id,
    required this.name,
    this.description,
    required this.votes,
  });

  factory VoteOption.fromJson(Map<String, dynamic> json) =>
      _$VoteOptionFromJson(json);

  Map<String, dynamic> toJson() => _$VoteOptionToJson(this);
}

/// Modelo para la respuesta paginada
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool last;

  PaginatedResponse({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.last,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

/// Modelo para el voto del usuario
@JsonSerializable()
class UserVote {
  final String voteId;
  final String optionId;
  final DateTime votedAt;

  UserVote({
    required this.voteId,
    required this.optionId,
    required this.votedAt,
  });

  factory UserVote.fromJson(Map<String, dynamic> json) =>
      _$UserVoteFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoteToJson(this);
}

/// Modelo para la solicitud de voto
@JsonSerializable()
class VoteRequest {
  final String optionId;

  VoteRequest({required this.optionId});

  factory VoteRequest.fromJson(Map<String, dynamic> json) =>
      _$VoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoteRequestToJson(this);
}

