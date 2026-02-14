import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OnboardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A46D8), Color(0xFF0B1635)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.auto_fix_high_rounded, size: 72, color: Colors.white),
              SizedBox(height: 12),
              Text('Memoria', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Text('لحظاتك تستحق الوضوح', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
