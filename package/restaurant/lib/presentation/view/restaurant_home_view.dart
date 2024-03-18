import 'dart:developer';

import 'package:core/app/common/navigation.dart';
import 'package:core/core.dart';
import 'package:core/injection.dart' as di;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:restaurant/presentation/view/item_list_restaurant.dart';

import '../../restaurant.dart';

class RestaurantHomeView extends StatefulWidget {
  const RestaurantHomeView({super.key});

  @override
  State<RestaurantHomeView> createState() => _RestaurantHomeViewState();
}

class _RestaurantHomeViewState extends State<RestaurantHomeView> {
  final BackgroundService backgroundService = di.locator<BackgroundService>();

  // final ProgressNotification notification = ProgressNotification();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantBloc>().add(GetListRestaurantEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              // await backgroundService.callback();
              navigatorKey.currentState!.pushNamed('/restaurant_detail', arguments: 'rqdv5juczeskfw1e867');
              // for(int i=0;i<=100;i+=5){
              //   await notification.channel.invokeMethod('startTask',{'progress': i});
              //   await Future.delayed(const Duration(seconds: 1));
              //   log(i.toString());
              // }
            },
            icon: const Icon(
              Icons.notification_add,
            )),
      ]),
      body: SafeArea(
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, states) {
            final state = states.result;
            if (state?.status == StatusState.loading) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(5, (index) => isLoading()),
                ),
              );
            }
            if (state?.status == StatusState.error) {
              return Center(
                child: TextDefault('${state?.message}'),
              );
            }
            if (state?.status == StatusState.success) {
              final placeList = state?.data?.restaurants;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: List.generate(placeList?.length ?? 0, (index) {
                        return Column(
                          children: [
                            if (index == 0) Divider(color: AppColors.grey.withAlpha(60), height: 0.5),
                            ItemListRestaurant(
                              item: placeList?[index],
                            ),
                            Divider(color: AppColors.grey.withAlpha(60), height: 0.5),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 55.dp,
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget isLoading() {
    return Container(
      width: 100.w,
      height: kIsWeb ? 30.h : 30.w,
      padding: EdgeInsets.all(15.dp),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Shimmers(
                width: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                height: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                borderRadius: BorderRadius.circular(9.0.dp),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.dp, 0, 0, 0),
            child: SizedBox(
              height: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
              width: kIsWeb ? (100.w - 30.h - 15.dp) : (70.w - 15.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmers(height: 14.dp, width: 25.w),
                  SizedBox(height: 5.dp),
                  Shimmers(height: 26.dp, width: 70.w - 15.dp),
                  const Spacer(),
                  Shimmers(height: 14.dp, width: 25.w)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
