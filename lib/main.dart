import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/models/bike.dart';
import 'package:main/pages/booking_page.dart';
import 'package:main/pages/chatting_page.dart';
import 'package:main/pages/checkout_page.dart';
import 'package:main/pages/detail_page.dart';
import 'package:main/pages/discover_page.dart';
import 'package:main/pages/pin_page.dart';
import 'package:main/pages/sign_in_page.dart';
import 'package:main/pages/sign_up_page.dart';
import 'package:main/pages/splash_screen.dart';
import 'package:main/pages/success_boking_page.dart';
import 'firebase_options.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: 'djxobtcx0',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // JADI SEMUA WARNA BACKGROUND NYA LANGSUNG WARNA DI BAWAH INI
        scaffoldBackgroundColor: const Color(0xffEFEFF0),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        // BERFUNGSI UNTUK MENADAPATKAN DATA DI SESSION
        future: DSession.getUser(),
        builder: (context, snapshot) {
          // MELAKUKAN CONDITIONAL RENDERING JIKA STATE LOADING MAKA MUNCULKAN LOADING INDICATOR
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // DAN JIKA DATA NULL HARUSNYA BISA REDIRECT OR SOMETHING
          if (snapshot.data == null) return const SplashScreen();

          // JIKA SEMUA AMAN MAKA RENDER WIDGET NYA
          return const DiscoverPage();
        },
      ),

      // DEKLARATIF ROUTING
      routes: {
        '/discover': (context) => const DiscoverPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/sign-in': (context) => const SignInPage(),
        '/detail': (context) {
          String bikeId = ModalRoute.of(context)!.settings.arguments as String;
          return DetailPage(bikeId: bikeId);
        },
        '/booking': (context) {
          // NGIRIM DATA OBJECT BIKE NYA
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return BookingPage(bike: bike);
        },
        '/checkout': (context) {
          // MAIN IDEA: GROUPING DATA NYA MENJADI OBJECT BARU
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          String startDate = data['startDate'];
          String endDate = data['endDate'];
          Bike bike = data['bike'];
          return CheckoutPage(
            bike: bike,
            startDate: startDate,
            endDate: endDate,
          );
        },
        '/pin': (context) {
          // NGIRIM DATA OBJECT BIKE NYA
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return PinPage(bike: bike);
        },
        '/success-booking': (context) {
          // NGIRIM DATA OBJECT BIKE NYA
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return SuccessBokingPage(bike: bike);
        },
        '/chatting': (context) {
          // MAIN IDEA: GROUPING DATA NYA MENJADI OBJECT BARU
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          String uid = data['uid'];
          String userName = data['userName'];
          return ChattingPage(uid: uid, userName: userName);
        },
      },
    );
  }
}
