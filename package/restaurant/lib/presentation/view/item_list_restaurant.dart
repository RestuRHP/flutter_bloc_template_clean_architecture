import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../restaurant.dart';
import 'image_clipper.dart';

class ItemListRestaurant extends StatelessWidget {
  final Restaurant? item;

  const ItemListRestaurant({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailView.routeName, arguments: item?.id);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: 100.w,
            height: kIsWeb ? 30.h : (31.w),
            padding: EdgeInsets.all(15.dp),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                      height: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(9.0.dp),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.0.dp),
                        child: ClipPath(
                          clipper: ImageClipper(),
                          child: CachedNetworkImage(
                            imageUrl: '${ApiConfig.mediumImage}${item?.pictureId}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Shimmers(
                                height: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                                width: kIsWeb ? (30.h - 30.dp) : (30.w - 30.dp),
                                borderRadius: BorderRadius.circular(9.0.dp),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5.dp,
                      bottom: 5.dp,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12.dp,
                          ),
                          TextDefault(
                            '${item?.rating}',
                            fontSize: 12.dp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.white,
                          )
                        ],
                      ),
                    )
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
                        TextDefault(
                          '${item?.name}',
                          fontSize: 14.dp,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5.dp,
                        ),
                        TextDefault(
                          '${item?.description}',
                          fontSize: 12.dp,
                          maxLine: 2,
                          textColor: AppColors.black.withAlpha(80),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.telegram,
                              color: AppColors.black.withAlpha(80),
                              size: 12.dp,
                            ),
                            SizedBox(
                              width: 5.dp,
                            ),
                            TextDefault(
                              '${item?.city}',
                              textColor: AppColors.black.withAlpha(80),
                              fontSize: 12.dp,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
