// ============================================================================
// SYNC STATE
// ============================================================================
part of 'sync_cubit.dart';

@freezed
class SyncState with _$SyncState {
  const factory SyncState.idle() = _Idle;
  const factory SyncState.syncing() = _Syncing;
  const factory SyncState.success({required SyncResult result}) = _Success;
  const factory SyncState.error({
    required String message,
    SyncResult? result,
  }) = _Error;
  const factory SyncState.status({required SyncStatus status}) = _Status;
}