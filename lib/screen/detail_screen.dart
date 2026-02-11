import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/widget/error_state_widget.dart';
import '../provider/restaurant_detail_provider.dart';
import '../static/result_state.dart';
import 'package:provider/provider.dart';
import 'detail_screen_widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.restaurantId});

  static const routeName = '/detail_screen';
  final String restaurantId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState(){
    super.initState();
    Future.microtask((){
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(widget.restaurantId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child){
          final state = provider.state;

          if(state is ResultStateLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is ResultStateSuccess){
            return buildDetailContent(context, (state as ResultStateSuccess).data.restaurant);
          } else if (state is ResultStateError){
            return ErrorStateWidget(
              message: (state as ResultStateError).error,
              onRetry: (){
                context.read<RestaurantDetailProvider>().fetchRestaurantDetail(widget.restaurantId);
              },
            );
          } else {
            return const Center(child: Text(''),);
          }
        },
      )
    );
  }


}
