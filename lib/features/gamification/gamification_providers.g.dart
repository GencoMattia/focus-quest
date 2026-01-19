// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationServiceHash() =>
    r'0618ec86caed8555397546efad4b84a1ac7950d9';

/// See also [gamificationService].
@ProviderFor(gamificationService)
final gamificationServiceProvider =
    AutoDisposeProvider<GamificationService>.internal(
  gamificationService,
  name: r'gamificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gamificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GamificationServiceRef = AutoDisposeProviderRef<GamificationService>;
String _$currentStreakHash() => r'43252f3316e530945f9e898b9eb39e055a59366f';

/// See also [currentStreak].
@ProviderFor(currentStreak)
final currentStreakProvider = AutoDisposeStreamProvider<int>.internal(
  currentStreak,
  name: r'currentStreakProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentStreakHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentStreakRef = AutoDisposeStreamProviderRef<int>;
String _$earnedBadgesHash() => r'e60fa4c639d68c98c6d343135953b9920e5aa5d1';

/// See also [earnedBadges].
@ProviderFor(earnedBadges)
final earnedBadgesProvider = AutoDisposeStreamProvider<List<String>>.internal(
  earnedBadges,
  name: r'earnedBadgesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$earnedBadgesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EarnedBadgesRef = AutoDisposeStreamProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
