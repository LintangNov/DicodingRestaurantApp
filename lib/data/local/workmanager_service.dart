import 'dart:math';
import 'package:workmanager/workmanager.dart';
import '../api/api_service.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final apiService = ApiService();
      final result = await apiService.getRestaurantList();
      final restaurants = result.restaurants;

      if (restaurants.isNotEmpty) {
        final randomIndex = Random().nextInt(restaurants.length);
        final randomRestaurant = restaurants[randomIndex];

        final notificationService = NotificationService();
        await notificationService.init();
        await notificationService.showNotification(
          1,
          'Time to lunch! 🍽️',
          'Today recommendation: ${randomRestaurant.name} at ${randomRestaurant.city}. Check it now!',
          randomRestaurant.id,
        );
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
    : _workmanager = workmanager ?? Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher);
  }

  Future<void> scheduleDailyReminder() async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, 11, 0);

    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    final initialDelay = scheduledTime.difference(now);

    await _workmanager.registerPeriodicTask(
      'daily_reminder_task',
      'daily_reminder_task',
      frequency: const Duration(hours: 24),
      initialDelay: initialDelay,
      constraints: Constraints(networkType: NetworkType.connected),
    );

  }

  Future<void> cancelDailyReminder() async {
    await _workmanager.cancelByUniqueName('daily_reminder_task');
  }
}
