import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_app/provider/detail_item_provider.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => DetailItemProvider(id),
      child: Consumer<DetailItemProvider>(
          builder: (context, detailItemProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: detailItemProvider.isFetching ? const Text('Loading ...') : Text(detailItemProvider.barang.barangNama!),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormPage(itemBarang: detailItemProvider.barang))),
                  icon: const Icon(Icons.edit)),
              IconButton(
                onPressed: () async {
                  await itemProvider.deleteBarang(detailItemProvider.barang.barangId!);
                  final isSuccess = itemProvider.responseBarang.sukses;
                  if (isSuccess) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: itemProvider.responseBarang.pesan);
                  } else {
                    Fluttertoast.showToast(msg: itemProvider.responseBarang.pesan);
                  }
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          body: detailItemProvider.isFetching
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Hero(
                            tag: detailItemProvider.barang.barangId!,
                            child: Material(
                              child: Image.network(
                                  detailItemProvider.barang.barangGambar!),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("Jumlah: ${detailItemProvider.barang.barangJumlah!}"),
                        ),
                      )
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
