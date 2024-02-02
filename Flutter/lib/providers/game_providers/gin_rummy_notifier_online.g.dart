// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gin_rummy_notifier_online.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ginRummyNotifierOnlineHash() =>
    r'ad53bf7004ba80a2332c659d88aceec8216e5362';

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

abstract class _$GinRummyNotifierOnline
    extends BuildlessAutoDisposeAsyncNotifier<GinRummyGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<GinRummyGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [GinRummyNotifierOnline].
@ProviderFor(GinRummyNotifierOnline)
const ginRummyNotifierOnlineProvider = GinRummyNotifierOnlineFamily();

/// See also [GinRummyNotifierOnline].
class GinRummyNotifierOnlineFamily
    extends Family<AsyncValue<GinRummyGameModel?>> {
  /// See also [GinRummyNotifierOnline].
  const GinRummyNotifierOnlineFamily();

  /// See also [GinRummyNotifierOnline].
  GinRummyNotifierOnlineProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return GinRummyNotifierOnlineProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  GinRummyNotifierOnlineProvider getProviderOverride(
    covariant GinRummyNotifierOnlineProvider provider,
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
  String? get name => r'ginRummyNotifierOnlineProvider';
}

/// See also [GinRummyNotifierOnline].
class GinRummyNotifierOnlineProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GinRummyNotifierOnline,
        GinRummyGameModel?> {
  /// See also [GinRummyNotifierOnline].
  GinRummyNotifierOnlineProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => GinRummyNotifierOnline()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: ginRummyNotifierOnlineProvider,
          name: r'ginRummyNotifierOnlineProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ginRummyNotifierOnlineHash,
          dependencies: GinRummyNotifierOnlineFamily._dependencies,
          allTransitiveDependencies:
              GinRummyNotifierOnlineFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  GinRummyNotifierOnlineProvider._internal(
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
    covariant GinRummyNotifierOnline notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(GinRummyNotifierOnline Function() create) {
    return ProviderOverride(
      origin: this,
      override: GinRummyNotifierOnlineProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GinRummyNotifierOnline,
      GinRummyGameModel?> createElement() {
    return _GinRummyNotifierOnlineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GinRummyNotifierOnlineProvider &&
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

mixin GinRummyNotifierOnlineRef
    on AutoDisposeAsyncNotifierProviderRef<GinRummyGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _GinRummyNotifierOnlineProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GinRummyNotifierOnline,
        GinRummyGameModel?> with GinRummyNotifierOnlineRef {
  _GinRummyNotifierOnlineProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as GinRummyNotifierOnlineProvider).lobbyCode;
  @override
  int? get seed => (origin as GinRummyNotifierOnlineProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
