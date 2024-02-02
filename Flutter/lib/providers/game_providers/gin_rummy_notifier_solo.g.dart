// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gin_rummy_notifier_solo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ginRummySoloNotifierHash() =>
    r'7e39b6e64841c5b2514b332ce62b38006cc37820';

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

abstract class _$GinRummySoloNotifier
    extends BuildlessAutoDisposeAsyncNotifier<GinRummyGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<GinRummyGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [GinRummySoloNotifier].
@ProviderFor(GinRummySoloNotifier)
const ginRummySoloNotifierProvider = GinRummySoloNotifierFamily();

/// See also [GinRummySoloNotifier].
class GinRummySoloNotifierFamily
    extends Family<AsyncValue<GinRummyGameModel?>> {
  /// See also [GinRummySoloNotifier].
  const GinRummySoloNotifierFamily();

  /// See also [GinRummySoloNotifier].
  GinRummySoloNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return GinRummySoloNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  GinRummySoloNotifierProvider getProviderOverride(
    covariant GinRummySoloNotifierProvider provider,
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
  String? get name => r'ginRummySoloNotifierProvider';
}

/// See also [GinRummySoloNotifier].
class GinRummySoloNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GinRummySoloNotifier, GinRummyGameModel?> {
  /// See also [GinRummySoloNotifier].
  GinRummySoloNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => GinRummySoloNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: ginRummySoloNotifierProvider,
          name: r'ginRummySoloNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ginRummySoloNotifierHash,
          dependencies: GinRummySoloNotifierFamily._dependencies,
          allTransitiveDependencies:
              GinRummySoloNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  GinRummySoloNotifierProvider._internal(
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
  Future<GinRummyGameModel?> runNotifierBuild(
    covariant GinRummySoloNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(GinRummySoloNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GinRummySoloNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GinRummySoloNotifier,
      GinRummyGameModel?> createElement() {
    return _GinRummySoloNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GinRummySoloNotifierProvider &&
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

mixin GinRummySoloNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<GinRummyGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _GinRummySoloNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GinRummySoloNotifier,
        GinRummyGameModel?> with GinRummySoloNotifierRef {
  _GinRummySoloNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as GinRummySoloNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as GinRummySoloNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
