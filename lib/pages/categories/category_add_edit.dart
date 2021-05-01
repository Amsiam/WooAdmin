import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooadmin/Provider/CategoryProvider.dart';
import 'package:wooadmin/Provider/Loading.dart';
import 'package:wooadmin/enums/PageType.dart';
import 'package:wooadmin/models/Category.dart';
import 'package:wooadmin/pages/Base_Page.dart';
import 'package:wooadmin/utils/FormHelper.dart';

class CategoryAddEdit extends BasePage {
  final PageType pageType;
  final Category? category;

  CategoryAddEdit({required this.pageType, this.category});

  @override
  CategoryAddEditState createState() => CategoryAddEditState();
}

class CategoryAddEditState extends BasePageState<CategoryAddEdit> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late Category category;

  final CategoryController c = Get.find();
  final LoadingController loading = Get.find();

  @override
  void initState() {
    this.title =
        this.widget.pageType == PageType.Add ? "Add Category" : "Edit Category";
    super.initState();
    if (this.widget.pageType == PageType.Edit) {
      this.category = this.widget.category!;
    } else {
      category = Category();
    }
  }

  @override
  Widget pageUi() {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              Icon(Icons.ac_unit),
              "name",
              "Category Name",
              "Category Name",
              (value) {
                if (value.isEmpty) return "Category name can't be empty";
                return null;
              },
              (val) {
                this.category.name = val;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              showPrefixIcon: false,
              borderRadius: 10,
              paddingLeft: 0,
              paddingRight: 0,
              initialValue: this.widget.pageType == PageType.Add
                  ? ""
                  : this.category.name,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              Icon(Icons.ac_unit),
              "name",
              "Category Description",
              "Category Description",
              (value) {
                return null;
              },
              (val) {
                this.category.description = val;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              showPrefixIcon: false,
              borderRadius: 10,
              paddingLeft: 0,
              paddingRight: 0,
              isMultiline: true,
              containerHeight: 200,
              initialValue: this.widget.pageType == PageType.Add
                  ? ""
                  : this.category.description,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton(
                this.widget.pageType == PageType.Add ? "Add" : "Edit",
                () async {
                  if (validateandSave()) {
                    loading.setIsApiCall(true);
                    if (this.widget.pageType == PageType.Add) {
                      await c.createCat(
                        this.category,
                        (val) {
                          loading.setIsApiCall(false);
                          if (val) {
                            Get.snackbar(
                              "WooAdmin",
                              "Category Added Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      );
                    } else {
                      await c.updateCat(
                        this.category,
                        (val) {
                          loading.setIsApiCall(false);
                          if (val) {
                            Get.snackbar(
                              "WooAdmin",
                              "Category updated Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateandSave() {
    final form = _formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
