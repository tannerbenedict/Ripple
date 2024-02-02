// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheat_notifier_online.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cheatOnlineNotifierHash() =>
    r'ef6357129d3c43f65eed3899d618bbc931f02f2d';

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

abstract class _$CheatOnlineNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CheatGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<CheatGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [CheatOnlineNotifier].
@ProviderFor(CheatOnlineNotifier)
const cheatOnlineNotifierProvider = CheatOnlineNotifierFamily();

/// See also [CheatOnlineNotifier].
class CheatOnlineNotifierFamily extends Family<AsyncValue<CheatGameModel?>> {
  /// See also [CheatOnlineNotifier].
  const CheatOnlineNotifierFamily();

  /// See also [CheatOnlineNotifier].
  CheatOnlineNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return CheatOnlineNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  CheatOnlineNotifierProvider getProviderOverride(
    covariant CheatOnlineNotifierProvider provider,
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
  String? get name => r'cheatOnlineNotifierProvider';
}

/// See also [CheatOnlineNotifier].
class CheatOnlineNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CheatOnlineNotifier, CheatGameModel?> {
  /// See also [CheatOnlineNotifier].
  CheatOnlineNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => CheatOnlineNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: cheatOnlineNotifierProvider,
          name: r'cheatOnlineNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cheatOnlineNotifierHash,
          dependencies: CheatOnlineNotifierFamily._dependencies,
          allTransitiveDependencies:
              CheatOnlineNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  CheatOnlineNotifierProvider._internal(
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
  Future<CheatGameModel?> runNotifierBuild(
    covariant CheatOnlineNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(CheatOnlineNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CheatOnlineNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CheatOnlineNotifier, CheatGameModel?>
      createElement() {
    return _CheatOnlineNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheatOnlineNotifierProvider &&
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

mixin CheatOnlineNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CheatGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _CheatOnlineNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CheatOnlineNotifier,
        CheatGameModel?> with CheatOnlineNotifierRef {
  _CheatOnlineNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as CheatOnlineNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as CheatOnlineNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
