import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/static/result_state.dart';

class MockApiService extends Mock implements ApiService {}

void main(){
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp((){
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group('RestaurantListProvider Test', () {
    test('should return ResultStateInitial when provider is initialized.',(){
      expect(provider.state, isA<ResultStateInitial>);
    });

    test('should return ResultStateSuccess containing restaurant list when API successfully fetch data', () async {
      final dummyRestaurant = Restaurant(
        id: '1', name: 'Joko resto', description: 'desc', pictureId: '1', city: 'jogja', rating: 4.8
      );
      final dummyResponse = RestaurantListResponse(error: false, restaurants: [dummyRestaurant]);
      
      when(() => mockApiService.getRestaurantList()).thenAnswer((_) async => dummyResponse);

      await provider.fetchRestaurantList();

      expect(provider.state, isA<ResultStateSuccess<RestaurantListResponse>>());
    });

    test('should return ResultStateError when API fails to fetch data.', () async {
      when(() => mockApiService.getRestaurantList()).thenThrow(Exception('Failed to load internet'));

      await provider.fetchRestaurantList();

      expect(provider.state, isA<ResultStateError<RestaurantListResponse>>());
    });

  });
}