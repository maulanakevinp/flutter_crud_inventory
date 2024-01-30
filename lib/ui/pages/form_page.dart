import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/widgets/custom_textfield_widgets.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final Barang? itemBarang;
  const FormPage({super.key, this.itemBarang});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _urlController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController =
        TextEditingController(text: widget.itemBarang?.barangNama ?? "");
    _amountController =
        TextEditingController(text: widget.itemBarang?.barangJumlah ?? "");
    _urlController =
        TextEditingController(text: widget.itemBarang?.barangGambar ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    Widget nameFields() {
      return CustomTextFieldWidgets(
        controller: _nameController,
        labelText: "Item Name",
      );
    }

    Widget amountFields() {
      return CustomTextFieldWidgets(
        controller: _amountController,
        keyboardType: TextInputType.number,
        labelText: "Item Count",
      );
    }

    Widget urlFields() {
      return CustomTextFieldWidgets(
        controller: _urlController,
        labelText: "URL item",
      );
    }

    Widget buttonSave() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();
            if (isValid) {
              final name = _nameController.text;
              final amount = _amountController.text;
              final urlImage = _urlController.text;
              if (widget.itemBarang != null) {
                await itemProvider.updateBarang(widget.itemBarang!.barangId! ,name, amount, urlImage);
              } else {
                await itemProvider.insertBarang(name, amount, urlImage);
              }
              final isSuccess = itemProvider.responseBarang.sukses;
              if (isSuccess) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                Fluttertoast.showToast(msg: itemProvider.responseBarang.pesan);
              } else {
                Fluttertoast.showToast(msg: itemProvider.responseBarang.pesan);
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            widget.itemBarang != null ? 'UPDATE' : 'SAVE',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemBarang != null ? "Update Item" : "Add Item"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                nameFields(),
                amountFields(),
                urlFields(),
                buttonSave()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
