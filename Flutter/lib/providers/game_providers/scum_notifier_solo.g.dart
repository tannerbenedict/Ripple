// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scum_notifier_solo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scumSoloNotifierHash() => r'8221f4a57f8c4b20cda7250ca39f7fb181c1c4a0';

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

abstract class _$ScumSoloNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ScumGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<ScumGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [ScumSoloNotifier].
@ProviderFor(ScumSoloNotifier)
const scumSoloNotifierProvider = ScumSoloNotifierFamily();

/// See also [ScumSoloNotifier].
class ScumSoloNotifierFamily extends Family<AsyncValue<ScumGameModel?>> {
  /// See also [ScumSoloNotifier].
  const ScumSoloNotifierFamily();

  /// See also [ScumSoloNotifier].
  ScumSoloNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return ScumSoloNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  ScumSoloNotifierProvider getProviderOverride(
    covariant ScumSoloNotifierProvider provider,
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
  String? get name => r'scumSoloNotifierProvider';
}

/// See also [ScumSoloNotifier].
class ScumSoloNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ScumSoloNotifier, ScumGameModel?> {
  /// See also [ScumSoloNotifier].
  ScumSoloNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => ScumSoloNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: scumSoloNotifierProvider,
          name: r'scumSoloNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scumSoloNotifierHash,
          dependencies: ScumSoloNotifierFamily._dependencies,
          allTransitiveDependencies:
              ScumSoloNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  ScumSoloNotifierProvider._internal(
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
    covariant ScumSoloNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(ScumSoloNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScumSoloNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ScumSoloNotifier, ScumGameModel?>
      createElement() {
    return _ScumSoloNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScumSoloNotifierProvider &&
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

mixin ScumSoloNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ScumGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _ScumSoloNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ScumSoloNotifier,
        ScumGameModel?> with ScumSoloNotifierRef {
  _ScumSoloNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as ScumSoloNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as ScumSoloNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
