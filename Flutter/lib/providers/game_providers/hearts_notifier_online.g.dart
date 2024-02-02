// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hearts_notifier_online.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$heartsOnlineNotifierHash() =>
    r'd76cb45d24d70b0ed913341df019680caf68227b';

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

abstract class _$HeartsOnlineNotifier
    extends BuildlessAutoDisposeAsyncNotifier<HeartsGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<HeartsGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [HeartsOnlineNotifier].
@ProviderFor(HeartsOnlineNotifier)
const heartsOnlineNotifierProvider = HeartsOnlineNotifierFamily();

/// See also [HeartsOnlineNotifier].
class HeartsOnlineNotifierFamily extends Family<AsyncValue<HeartsGameModel?>> {
  /// See also [HeartsOnlineNotifier].
  const HeartsOnlineNotifierFamily();

  /// See also [HeartsOnlineNotifier].
  HeartsOnlineNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return HeartsOnlineNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  HeartsOnlineNotifierProvider getProviderOverride(
    covariant HeartsOnlineNotifierProvider provider,
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
  String? get name => r'heartsOnlineNotifierProvider';
}

/// See also [HeartsOnlineNotifier].
class HeartsOnlineNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HeartsOnlineNotifier, HeartsGameModel?> {
  /// See also [HeartsOnlineNotifier].
  HeartsOnlineNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => HeartsOnlineNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: heartsOnlineNotifierProvider,
          name: r'heartsOnlineNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$heartsOnlineNotifierHash,
          dependencies: HeartsOnlineNotifierFamily._dependencies,
          allTransitiveDependencies:
              HeartsOnlineNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  HeartsOnlineNotifierProvider._internal(
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
  Future<HeartsGameModel?> runNotifierBuild(
    covariant HeartsOnlineNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(HeartsOnlineNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HeartsOnlineNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<HeartsOnlineNotifier,
      HeartsGameModel?> createElement() {
    return _HeartsOnlineNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HeartsOnlineNotifierProvider &&
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

mixin HeartsOnlineNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<HeartsGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _HeartsOnlineNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HeartsOnlineNotifier,
        HeartsGameModel?> with HeartsOnlineNotifierRef {
  _HeartsOnlineNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as HeartsOnlineNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as HeartsOnlineNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
