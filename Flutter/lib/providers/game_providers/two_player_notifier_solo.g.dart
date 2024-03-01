// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_player_notifier_solo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$twoPlayerSoloNotifierHash() =>
    r'95f0755633a952a45538fcc1288552e87ef9eedb';

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

abstract class _$TwoPlayerSoloNotifier
    extends BuildlessAutoDisposeAsyncNotifier<TwoPlayerGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<TwoPlayerGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [TwoPlayerSoloNotifier].
@ProviderFor(TwoPlayerSoloNotifier)
const twoPlayerSoloNotifierProvider = TwoPlayerSoloNotifierFamily();

/// See also [TwoPlayerSoloNotifier].
class TwoPlayerSoloNotifierFamily
    extends Family<AsyncValue<TwoPlayerGameModel?>> {
  /// See also [TwoPlayerSoloNotifier].
  const TwoPlayerSoloNotifierFamily();

  /// See also [TwoPlayerSoloNotifier].
  TwoPlayerSoloNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return TwoPlayerSoloNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  TwoPlayerSoloNotifierProvider getProviderOverride(
    covariant TwoPlayerSoloNotifierProvider provider,
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
  String? get name => r'twoPlayerSoloNotifierProvider';
}

/// See also [TwoPlayerSoloNotifier].
class TwoPlayerSoloNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TwoPlayerSoloNotifier,
        TwoPlayerGameModel?> {
  /// See also [TwoPlayerSoloNotifier].
  TwoPlayerSoloNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => TwoPlayerSoloNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: twoPlayerSoloNotifierProvider,
          name: r'twoPlayerSoloNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$twoPlayerSoloNotifierHash,
          dependencies: TwoPlayerSoloNotifierFamily._dependencies,
          allTransitiveDependencies:
              TwoPlayerSoloNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  TwoPlayerSoloNotifierProvider._internal(
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
  Future<TwoPlayerGameModel?> runNotifierBuild(
    covariant TwoPlayerSoloNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(TwoPlayerSoloNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TwoPlayerSoloNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TwoPlayerSoloNotifier,
      TwoPlayerGameModel?> createElement() {
    return _TwoPlayerSoloNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TwoPlayerSoloNotifierProvider &&
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

mixin TwoPlayerSoloNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<TwoPlayerGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _TwoPlayerSoloNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TwoPlayerSoloNotifier,
        TwoPlayerGameModel?> with TwoPlayerSoloNotifierRef {
  _TwoPlayerSoloNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as TwoPlayerSoloNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as TwoPlayerSoloNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
