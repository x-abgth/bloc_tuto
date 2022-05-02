import 'package:bloc_tuto/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:bloc_tuto/presentation/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/blocs/api_bloc/api_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.power_rounded))
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFCCCCCC),
                child: Text(
                  user.email ?? "",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: BlocBuilder<ApiBloc, ApiState>(
                  builder: (context, state) {
                    if (state is ApiLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ApiLoaded) {
                      return ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(state.posts[index].id.toString()),
                              title: Text(state.posts[index].title),
                              subtitle: Text(state.posts[index].body),
                            );
                          });
                    }
                    if (state is ApiErrors) {
                      return Center(
                        child: Text(state.errorMsg),
                      );
                    }
                    return Center(
                      child: ElevatedButton(
                        child: const Text("GET DATA"),
                        onPressed: () =>
                            context.read<ApiBloc>().add(LoadData()),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
