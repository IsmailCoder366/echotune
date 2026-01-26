import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart'; // Needed for TextEditingController
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../data/repositories/auth_repository.dart';
import '../../../../core/utils/app_validators.dart';

class UserInfoController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  // 1. Loading states
  var isSaving = false.obs;
  var isUploadingImage = false.obs;

  // 2. TEXT CONTROLLERS (The "Leashes" for your UI boxes)
  final nameController = TextEditingController();
  final emailController = TextEditingController(); // Usually read-only

  // Password Controllers
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Bank Account Controllers
  final accountController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();

  // 3. Image Data
  var profileImageUrl = "".obs;
  File? selectedImage;

  // --- CLOUDINARY CREDENTIALS ---
  final String cloudName = "your_cloud_name";
  final String uploadPreset = "your_unsigned_preset";

  /// JOB 1: Pick & Upload Image (Same as before)
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      uploadToCloudinary();
    }
  }

  Future<void> uploadToCloudinary() async {
    if (selectedImage == null) return;
    isUploadingImage.value = true;
    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");
      var request = http.MultipartRequest("POST", url);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', selectedImage!.path));

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);

      if (response.statusCode == 200) {
        profileImageUrl.value = jsonResponse['secure_url'];
        AppValidators.showMessage("Image uploaded!", isError: false);
      }
    } catch (e) {
      AppValidators.showMessage("Image upload failed.");
    } finally {
      isUploadingImage.value = false;
    }
  }

  /// JOB 2: SAVE FULL PROFILE (The Mega Function)
  Future<void> saveFullProfile() async {
    // Basic Validation
    if (nameController.text.isEmpty) {
      AppValidators.showMessage("Name cannot be empty");
      return;
    }

    // Bank Account Validation
    if (accountController.text != confirmAccountController.text) {
      AppValidators.showMessage("Account numbers do not match!");
      return;
    }

    isSaving.value = true;
    try {
      String uid = _authRepo.currentUser!.uid;

      // 1. Update Firestore (Name, Image, Bank Info)
      await _authRepo.updateUserProfile(
        uid: uid,
        newName: nameController.text,
        imageUrl: profileImageUrl.value,
        accountNumber: accountController.text,
        ifscCode: ifscController.text,
      );

      // 2. Handle Password Change (If user typed something in New Password)
      if (newPasswordController.text.isNotEmpty) {
        if (newPasswordController.text == confirmPasswordController.text) {
          await _authRepo.changePassword(newPasswordController.text);
          AppValidators.showMessage("Password updated!", isError: false);
        } else {
          AppValidators.showMessage("Passwords do not match!");
        }
      }

      AppValidators.showMessage("Profile updated successfully!", isError: false);
    } catch (e) {
      AppValidators.showMessage("Update failed.");
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up controllers when screen is closed
    nameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    accountController.dispose();
    confirmAccountController.dispose();
    ifscController.dispose();
    super.onClose();
  }
}