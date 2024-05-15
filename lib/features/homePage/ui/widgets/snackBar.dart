import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


showSuccessSnackBar(BuildContext context)=>
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message:
        "Good job, your release is successful. Have a nice day",
      ),
    );

showErrorSnackBar(BuildContext context)=>
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message:
        "Something went wrong. Please check your credentials and try again",
      ),
    );