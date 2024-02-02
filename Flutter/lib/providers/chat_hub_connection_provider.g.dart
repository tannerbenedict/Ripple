// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_hub_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatHubConnectionHash() => r'109b401254683668e301a200268cd3406ea1ee91';

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

abstract class _$ChatHubConnection
    extends BuildlessAutoDisposeStreamNotifier<List<ChatMessageForView>> {
  late final String lobbyCode;

  Stream<List<ChatMessageForView>> build(
    String lobbyCode,
  );
}

/// See also [ChatHubConnection].
@ProviderFor(ChatHubConnection)
const chatHubConnectionProvider = ChatHubConnectionFamily();

/// See also [ChatHubConnection].
class ChatHubConnectionFamily
    extends Family<AsyncValue<List<ChatMessageForView>>> {
  /// See also [ChatHubConnection].
  const ChatHubConnectionFamily();

  /// See also [ChatHubConnection].
  ChatHubConnectionProvider call(
    String lobbyCode,
  ) {
    return ChatHubConnectionProvider(
      lobbyCode,
    );
  }

  @override
  ChatHubConnectionProvider getProviderOverride(
    covariant ChatHubConnectionProvider provider,
  ) {
    return call(
      provider.lobbyCode,
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
  String? get name => r'chatHubConnectionProvider';
}

/// See also [ChatHubConnection].
class ChatHubConnectionProvider extends AutoDisposeStreamNotifierProviderImpl<
    ChatHubConnection, List<ChatMessageForView>> {
  /// See also [ChatHubConnection].
  ChatHubConnectionProvider(
    String lobbyCode,
  ) : this._internal(
          () => ChatHubConnection()..lobbyCode = lobbyCode,
          from: chatHubConnectionProvider,
          name: r'chatHubConnectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatHubConnectionHash,
          dependencies: ChatHubConnectionFamily._dependencies,
          allTransitiveDependencies:
              ChatHubConnectionFamily._allTransitiveDependencies,
          lobbyCode: lobbyCode,
        );

  ChatHubConnectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyCode,
  }) : super.internal();

  final String lobbyCode;

  @override
  Stream<List<ChatMessageForView>> runNotifierBuild(
    covariant ChatHubConnection notifier,
  ) {
    return notifier.build(
      lobbyCode,
    );
  }

  @override
  Override overrideWith(ChatHubConnection Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatHubConnectionProvider._internal(
        () => create()..lobbyCode = lobbyCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyCode: lobbyCode,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<ChatHubConnection,
      List<ChatMessageForView>> createElement() {
    return _ChatHubConnectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatHubConnectionProvider && other.lobbyCode == lobbyCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatHubConnectionRef
    on AutoDisposeStreamNotifierProviderRef<List<ChatMessageForView>> {
  /// The parameter `lobbyCode` of this provider.
  String get lobbyCode;
}

class _ChatHubConnectionProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ChatHubConnection,
        List<ChatMessageForView>> with ChatHubConnectionRef {
  _ChatHubConnectionProviderElement(super.provider);

  @override
  String get lobbyCode => (origin as ChatHubConnectionProvider).lobbyCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
