import 'package:flutter/material.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/widgets/grid_item_widgets.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: const InputDecoration(
              hintText: "Enter keywords...",
              filled: true,
              fillColor: Colors.white),
          onChanged: (value) {
            itemProvider.search(value);
          },
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: itemProvider.listSearchBarang.length,
          itemBuilder: (context, index) {
            final barang = itemProvider.listSearchBarang[index];
            return InkWell(
              splashColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                final route = MaterialPageRoute(
                  builder: (context) => FormPage(
                    itemBarang: barang,
                  ),
                );
                Navigator.push(context, route);
              },
              child: GridItemWidgets(barang: barang),
            );
          }),
    );
  }
}
