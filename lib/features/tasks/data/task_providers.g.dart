// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'230c03ec26503dd5bd55ca0d021406cf9c090467';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = Provider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = ProviderRef<TaskRepository>;
String _$quickStartServiceHash() => r'b47def8aff033e630243c84f9c1f81bdfd023b2e';

/// See also [quickStartService].
@ProviderFor(quickStartService)
final quickStartServiceProvider =
    AutoDisposeProvider<QuickStartService>.internal(
  quickStartService,
  name: r'quickStartServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickStartServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickStartServiceRef = AutoDisposeProviderRef<QuickStartService>;
String _$taskListHash() => r'c778a18619805c842bd5b5b89e6c490866f96422';

/// See also [taskList].
@ProviderFor(taskList)
final taskListProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  taskList,
  name: r'taskListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskListRef = AutoDisposeStreamProviderRef<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
