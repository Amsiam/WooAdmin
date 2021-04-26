import 'package:flutter/material.dart';
import 'package:wooadmin/utils/FormHelper.dart';

class SearchUtils {
  static Widget searchBar(
    BuildContext context,
    String key,
    String placeHolder,
    String addButtonLabel,
    Function searchBtnTab,
    Function addButton,
  ) {
    String val = "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FormHelper.inputFieldWidget(
          context,
          Icon(Icons.web),
          key,
          placeHolder,
          () {},
          () {},
          onChange: (changeVal) => {val = changeVal},
          showPrefixIcon: false,
          borderColor: Theme.of(context).primaryColor,
          borderFocusColor: Theme.of(context).primaryColor,
          containerHeight: 50,
          containerWidth: 250,
          paddingLeft: 0,
          borderRadius: 10,
          suffixIcon: Container(
            child: GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                return searchBtnTab(val);
              },
            ),
          ),
        ),
        FormHelper.submitButton(
          addButtonLabel,
          () {
            return addButton();
          },
          borderRadius: 10,
          width: 100,
          fontSize: 12,
        ),
      ],
    );
  }
}
