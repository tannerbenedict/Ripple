// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scum_notifier_online.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scumOnlineNotifierHash() =>
    r'4696cbe368a64cdf76e7ed879b0ad6209b93fe94';

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

abstract class _$ScumOnlineNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ScumGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<ScumGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [ScumOnlineNotifier].
@ProviderFor(ScumOnlineNotifier)
const scumOnlineNotifierProvider = ScumOnlineNotifierFamily();

/// See also [ScumOnlineNotifier].
class ScumOnlineNotifierFamily extends Family<AsyncValue<ScumGameModel?>> {
  /// See also [ScumOnlineNotifier].
  const ScumOnlineNotifierFamily();

  /// See also [ScumOnlineNotifier].
  ScumOnlineNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return ScumOnlineNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  ScumOnlineNotifierProvider getProviderOverride(
    covariant ScumOnlineNotifierProvider provider,
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
  String? get name => r'scumOnlineNotifierProvider';
}

/// See also [ScumOnlineNotifier].
class ScumOnlineNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ScumOnlineNotifier, ScumGameModel?> {
  /// See also [ScumOnlineNotifier].
  ScumOnlineNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => ScumOnlineNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: scumOnlineNotifierProvider,
          name: r'scumOnlineNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scumOnlineNotifierHash,
          dependencies: ScumOnlineNotifierFamily._dependencies,
          allTransitiveDependencies:
              ScumOnlineNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  ScumOnlineNotifierProvider._internal(
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
  Future<ScumGameModel?> runNotifierBuild(
    covariant ScumOnlineNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(ScumOnlineNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScumOnlineNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ScumOnlineNotifier, ScumGameModel?>
      createElement() {
    return _ScumOnlineNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScumOnlineNotifierProvider &&
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

mixin ScumOnlineNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ScumGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _ScumOnlineNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ScumOnlineNotifier,
        ScumGameModel?> with ScumOnlineNotifierRef {
  _ScumOnlineNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as ScumOnlineNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as ScumOnlineNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
