import 'package:flutter/material.dart';
import 'package:inventory_app/helper/shared_pref.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/detail_page.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/pages/login_page.dart';
import 'package:inventory_app/ui/pages/search_page.dart';
import 'package:inventory_app/ui/widgets/grid_item_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final sharedPref = SharedPref();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory App'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
            icon: const Icon(Icons.search)
          ),
          IconButton(
            onPressed: () async {
              await sharedPref.remove('login');
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
            },
            icon: const Icon(Icons.exit_to_app)
          ),
        ],
      ),
      body: Center(
        child: itemProvider.isFetching 
        ? const CircularProgressIndicator() 
        : GridView.builder(
          itemCount: itemProvider.listBarang.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              final barang = itemProvider.listBarang[index];
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: barang.barangId!)));
            },
            child: GridItemWidgets(barang: itemProvider.listBarang[index])
          )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(key: key))),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}