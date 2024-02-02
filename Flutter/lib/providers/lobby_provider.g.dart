// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lobbyNotifierHash() => r'e20321f4286fc961662da34fb6a4a873c2399f2b';

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

abstract class _$LobbyNotifier
    extends BuildlessAutoDisposeAsyncNotifier<LobbyModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<LobbyModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [LobbyNotifier].
@ProviderFor(LobbyNotifier)
const lobbyNotifierProvider = LobbyNotifierFamily();

/// See also [LobbyNotifier].
class LobbyNotifierFamily extends Family<AsyncValue<LobbyModel?>> {
  /// See also [LobbyNotifier].
  const LobbyNotifierFamily();

  /// See also [LobbyNotifier].
  LobbyNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return LobbyNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  LobbyNotifierProvider getProviderOverride(
    covariant LobbyNotifierProvider provider,
  ) {
    return call(
      provider.lobbyCode,
      seed: provider.seed,
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
  String? get name => r'lobbyNotifierProvider';
}

/// See also [LobbyNotifier].
class LobbyNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LobbyNotifier, LobbyModel?> {
  /// See also [LobbyNotifier].
  LobbyNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => LobbyNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: lobbyNotifierProvider,
          name: r'lobbyNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lobbyNotifierHash,
          dependencies: LobbyNotifierFamily._dependencies,
          allTransitiveDependencies:
              LobbyNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  LobbyNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyCode,
    required this.seed,
  }) : super.internal();

  final String lobbyCode;
  final int? seed;

  @override
  Future<LobbyModel?> runNotifierBuild(
    covariant LobbyNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(LobbyNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LobbyNotifierProvider._internal(
        () => create()
          ..lobbyCode = lobbyCode
          ..seed = seed,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyCode: lobbyCode,
        seed: seed,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LobbyNotifier, LobbyModel?>
      createElement() {
    return _LobbyNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LobbyNotifierProvider &&
        other.lobbyCode == lobbyCode &&
        other.seed == seed;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyCode.hashCode);
    hash = _SystemHash.combine(hash, seed.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LobbyNotifierRef on AutoDisposeAsyncNotifierProviderRef<LobbyModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _LobbyNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LobbyNotifier, LobbyModel?>
    with LobbyNotifierRef {
  _LobbyNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as LobbyNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as LobbyNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
