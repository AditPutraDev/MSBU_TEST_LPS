import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory/app/core/utils/date_converter.dart';
import 'package:inventory/app/routes/app_pages.dart';
import 'package:inventory/app/widgets/main_textfield.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            MainTextField(
              textInputAction: TextInputAction.search,
              controller: controller.tcSearch,
              hintText: 'Cari nama barang',
              onChanged: (p0) {
                if (p0.isNotEmpty) {
                  controller.readProduct(name: p0);
                }
              },
              onEditingComplete: () {
                if (controller.tcSearch.text.isNotEmpty) {
                  controller.readProduct(name: controller.tcSearch.text);
                }
              },
            ),
            if (controller.products.isEmpty)
              Center(
                  child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Icon(Icons.info_outline_rounded),
                  ),
                  Text('Data tidak ditemukan'),
                ],
              )),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        color: Color(0x26234395),
                      ),
                      BoxShadow(
                        offset: Offset(
                            -const Offset(5, 5).dx, -const Offset(5, 5).dx),
                        blurRadius: 10.0,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${convertDate(product.tanggal!)} ',
                        ),
                      ),
                      Text(
                        product.kodeBarang.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          '${product.namaBarang.capitalize}',
                        ),
                      ),
                      Text(
                        'Jumlah ${product.jumlahBarang}',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.deleteProduct(product.id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.selectProduct(product);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          controller.title = 'Tambah';
          controller.status = StatusForm.add;
          controller.clearTextField();
          Get.toNamed(Routes.PRODUCT_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
