import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooadmin/Provider/CategoryProvider.dart';
import 'package:wooadmin/Provider/Loading.dart';
import 'package:wooadmin/Provider/SearchProvider.dart';
import 'package:wooadmin/enums/PageType.dart';
import 'package:wooadmin/models/Category.dart';
import 'package:wooadmin/pages/Base_Page.dart';
import 'package:wooadmin/pages/categories/category_add_edit.dart';
import 'package:wooadmin/utils/ListHelper.dart';
import 'package:wooadmin/utils/SearchHelper.dart';

class CategoryList extends BasePage {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends BasePageState<CategoryList> {
  final CategoryController c = Get.find();
  final LoadingController loading = Get.find();
  final SearchController searchController = Get.find();
  @override
  void initState() {
    super.initState();
    this.title = "Category List";
  }

  @override
  Widget pageUi() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SearchUtils.searchBar(
                  context,
                  "strCategory",
                  "Search Category",
                  "Add Category",
                  (val) {
                    SortModel sortModel = searchController.sortModel!;
                    c.resetSt();
                    c.fetchCategory(
                      sortBy: sortModel.currentcolumnName,
                      sortOrder: sortModel.sortAscending! ? "asc" : "desc",
                      strSearch: val,
                    );
                  },
                  () {
                    Get.to(() => CategoryAddEdit(pageType: PageType.Add));
                  },
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            GetX<CategoryController>(
              // no need to initialize Controller ever again, just mention the type
              builder: (value) {
                if (value.totalRecord > 0) {
                  return ListUtils.buildDataTable(
                    context,
                    ["Name", "Descriptions", ""],
                    ["name", "description", ""],
                    searchController.sortModel!.sortAscending!,
                    searchController.sortModel!.columnIndex!,
                    value.getCateory,
                    (Category edit) => {
                      Get.to(
                        () => CategoryAddEdit(
                          pageType: PageType.Edit,
                          category: edit,
                        ),
                      )
                    },
                    (Category delete) async {
                      loading.setIsApiCall(true);
                      await c.delCat(
                        delete,
                        (val) {
                          loading.setIsApiCall(false);
                          if (val) {
                            Get.snackbar(
                              "WooAdmin",
                              "Category Deleted Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      );
                    },
                    headingRowColor: Theme.of(context).primaryColor,
                    onSort: (columnIndex, columnName, sortAscending) {
                      searchController.setSort(
                        columnIndex,
                        columnName,
                        sortAscending,
                      );
                      c.resetSt();
                      c.fetchCategory(
                        sortBy: columnName,
                        sortOrder: sortAscending ? "asc" : "desc",
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
