import '../api/api.dart';

class MovieDBRepository {
  MovieDBRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;
}
