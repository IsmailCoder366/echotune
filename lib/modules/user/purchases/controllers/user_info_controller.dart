import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../data/repositories/auth_repository.dart';
import '../../../../core/utils/app_validators.dart';

class UserInfoController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  var isSaving = false.obs;
  var isUploadingImage = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final accountController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();

  var profileImageUrl = "".obs;
  File? selectedImage;

  final String cloudName = "dezkkfpex";
  final String uploadPreset = "profile_image";

  @override
  void onInit() {
    super.onInit();
    // 1. FETCH DATA AUTOMATICALLY WHEN OPENED
    fetchUserData();
  }

  /// JOB 0: Pull existing data from Firestore
  Future<void> fetchUserData() async {
    try {
      String uid = _authRepo.currentUser!.uid;
      var data = await _authRepo.getUserData(uid);

      if (data != null) {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        accountController.text = data['accountNumber'] ?? '';
        confirmAccountController.text = data['accountNumber'] ?? '';
        ifscController.text = data['ifscCode'] ?? '';
        profileImageUrl.value = data['profileImage'] ?? '';
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    }
  }

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

      // FIXED BUG 1: Must be exactly 'upload_preset'
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', selectedImage!.path));

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);

      if (response.statusCode == 200) {
        // FIXED BUG 2: Key name is 'secure_url'
        profileImageUrl.value = jsonResponse['secure_url'];
        AppValidators.showMessage("Image uploaded!", isError: false);
      } else {
        AppValidators.showMessage("Upload failed: ${jsonResponse['error']['message']}");
      }
    } catch (e) {
      AppValidators.showMessage("Image upload failed.");
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<void> saveFullProfile() async {
    if (nameController.text.isEmpty) {
      AppValidators.showMessage("Name cannot be empty");
      return;
    }

    if (accountController.text != confirmAccountController.text) {
      AppValidators.showMessage("Account numbers do not match!");
      return;
    }

    isSaving.value = true;
    try {
      String uid = _authRepo.currentUser!.uid;

      await _authRepo.updateUserProfile(
        uid: uid,
        newName: nameController.text,
        imageUrl: profileImageUrl.value,
        accountNumber: accountController.text,
        ifscCode: ifscController.text,
      );

      if (newPasswordController.text.isNotEmpty) {
        if (newPasswordController.text == confirmPasswordController.text) {
          await _authRepo.changePassword(newPasswordController.text);
          AppValidators.showMessage("Password updated!", isError: false);
        } else {
          AppValidators.showMessage("Passwords do not match!");
          return;
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