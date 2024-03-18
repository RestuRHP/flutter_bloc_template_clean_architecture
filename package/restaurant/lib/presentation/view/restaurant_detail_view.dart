import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:restaurant/restaurant.dart';

class RestaurantDetailView extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String? id;
  const RestaurantDetailView({super.key, this.id});


  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  String id = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      id = ModalRoute.of(context)?.settings.arguments as String;
      if(id.isNotEmpty){
        context.read<DetailRestaurantBloc>().add(GetDetailRestaurantEvent(id));
      }else{
        context.read<DetailRestaurantBloc>().add(GetDetailRestaurantEvent(widget.id??''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
            },
            icon: const Icon(
              Icons.notification_add,
            )),
      ]),
      body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
        builder: (context, states) {
          final state = states.result;
          if(state?.status == StatusState.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state?.status == StatusState.success) {
            final data = state?.data?.restaurant;
            return TextDefault(data?.name??'');
          }

          return const SizedBox();
        },
      ),
    );
  }
}
