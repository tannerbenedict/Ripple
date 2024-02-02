// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheat_notifier_solo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cheatSoloNotifierHash() => r'6ecce0046228e828a3addc6dfdaf3011166a272a';

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

abstract class _$CheatSoloNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CheatGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<CheatGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [CheatSoloNotifier].
@ProviderFor(CheatSoloNotifier)
const cheatSoloNotifierProvider = CheatSoloNotifierFamily();

/// See also [CheatSoloNotifier].
class CheatSoloNotifierFamily extends Family<AsyncValue<CheatGameModel?>> {
  /// See also [CheatSoloNotifier].
  const CheatSoloNotifierFamily();

  /// See also [CheatSoloNotifier].
  CheatSoloNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return CheatSoloNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  CheatSoloNotifierProvider getProviderOverride(
    covariant CheatSoloNotifierProvider provider,
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
  String? get name => r'cheatSoloNotifierProvider';
}

/// See also [CheatSoloNotifier].
class CheatSoloNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CheatSoloNotifier, CheatGameModel?> {
  /// See also [CheatSoloNotifier].
  CheatSoloNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => CheatSoloNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: cheatSoloNotifierProvider,
          name: r'cheatSoloNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cheatSoloNotifierHash,
          dependencies: CheatSoloNotifierFamily._dependencies,
          allTransitiveDependencies:
              CheatSoloNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  CheatSoloNotifierProvider._internal(
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
    covariant CheatSoloNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(CheatSoloNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CheatSoloNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CheatSoloNotifier, CheatGameModel?>
      createElement() {
    return _CheatSoloNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheatSoloNotifierProvider &&
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

mixin CheatSoloNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CheatGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _CheatSoloNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CheatSoloNotifier,
        CheatGameModel?> with CheatSoloNotifierRef {
  _CheatSoloNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as CheatSoloNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as CheatSoloNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
