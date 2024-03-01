// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_player_notifier_online.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$twoPlayerNotifierOnlineHash() =>
    r'acd5ed99dbfc79ab94df753c56a0c2813015523d';

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

abstract class _$TwoPlayerNotifierOnline
    extends BuildlessAutoDisposeAsyncNotifier<TwoPlayerGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<TwoPlayerGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [TwoPlayerNotifierOnline].
@ProviderFor(TwoPlayerNotifierOnline)
const twoPlayerNotifierOnlineProvider = TwoPlayerNotifierOnlineFamily();

/// See also [TwoPlayerNotifierOnline].
class TwoPlayerNotifierOnlineFamily
    extends Family<AsyncValue<TwoPlayerGameModel?>> {
  /// See also [TwoPlayerNotifierOnline].
  const TwoPlayerNotifierOnlineFamily();

  /// See also [TwoPlayerNotifierOnline].
  TwoPlayerNotifierOnlineProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return TwoPlayerNotifierOnlineProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  TwoPlayerNotifierOnlineProvider getProviderOverride(
    covariant TwoPlayerNotifierOnlineProvider provider,
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
  String? get name => r'twoPlayerNotifierOnlineProvider';
}

/// See also [TwoPlayerNotifierOnline].
class TwoPlayerNotifierOnlineProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TwoPlayerNotifierOnline,
        TwoPlayerGameModel?> {
  /// See also [TwoPlayerNotifierOnline].
  TwoPlayerNotifierOnlineProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => TwoPlayerNotifierOnline()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: twoPlayerNotifierOnlineProvider,
          name: r'twoPlayerNotifierOnlineProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$twoPlayerNotifierOnlineHash,
          dependencies: TwoPlayerNotifierOnlineFamily._dependencies,
          allTransitiveDependencies:
              TwoPlayerNotifierOnlineFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  TwoPlayerNotifierOnlineProvider._internal(
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
    covariant TwoPlayerNotifierOnline notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(TwoPlayerNotifierOnline Function() create) {
    return ProviderOverride(
      origin: this,
      override: TwoPlayerNotifierOnlineProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TwoPlayerNotifierOnline,
      TwoPlayerGameModel?> createElement() {
    return _TwoPlayerNotifierOnlineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TwoPlayerNotifierOnlineProvider &&
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

mixin TwoPlayerNotifierOnlineRef
    on AutoDisposeAsyncNotifierProviderRef<TwoPlayerGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _TwoPlayerNotifierOnlineProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TwoPlayerNotifierOnline,
        TwoPlayerGameModel?> with TwoPlayerNotifierOnlineRef {
  _TwoPlayerNotifierOnlineProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as TwoPlayerNotifierOnlineProvider).lobbyCode;
  @override
  int? get seed => (origin as TwoPlayerNotifierOnlineProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
