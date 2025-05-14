
import 'package:flutter/material.dart';
import 'package:jobs_applications_app/features/job_offer/presentation/widgets/shared/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('NewFormulariesButtonScreen'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}