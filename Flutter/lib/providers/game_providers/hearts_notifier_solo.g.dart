// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hearts_notifier_solo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$heartsSoloNotifierHash() =>
    r'b740826e5a6d869191e47eb2081706dc0d96f457';

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

abstract class _$HeartsSoloNotifier
    extends BuildlessAutoDisposeAsyncNotifier<HeartsGameModel?> {
  late final String lobbyCode;
  late final int? seed;

  Future<HeartsGameModel?> build(
    String lobbyCode, {
    int? seed,
  });
}

/// See also [HeartsSoloNotifier].
@ProviderFor(HeartsSoloNotifier)
const heartsSoloNotifierProvider = HeartsSoloNotifierFamily();

/// See also [HeartsSoloNotifier].
class HeartsSoloNotifierFamily extends Family<AsyncValue<HeartsGameModel?>> {
  /// See also [HeartsSoloNotifier].
  const HeartsSoloNotifierFamily();

  /// See also [HeartsSoloNotifier].
  HeartsSoloNotifierProvider call(
    String lobbyCode, {
    int? seed,
  }) {
    return HeartsSoloNotifierProvider(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  HeartsSoloNotifierProvider getProviderOverride(
    covariant HeartsSoloNotifierProvider provider,
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
  String? get name => r'heartsSoloNotifierProvider';
}

/// See also [HeartsSoloNotifier].
class HeartsSoloNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HeartsSoloNotifier, HeartsGameModel?> {
  /// See also [HeartsSoloNotifier].
  HeartsSoloNotifierProvider(
    String lobbyCode, {
    int? seed,
  }) : this._internal(
          () => HeartsSoloNotifier()
            ..lobbyCode = lobbyCode
            ..seed = seed,
          from: heartsSoloNotifierProvider,
          name: r'heartsSoloNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$heartsSoloNotifierHash,
          dependencies: HeartsSoloNotifierFamily._dependencies,
          allTransitiveDependencies:
              HeartsSoloNotifierFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
          seed: seed,
        );

  HeartsSoloNotifierProvider._internal(
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
    covariant HeartsSoloNotifier notifier,
  ) {
    return notifier.build(
      lobbyCode,
      seed: seed,
    );
  }

  @override
  Override overrideWith(HeartsSoloNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HeartsSoloNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<HeartsSoloNotifier, HeartsGameModel?>
      createElement() {
    return _HeartsSoloNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HeartsSoloNotifierProvider &&
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

mixin HeartsSoloNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<HeartsGameModel?> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;

  /// The parameter `seed` of this provider.
  int? get seed;
}

class _HeartsSoloNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HeartsSoloNotifier,
        HeartsGameModel?> with HeartsSoloNotifierRef {
  _HeartsSoloNotifierProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as HeartsSoloNotifierProvider).lobbyCode;
  @override
  int? get seed => (origin as HeartsSoloNotifierProvider).seed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
