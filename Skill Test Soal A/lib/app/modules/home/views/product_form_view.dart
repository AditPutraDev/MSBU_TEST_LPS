import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory/app/modules/home/controllers/home_controller.dart';
import 'package:inventory/app/widgets/main_textfield.dart';

class ProductFormView extends GetView<HomeController> {
  const ProductFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${controller.title} Produk'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MainTextField(
                  controller: controller.tcName,
                  hintText: 'Nama Barang',
                ),
                MainTextField(
                  controller: controller.tcCode,
                  hintText: 'Kode Barang',
                ),
                MainTextField(
                  controller: controller.tcQTY,
                  hintText: 'Jumlah Barang',
                  type: TextInputType.number,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45)),
              onPressed: () => controller.status == StatusForm.add
                  ? controller.addProduct()
                  : controller.updateProduct(),
              icon: Icon(
                  controller.status == StatusForm.add ? Icons.add : Icons.edit),
              label: Text('${controller.title} Produk'),
            ),
          )
        ],
      ),
    );
  }
}
