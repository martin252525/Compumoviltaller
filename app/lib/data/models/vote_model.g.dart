// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteModel _$VoteModelFromJson(Map<String, dynamic> json) => VoteModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  status: json['status'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => VoteOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalVotes: (json['totalVotes'] as num?)?.toInt(),
);

Map<String, dynamic> _$VoteModelToJson(VoteModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'status': instance.status,
  'options': instance.options,
  'totalVotes': instance.totalVotes,
};

VoteOption _$VoteOptionFromJson(Map<String, dynamic> json) => VoteOption(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  votes: (json['votes'] as num).toInt(),
);

Map<String, dynamic> _$VoteOptionToJson(VoteOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'votes': instance.votes,
    };

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponse<T>(
  content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  page: (json['page'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  last: json['last'] as bool,
);

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'page': instance.page,
  'size': instance.size,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'last': instance.last,
};

UserVote _$UserVoteFromJson(Map<String, dynamic> json) => UserVote(
  voteId: json['voteId'] as String,
  optionId: json['optionId'] as String,
  votedAt: DateTime.parse(json['votedAt'] as String),
);

Map<String, dynamic> _$UserVoteToJson(UserVote instance) => <String, dynamic>{
  'voteId': instance.voteId,
  'optionId': instance.optionId,
  'votedAt': instance.votedAt.toIso8601String(),
};

VoteRequest _$VoteRequestFromJson(Map<String, dynamic> json) =>
    VoteRequest(optionId: json['optionId'] as String);

Map<String, dynamic> _$VoteRequestToJson(VoteRequest instance) =>
    <String, dynamic>{'optionId': instance.optionId};
