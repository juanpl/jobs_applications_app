

import 'package:go_router/go_router.dart';
import 'package:jobs_applications_app/features/job_offer/presentation/screens/home_screen/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home_screen',
  
  routes: [
    GoRoute(
      path: '/home_screen',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    )
  ]

);