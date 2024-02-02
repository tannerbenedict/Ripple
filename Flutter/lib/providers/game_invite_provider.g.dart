// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_invite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameInvitesHash() => r'0789771465b3535edc5ace7935630c8a6403bbbc';

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

abstract class _$GameInvites
    extends BuildlessAutoDisposeStreamNotifier<List<GameInvite>> {
  late final String userId;

  Stream<List<GameInvite>> build(
    String userId,
  );
}

/// See also [GameInvites].
@ProviderFor(GameInvites)
const gameInvitesProvider = GameInvitesFamily();

/// See also [GameInvites].
class GameInvitesFamily extends Family<AsyncValue<List<GameInvite>>> {
  /// See also [GameInvites].
  const GameInvitesFamily();

  /// See also [GameInvites].
  GameInvitesProvider call(
    String userId,
  ) {
    return GameInvitesProvider(
      userId,
    );
  }

  @override
  GameInvitesProvider getProviderOverride(
    covariant GameInvitesProvider provider,
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
  String? get name => r'gameInvitesProvider';
}

/// See also [GameInvites].
class GameInvitesProvider extends AutoDisposeStreamNotifierProviderImpl<
    GameInvites, List<GameInvite>> {
  /// See also [GameInvites].
  GameInvitesProvider(
    String userId,
  ) : this._internal(
          () => GameInvites()..userId = userId,
          from: gameInvitesProvider,
          name: r'gameInvitesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameInvitesHash,
          dependencies: GameInvitesFamily._dependencies,
          allTransitiveDependencies:
              GameInvitesFamily._allTransitiveDependencies,
          userId: userId,
        );

  GameInvitesProvider._internal(
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
  Stream<List<GameInvite>> runNotifierBuild(
    covariant GameInvites notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(GameInvites Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameInvitesProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<GameInvites, List<GameInvite>>
      createElement() {
    return _GameInvitesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameInvitesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameInvitesRef on AutoDisposeStreamNotifierProviderRef<List<GameInvite>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _GameInvitesProviderElement
    extends AutoDisposeStreamNotifierProviderElement<GameInvites,
        List<GameInvite>> with GameInvitesRef {
  _GameInvitesProviderElement(super.provider);

  @override
  String get userId => (origin as GameInvitesProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
