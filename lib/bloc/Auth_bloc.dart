
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse('https://respos.menuclub.uk/api/loginApp/'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['token']['access'];
        final refreshToken = data['token']['refresh'];

        // Store tokens securely (using shared preferences in this case)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);

        final userData = data['user_data'];
        emit(AuthSuccess(userData));
      } else if (response.statusCode == 401) {
        emit(AuthError('Invalid username or password'));
      } else {
        emit(AuthError('Internal server error'));
      }
    } catch (e) {
      print( e.toString());
      emit(AuthError('${e.toString()}'));
    }
  }
}
