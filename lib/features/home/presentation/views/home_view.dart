import 'package:flutter/material.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';

import '../../../../core/cache/local_cache.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthResponse? user;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final cachedUser = await serviceLocator<LocalCache>().getData(key: 'user');
    setState(() {
      user = AuthResponse.fromJson(cachedUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?.user?.name ?? 'bl',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('Home View'),
      ),
    );
  }
}
