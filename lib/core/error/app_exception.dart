import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// All recoverable failures surfaced to the UI, as a sealed union.
@freezed
sealed class AppException with _$AppException implements Exception {
  const AppException._();

  const factory AppException.databaseFailure({required String message}) =
      DatabaseFailure;

  const factory AppException.notFound({required String id}) = NotFoundFailure;

  const factory AppException.invalidRegistryFile({required String message}) =
      InvalidRegistryFile;

  const factory AppException.unknown({required Object error}) = UnknownFailure;
}
