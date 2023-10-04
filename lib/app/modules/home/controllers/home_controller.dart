import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventory/app/data/models/product_model.dart';
import 'package:inventory/app/routes/app_pages.dart';
import 'package:inventory/app/widgets/main_snackbar.dart';

import '../../../data/datasource/local/datasource_product.dart';

enum StatusForm { add, update }

class HomeController extends GetxController {
  var products = <Product>[].obs;
  var product = Product().obs;
  var tcName = TextEditingController();
  var tcQTY = TextEditingController();
  var tcCode = TextEditingController();
  var tcSearch = TextEditingController();
  var status = StatusForm.add;
  var title = 'Tambah';

  DatasourceProduct datasourceProduct = DatasourceProduct.instance;

  @override
  void onInit() {
    readProduct();
    tcSearch.addListener(() {
      if (tcSearch.text.isEmpty) {
        readProduct();
      }
    });
    super.onInit();
  }

  Future<void> addProduct() async {
    if (tcName.text.isEmpty || tcCode.text.isEmpty || tcQTY.text.isEmpty) {
      MainSnackBar.handleSnackBar('Semua data wajib diisi');
    } else {
      try {
        await datasourceProduct.create(
          Product(
            namaBarang: tcName.text,
            kodeBarang: tcCode.text,
            jumlahBarang: int.parse(tcQTY.text),
          ),
        );
      } finally {
        readProduct();
        clearTextField();
        Get.back();
      }
    }
  }

  Future<void> readProduct({String? name}) async {
    products.clear();
    var data = await datasourceProduct.read(name: name);
    products.addAll(data);
  }

  Future<void> deleteProduct(int id) async {
    try {
      await datasourceProduct.delete(id);
    } finally {
      readProduct();
    }
  }

  void updateProduct() async {
    try {
      product.value.namaBarang = tcName.text;
      product.value.kodeBarang = tcCode.text;
      product.value.jumlahBarang = int.tryParse(tcQTY.text) ?? 0;
      await datasourceProduct.update(product.value);
    } finally {
      readProduct(name: tcSearch.text);
      Get.back();
    }
  }

  void selectProduct(Product item) {
    status = StatusForm.update;
    product(item);
    tcName.text = item.namaBarang;
    tcCode.text = item.kodeBarang;
    tcQTY.text = item.jumlahBarang.toString();
    title = 'Ubah';
    FocusManager.instance.primaryFocus?.unfocus();
    Get.toNamed(Routes.PRODUCT_FORM);
  }

  void clearTextField() {
    tcCode.clear();
    tcName.clear();
    tcQTY.clear();
    tcSearch.clear();
  }
}
