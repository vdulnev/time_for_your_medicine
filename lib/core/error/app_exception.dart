import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// All recoverable failures surfaced to the UI, as a sealed union.
@freezed
sealed class AppException with _$AppException implements Exception {
  const AppException._();

  const factory AppException.databaseFailure({required String message}) =
      DatabaseFailure;

  const factory AppException.notFound({required String id}) = NotFoundFailure;

  const factory AppException.unknown({required Object error}) = UnknownFailure;

  /// A short, user-facing message.
  String get message => switch (this) {
    DatabaseFailure(:final message) => message,
    NotFoundFailure(:final id) => 'Not found: $id',
    UnknownFailure(:final error) => 'Something went wrong: $error',
  };
}
