// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteListState()';
}


}

/// @nodoc
class $VoteListStateCopyWith<$Res>  {
$VoteListStateCopyWith(VoteListState _, $Res Function(VoteListState) __);
}


/// Adds pattern-matching-related methods to [VoteListState].
extension VoteListStatePatterns on VoteListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<VoteModel> votes,  bool hasMore,  int currentPage)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.votes,_that.hasMore,_that.currentPage);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<VoteModel> votes,  bool hasMore,  int currentPage)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.votes,_that.hasMore,_that.currentPage);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<VoteModel> votes,  bool hasMore,  int currentPage)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.votes,_that.hasMore,_that.currentPage);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements VoteListState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteListState.initial()';
}


}




/// @nodoc


class _Loading implements VoteListState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteListState.loading()';
}


}




/// @nodoc


class _Loaded implements VoteListState {
  const _Loaded({required final  List<VoteModel> votes, required this.hasMore, required this.currentPage}): _votes = votes;
  

 final  List<VoteModel> _votes;
 List<VoteModel> get votes {
  if (_votes is EqualUnmodifiableListView) return _votes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_votes);
}

 final  bool hasMore;
 final  int currentPage;

/// Create a copy of VoteListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._votes, _votes)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_votes),hasMore,currentPage);

@override
String toString() {
  return 'VoteListState.loaded(votes: $votes, hasMore: $hasMore, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $VoteListStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<VoteModel> votes, bool hasMore, int currentPage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of VoteListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? votes = null,Object? hasMore = null,Object? currentPage = null,}) {
  return _then(_Loaded(
votes: null == votes ? _self._votes : votes // ignore: cast_nullable_to_non_nullable
as List<VoteModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Error implements VoteListState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of VoteListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VoteListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $VoteListStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of VoteListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VoteDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteDetailState()';
}


}

/// @nodoc
class $VoteDetailStateCopyWith<$Res>  {
$VoteDetailStateCopyWith(VoteDetailState _, $Res Function(VoteDetailState) __);
}


/// Adds pattern-matching-related methods to [VoteDetailState].
extension VoteDetailStatePatterns on VoteDetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DetailInitial value)?  initial,TResult Function( _DetailLoading value)?  loading,TResult Function( _DetailLoaded value)?  loaded,TResult Function( _DetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailInitial() when initial != null:
return initial(_that);case _DetailLoading() when loading != null:
return loading(_that);case _DetailLoaded() when loaded != null:
return loaded(_that);case _DetailError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DetailInitial value)  initial,required TResult Function( _DetailLoading value)  loading,required TResult Function( _DetailLoaded value)  loaded,required TResult Function( _DetailError value)  error,}){
final _that = this;
switch (_that) {
case _DetailInitial():
return initial(_that);case _DetailLoading():
return loading(_that);case _DetailLoaded():
return loaded(_that);case _DetailError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DetailInitial value)?  initial,TResult? Function( _DetailLoading value)?  loading,TResult? Function( _DetailLoaded value)?  loaded,TResult? Function( _DetailError value)?  error,}){
final _that = this;
switch (_that) {
case _DetailInitial() when initial != null:
return initial(_that);case _DetailLoading() when loading != null:
return loading(_that);case _DetailLoaded() when loaded != null:
return loaded(_that);case _DetailError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( VoteModel vote)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailInitial() when initial != null:
return initial();case _DetailLoading() when loading != null:
return loading();case _DetailLoaded() when loaded != null:
return loaded(_that.vote);case _DetailError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( VoteModel vote)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _DetailInitial():
return initial();case _DetailLoading():
return loading();case _DetailLoaded():
return loaded(_that.vote);case _DetailError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( VoteModel vote)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _DetailInitial() when initial != null:
return initial();case _DetailLoading() when loading != null:
return loading();case _DetailLoaded() when loaded != null:
return loaded(_that.vote);case _DetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _DetailInitial implements VoteDetailState {
  const _DetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteDetailState.initial()';
}


}




/// @nodoc


class _DetailLoading implements VoteDetailState {
  const _DetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteDetailState.loading()';
}


}




/// @nodoc


class _DetailLoaded implements VoteDetailState {
  const _DetailLoaded(this.vote);
  

 final  VoteModel vote;

/// Create a copy of VoteDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailLoadedCopyWith<_DetailLoaded> get copyWith => __$DetailLoadedCopyWithImpl<_DetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailLoaded&&(identical(other.vote, vote) || other.vote == vote));
}


@override
int get hashCode => Object.hash(runtimeType,vote);

@override
String toString() {
  return 'VoteDetailState.loaded(vote: $vote)';
}


}

/// @nodoc
abstract mixin class _$DetailLoadedCopyWith<$Res> implements $VoteDetailStateCopyWith<$Res> {
  factory _$DetailLoadedCopyWith(_DetailLoaded value, $Res Function(_DetailLoaded) _then) = __$DetailLoadedCopyWithImpl;
@useResult
$Res call({
 VoteModel vote
});




}
/// @nodoc
class __$DetailLoadedCopyWithImpl<$Res>
    implements _$DetailLoadedCopyWith<$Res> {
  __$DetailLoadedCopyWithImpl(this._self, this._then);

  final _DetailLoaded _self;
  final $Res Function(_DetailLoaded) _then;

/// Create a copy of VoteDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vote = null,}) {
  return _then(_DetailLoaded(
null == vote ? _self.vote : vote // ignore: cast_nullable_to_non_nullable
as VoteModel,
  ));
}


}

/// @nodoc


class _DetailError implements VoteDetailState {
  const _DetailError(this.message);
  

 final  String message;

/// Create a copy of VoteDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailErrorCopyWith<_DetailError> get copyWith => __$DetailErrorCopyWithImpl<_DetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VoteDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DetailErrorCopyWith<$Res> implements $VoteDetailStateCopyWith<$Res> {
  factory _$DetailErrorCopyWith(_DetailError value, $Res Function(_DetailError) _then) = __$DetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$DetailErrorCopyWithImpl<$Res>
    implements _$DetailErrorCopyWith<$Res> {
  __$DetailErrorCopyWithImpl(this._self, this._then);

  final _DetailError _self;
  final $Res Function(_DetailError) _then;

/// Create a copy of VoteDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_DetailError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VotingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VotingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VotingState()';
}


}

/// @nodoc
class $VotingStateCopyWith<$Res>  {
$VotingStateCopyWith(VotingState _, $Res Function(VotingState) __);
}


/// Adds pattern-matching-related methods to [VotingState].
extension VotingStatePatterns on VotingState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _VotingInitial value)?  initial,TResult Function( _VotingSubmitting value)?  submitting,TResult Function( _VotingSuccess value)?  success,TResult Function( _VotingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VotingInitial() when initial != null:
return initial(_that);case _VotingSubmitting() when submitting != null:
return submitting(_that);case _VotingSuccess() when success != null:
return success(_that);case _VotingError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _VotingInitial value)  initial,required TResult Function( _VotingSubmitting value)  submitting,required TResult Function( _VotingSuccess value)  success,required TResult Function( _VotingError value)  error,}){
final _that = this;
switch (_that) {
case _VotingInitial():
return initial(_that);case _VotingSubmitting():
return submitting(_that);case _VotingSuccess():
return success(_that);case _VotingError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _VotingInitial value)?  initial,TResult? Function( _VotingSubmitting value)?  submitting,TResult? Function( _VotingSuccess value)?  success,TResult? Function( _VotingError value)?  error,}){
final _that = this;
switch (_that) {
case _VotingInitial() when initial != null:
return initial(_that);case _VotingSubmitting() when submitting != null:
return submitting(_that);case _VotingSuccess() when success != null:
return success(_that);case _VotingError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VotingInitial() when initial != null:
return initial();case _VotingSubmitting() when submitting != null:
return submitting();case _VotingSuccess() when success != null:
return success();case _VotingError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _VotingInitial():
return initial();case _VotingSubmitting():
return submitting();case _VotingSuccess():
return success();case _VotingError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _VotingInitial() when initial != null:
return initial();case _VotingSubmitting() when submitting != null:
return submitting();case _VotingSuccess() when success != null:
return success();case _VotingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _VotingInitial implements VotingState {
  const _VotingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VotingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VotingState.initial()';
}


}




/// @nodoc


class _VotingSubmitting implements VotingState {
  const _VotingSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VotingSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VotingState.submitting()';
}


}




/// @nodoc


class _VotingSuccess implements VotingState {
  const _VotingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VotingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VotingState.success()';
}


}




/// @nodoc


class _VotingError implements VotingState {
  const _VotingError(this.message);
  

 final  String message;

/// Create a copy of VotingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VotingErrorCopyWith<_VotingError> get copyWith => __$VotingErrorCopyWithImpl<_VotingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VotingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VotingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$VotingErrorCopyWith<$Res> implements $VotingStateCopyWith<$Res> {
  factory _$VotingErrorCopyWith(_VotingError value, $Res Function(_VotingError) _then) = __$VotingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$VotingErrorCopyWithImpl<$Res>
    implements _$VotingErrorCopyWith<$Res> {
  __$VotingErrorCopyWithImpl(this._self, this._then);

  final _VotingError _self;
  final $Res Function(_VotingError) _then;

/// Create a copy of VotingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_VotingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VoteHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteHistoryState()';
}


}

/// @nodoc
class $VoteHistoryStateCopyWith<$Res>  {
$VoteHistoryStateCopyWith(VoteHistoryState _, $Res Function(VoteHistoryState) __);
}


/// Adds pattern-matching-related methods to [VoteHistoryState].
extension VoteHistoryStatePatterns on VoteHistoryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _HistoryInitial value)?  initial,TResult Function( _HistoryLoading value)?  loading,TResult Function( _HistoryLoaded value)?  loaded,TResult Function( _HistoryEmpty value)?  empty,TResult Function( _HistoryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryInitial() when initial != null:
return initial(_that);case _HistoryLoading() when loading != null:
return loading(_that);case _HistoryLoaded() when loaded != null:
return loaded(_that);case _HistoryEmpty() when empty != null:
return empty(_that);case _HistoryError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _HistoryInitial value)  initial,required TResult Function( _HistoryLoading value)  loading,required TResult Function( _HistoryLoaded value)  loaded,required TResult Function( _HistoryEmpty value)  empty,required TResult Function( _HistoryError value)  error,}){
final _that = this;
switch (_that) {
case _HistoryInitial():
return initial(_that);case _HistoryLoading():
return loading(_that);case _HistoryLoaded():
return loaded(_that);case _HistoryEmpty():
return empty(_that);case _HistoryError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _HistoryInitial value)?  initial,TResult? Function( _HistoryLoading value)?  loading,TResult? Function( _HistoryLoaded value)?  loaded,TResult? Function( _HistoryEmpty value)?  empty,TResult? Function( _HistoryError value)?  error,}){
final _that = this;
switch (_that) {
case _HistoryInitial() when initial != null:
return initial(_that);case _HistoryLoading() when loading != null:
return loading(_that);case _HistoryLoaded() when loaded != null:
return loaded(_that);case _HistoryEmpty() when empty != null:
return empty(_that);case _HistoryError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<UserVote> votes)?  loaded,TResult Function()?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryInitial() when initial != null:
return initial();case _HistoryLoading() when loading != null:
return loading();case _HistoryLoaded() when loaded != null:
return loaded(_that.votes);case _HistoryEmpty() when empty != null:
return empty();case _HistoryError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<UserVote> votes)  loaded,required TResult Function()  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _HistoryInitial():
return initial();case _HistoryLoading():
return loading();case _HistoryLoaded():
return loaded(_that.votes);case _HistoryEmpty():
return empty();case _HistoryError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<UserVote> votes)?  loaded,TResult? Function()?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _HistoryInitial() when initial != null:
return initial();case _HistoryLoading() when loading != null:
return loading();case _HistoryLoaded() when loaded != null:
return loaded(_that.votes);case _HistoryEmpty() when empty != null:
return empty();case _HistoryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryInitial implements VoteHistoryState {
  const _HistoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteHistoryState.initial()';
}


}




/// @nodoc


class _HistoryLoading implements VoteHistoryState {
  const _HistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteHistoryState.loading()';
}


}




/// @nodoc


class _HistoryLoaded implements VoteHistoryState {
  const _HistoryLoaded(final  List<UserVote> votes): _votes = votes;
  

 final  List<UserVote> _votes;
 List<UserVote> get votes {
  if (_votes is EqualUnmodifiableListView) return _votes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_votes);
}


/// Create a copy of VoteHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryLoadedCopyWith<_HistoryLoaded> get copyWith => __$HistoryLoadedCopyWithImpl<_HistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryLoaded&&const DeepCollectionEquality().equals(other._votes, _votes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_votes));

@override
String toString() {
  return 'VoteHistoryState.loaded(votes: $votes)';
}


}

/// @nodoc
abstract mixin class _$HistoryLoadedCopyWith<$Res> implements $VoteHistoryStateCopyWith<$Res> {
  factory _$HistoryLoadedCopyWith(_HistoryLoaded value, $Res Function(_HistoryLoaded) _then) = __$HistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<UserVote> votes
});




}
/// @nodoc
class __$HistoryLoadedCopyWithImpl<$Res>
    implements _$HistoryLoadedCopyWith<$Res> {
  __$HistoryLoadedCopyWithImpl(this._self, this._then);

  final _HistoryLoaded _self;
  final $Res Function(_HistoryLoaded) _then;

/// Create a copy of VoteHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? votes = null,}) {
  return _then(_HistoryLoaded(
null == votes ? _self._votes : votes // ignore: cast_nullable_to_non_nullable
as List<UserVote>,
  ));
}


}

/// @nodoc


class _HistoryEmpty implements VoteHistoryState {
  const _HistoryEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoteHistoryState.empty()';
}


}




/// @nodoc


class _HistoryError implements VoteHistoryState {
  const _HistoryError(this.message);
  

 final  String message;

/// Create a copy of VoteHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryErrorCopyWith<_HistoryError> get copyWith => __$HistoryErrorCopyWithImpl<_HistoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VoteHistoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$HistoryErrorCopyWith<$Res> implements $VoteHistoryStateCopyWith<$Res> {
  factory _$HistoryErrorCopyWith(_HistoryError value, $Res Function(_HistoryError) _then) = __$HistoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$HistoryErrorCopyWithImpl<$Res>
    implements _$HistoryErrorCopyWith<$Res> {
  __$HistoryErrorCopyWithImpl(this._self, this._then);

  final _HistoryError _self;
  final $Res Function(_HistoryError) _then;

/// Create a copy of VoteHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_HistoryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
