import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/popups/custom_dialog.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_image_picker.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';

import 'update_business_controller.dart';

class UpdateBusinessView extends StatelessWidget {
  final business = Get.arguments as BusinessModel;
  UpdateBusinessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBusinessController(business));

    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          title: "Update Business",
          child: GetBuilder<UpdateBusinessController>(
            id: 'UPDATE_FORM',
            builder: (cntrl) {
              return Form(
                key: cntrl.formKey,
                autovalidateMode: cntrl.autoValidate,
                child: ListView(
                  children: [
                    GetBuilder<UpdateBusinessController>(
                        id: "UPDATE_IMAGE",
                        builder: (con) {
                          return CustomImagePicker(
                            imageData: con.pickedImageData,
                            isLoading: con.isImageLoading,
                            onPicked: con.pickImage,
                            onRemoved: con.removeImage,
                            height: 150,
                            width: 150,
                          );
                        }),
                    const SizedBox(height: AppSizes.smallPadding),
                    CustomTextFormField(
                      controller: controller.nameController,
                      hintText: "Name*",
                      validator: TextValidator.nameValidator,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    // const SizedBox(height: AppSizes.smallPadding),
                    // CustomTextFormField(
                    //   controller: controller.typeController,
                    //   hintText: "Business Type",
                    //   suffixIcon: const Icon(Icons.menu),
                    //   prefixIcon: const Icon(Icons.arrow_drop_down),
                    //   keyboardType: TextInputType.text,
                    //   maxLines: null,
                    // ),
                    const SizedBox(height: AppSizes.mediumPadding),
                    CustomFilledButton(
                      text: "Update Transaction",
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.updateBusiness();
                        } else {
                          controller.updateValidationMode();
                        }
                      },
                    ),
                    const Divider(height: AppSizes.largePadding),
                    CustomFilledButton(
                      isDanger: true,
                      text: "Delete Business",
                      onPressed: () async {
                        if (await showCustomDialog(
                          context: context,
                          title: "Delete Business?",
                          subTitle:
                              "Business will be permanently removed form your account. Sure, you want to delete this business?",
                          rightButtonTitle: "Delete",
                        )) {
                          await controller.deleteBusiness();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return const CustomLoader();
      }
    });
  }
}
