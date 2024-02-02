// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$friendsHash() => r'd6933d82f6086ba1a9551ca1ba9fc37a446ca96f';

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

abstract class _$Friends
    extends BuildlessAutoDisposeStreamNotifier<List<FriendForView>> {
  late final String userId;

  Stream<List<FriendForView>> build(
    String userId,
  );
}

/// See also [Friends].
@ProviderFor(Friends)
const friendsProvider = FriendsFamily();

/// See also [Friends].
class FriendsFamily extends Family<AsyncValue<List<FriendForView>>> {
  /// See also [Friends].
  const FriendsFamily();

  /// See also [Friends].
  FriendsProvider call(
    String userId,
  ) {
    return FriendsProvider(
      userId,
    );
  }

  @override
  FriendsProvider getProviderOverride(
    covariant FriendsProvider provider,
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
  String? get name => r'friendsProvider';
}

/// See also [Friends].
class FriendsProvider extends AutoDisposeStreamNotifierProviderImpl<Friends,
    List<FriendForView>> {
  /// See also [Friends].
  FriendsProvider(
    String userId,
  ) : this._internal(
          () => Friends()..userId = userId,
          from: friendsProvider,
          name: r'friendsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$friendsHash,
          dependencies: FriendsFamily._dependencies,
          allTransitiveDependencies: FriendsFamily._allTransitiveDependencies,
          userId: userId,
        );

  FriendsProvider._internal(
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
  Stream<List<FriendForView>> runNotifierBuild(
    covariant Friends notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(Friends Function() create) {
    return ProviderOverride(
      origin: this,
      override: FriendsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Friends, List<FriendForView>>
      createElement() {
    return _FriendsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FriendsRef on AutoDisposeStreamNotifierProviderRef<List<FriendForView>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FriendsProviderElement extends AutoDisposeStreamNotifierProviderElement<
    Friends, List<FriendForView>> with FriendsRef {
  _FriendsProviderElement(super.provider);

  @override
  String get userId => (origin as FriendsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
