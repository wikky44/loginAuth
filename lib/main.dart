import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/Login_Screen.dart';
import 'bloc/Auth_bloc.dart';
import 'bloc/Auth_state.dart';
void main() {
  //HttpClient().badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ));
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Handle successful login (e.g., navigate to home screen)
              print('Login success');
            } else if (state is AuthError) {
              // Display error to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return _buildLoginForm(context);
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                // Trigger login API call
                context.read<AuthBloc>().login(email, password);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

