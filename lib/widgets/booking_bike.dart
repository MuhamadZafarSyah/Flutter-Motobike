import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/models/bike.dart';

class BookingBike extends StatefulWidget {
  const BookingBike({super.key, required this.bike});

  final Bike bike;
  @override
  State<BookingBike> createState() => _BookingBikeState();
}

class _BookingBikeState extends State<BookingBike> {
  @override
  Widget build(BuildContext context) {
    final bike = widget.bike;
    return Container(
      height: 98,
      width: 345,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            bike.image,
            height: 70,
            width: 90,
            fit: BoxFit.contain,
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bike.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623),
                  ),
                ),
                const Gap(4),
                Text(
                  bike.category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838384),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                bike.rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff070623),
                ),
              ),
              const Gap(4),
              Icon(Icons.star, size: 20, color: const Color(0xffFFBC1C)),
            ],
          ),
        ],
      ),
    );
  }

  // Widget buildBookingBike(Bike bike) {
  //   // final String imageStr = bike.image.trim();
  //   // final bool isNetwork = imageStr.startsWith('http');

  //   return Container(
  //     height: 98,
  //     width: 345,
  //     margin: const EdgeInsets.symmetric(horizontal: 24),
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Row(
  //       children: [
  //         ExtendedImage.network(
  //           bike.image,
  //           height: 70,
  //           width: 90,
  //           fit: BoxFit.contain,
  //         ),
  //         const Gap(10),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 bike.name,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                   color: Color(0xff070623),
  //                 ),
  //               ),
  //               const Gap(4),
  //               Text(
  //                 bike.category,
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                   color: Color(0xff838384),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const Gap(10),
  //         Row(
  //           children: [
  //             Text(
  //               bike.rating.toString(),
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w800,
  //                 color: Color(0xff070623),
  //               ),
  //             ),
  //             const Gap(4),
  //             Icon(Icons.star, size: 20, color: const Color(0xffFFBC1C)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
