// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_requests_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$friendRequestsHash() => r'3178fd1c4fc25e6f8bdabb5855d78bc6def7fe09';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FriendRequests
    extends BuildlessAutoDisposeStreamNotifier<List<FriendRequestForView>> {
  late final String userId;

  Stream<List<FriendRequestForView>> build(
    String userId,
  );
}

/// See also [FriendRequests].
@ProviderFor(FriendRequests)
const friendRequestsProvider = FriendRequestsFamily();

/// See also [FriendRequests].
class FriendRequestsFamily
    extends Family<AsyncValue<List<FriendRequestForView>>> {
  /// See also [FriendRequests].
  const FriendRequestsFamily();

  /// See also [FriendRequests].
  FriendRequestsProvider call(
    String userId,
  ) {
    return FriendRequestsProvider(
      userId,
    );
  }

  @override
  FriendRequestsProvider getProviderOverride(
    covariant FriendRequestsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendRequestsProvider';
}

/// See also [FriendRequests].
class FriendRequestsProvider extends AutoDisposeStreamNotifierProviderImpl<
    FriendRequests, List<FriendRequestForView>> {
  /// See also [FriendRequests].
  FriendRequestsProvider(
    String userId,
  ) : this._internal(
          () => FriendRequests()..userId = userId,
          from: friendRequestsProvider,
          name: r'friendRequestsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$friendRequestsHash,
          dependencies: FriendRequestsFamily._dependencies,
          allTransitiveDependencies:
              FriendRequestsFamily._allTransitiveDependencies,
          userId: userId,
        );

  FriendRequestsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Stream<List<FriendRequestForView>> runNotifierBuild(
    covariant FriendRequests notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(FriendRequests Function() create) {
    return ProviderOverride(
      origin: this,
      override: FriendRequestsProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<FriendRequests,
      List<FriendRequestForView>> createElement() {
    return _FriendRequestsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendRequestsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FriendRequestsRef
    on AutoDisposeStreamNotifierProviderRef<List<FriendRequestForView>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FriendRequestsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<FriendRequests,
        List<FriendRequestForView>> with FriendRequestsRef {
  _FriendRequestsProviderElement(super.provider);

  @override
  String get userId => (origin as FriendRequestsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
