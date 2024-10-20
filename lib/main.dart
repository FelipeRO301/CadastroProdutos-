import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produtos_mobile_2/pages/home_screen.dart';
import 'package:produtos_mobile_2/pages/login_screens.dart';
import 'package:produtos_mobile_2/pages/criarconta_screens.dart';
import 'package:produtos_mobile_2/pages/fornecedor_dashboard.dart';
import 'package:produtos_mobile_2/pages/produto_dashboard.dart';
import 'package:produtos_mobile_2/pages/lancamento_dashboard.dart';
import 'package:produtos_mobile_2/pages/historico_lancamento.dart';
import 'package:produtos_mobile_2/pages/gestor_dashboard.dart';

void main() {
  runApp(const ProdutosApp());
}

class ProdutosApp extends StatelessWidget {
  const ProdutosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cadastro de Produtos",
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/criarconta',
          page: () => CriarContaScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: '/fornecedor_dashboard',
          page: () => FornecedorDashboard(),
        ),
        GetPage(
          name: '/produto_dashboard',
          page: () => ProdutoDashboard(),
        ),
        GetPage(
          name: '/lancamento_dashboard',
          page: () => LancamentoDashboard(),
        ),
        GetPage(
          name: '/historico_lancamento',
          page: () => HistoricoLancamento(),
        ),
        GetPage(
          name: '/gestor_dashboard',
          page: () => const GestorDashboard(),
        ),
      ],
    );
  }
}
