import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './login_page.dart';
import './login_presenter.dart';
import '../../../../domain/entitites/user.dart';

class LoginController extends Controller {
  final LoginPresenter _presenter;

  LoginController(this._presenter);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user = User(name: "test", address: "test",email: "test",id: 0,phoneNumber: "08", token: "test", userName: "test", imageUrl: "test");
  User? get user => _user;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  @override
  void initListeners() {
    _initObserver();
    // _getUser();
  }

  void _getUser(String username, String password) {
    _showLoading();
    _presenter.getUser(username, password);
  }


  void loginNow(String username, String password) {
    _getUser(username, password);
  }

  void _initObserver() {
    _presenter.onErrorLogin = (e) {
      _hideLoading();
    };
    _presenter.onFinishLogin = () {
      _hideLoading();
    };
    _presenter.onSuccessLogin = (User? data) {
      _user = data;
    };
  }

  void _showLoading() {
    _isLoading = true;
    refreshUI();
  }

  void _hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @override
  void onDisposed() {
    super.onDisposed();
    _usernameController.dispose();
    _passwordController.dispose();
    _presenter.dispose();
  }
}