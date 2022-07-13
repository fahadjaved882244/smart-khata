import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/business/add_business/add_business_controller.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_image_picker.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/services/basic/text_validator.dart';
import 'package:khata/themes/app_sizes.dart';

class AddBusinessView extends GetView<AddBusinessController> {
  const AddBusinessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!controller.isLoading) {
          return BaseScaffold(
            title: "Add New Business",
            child: GetBuilder<AddBusinessController>(
                id: 'UPDATE_FORM',
                builder: (cntrl) {
                  return Form(
                    key: cntrl.formKey,
                    autovalidateMode: cntrl.autoValidate,
                    child: ListView(
                      children: [
                        GetBuilder<AddBusinessController>(
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
                        //   prefixIcon: const Icon(Icons.menu),
                        //   suffixIcon: const Icon(Icons.arrow_drop_down),
                        // ),
                        const SizedBox(height: AppSizes.mediumPadding),
                        CustomFilledButton(
                          text: "Add Business",
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.addBusiness();
                            } else {
                              controller.updateValidationMode();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }),
          );
        } else {
          return const CustomLoader();
        }
      },
    );
  }
}
