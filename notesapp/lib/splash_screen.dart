import 'package:flutter/material.dart';
import 'dart:async';
import 'package:notesapp/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D0B14),
              Color(0xFF1A1028),
              Color(0xFF120D22),
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Logo container
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [Color(0xFF7C55E0), Color(0xFF4A2FA0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF7C55E0).withOpacity(0.5),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(Icons.auto_stories_rounded,
                    size: 44, color: Colors.white),
              ),
              SizedBox(height: 24),
              Text(
                "Nota",
                style: TextStyle(
                  color: Color(0xFFE9D5FF),
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "YOUR PERSONAL JOURNAL",
                style: TextStyle(
                  color: Color(0xFF6D5A8A),
                  fontSize: 11,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 40),
                child: LinearProgressIndicator(
                  color: Color(0xFF7C55E0),
                  backgroundColor: Color(0xFF2A2040),
                  minHeight: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}