import 'package:equatable/equatable.dart';

class LocationState extends Equatable {
  final bool isInitial;
  final bool isLoading;
  final bool isGranted;
  final bool isDenied;
  final bool isPermanentlyDenied;
  final bool isServiceDisabled;
  final bool isFetched;
  final bool isError;
  final String? errorMessage;

  const LocationState({
    this.isInitial = false,
    this.isLoading = false,
    this.isGranted = false,
    this.isDenied = false,
    this.isPermanentlyDenied = false,
    this.isServiceDisabled = false,
    this.isFetched = false,
    this.isError = false,
    this.errorMessage,
  });

  factory LocationState.initial() => const LocationState(isInitial: true);

  LocationState copyWith({
    bool? isInitial,
    bool? isLoading,
    bool? isGranted,
    bool? isDenied,
    bool? isPermanentlyDenied,
    bool? isServiceDisabled,
    bool? isFetched,
    bool? isError,
    String? errorMessage,
  }) {
    return LocationState(
      isInitial: isInitial ?? this.isInitial,
      isLoading: isLoading ?? this.isLoading,
      isGranted: isGranted ?? this.isGranted,
      isDenied: isDenied ?? this.isDenied,
      isPermanentlyDenied: isPermanentlyDenied ?? this.isPermanentlyDenied,
      isServiceDisabled: isServiceDisabled ?? this.isServiceDisabled,
      isFetched: isFetched ?? this.isFetched,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isInitial,
    isLoading,
    isGranted,
    isDenied,
    isPermanentlyDenied,
    isServiceDisabled,
    isFetched,
    isError,
    errorMessage,
  ];
}
