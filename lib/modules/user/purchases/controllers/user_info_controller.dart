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

      request.fields['upload_preset'] = uploadPreset;

      // Use readAsBytes to ensure it works on both Android and Web
      final bytes = await selectedImage!.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'upload.jpg',
      ));

      var response = await request.send();

      // Convert the response stream to a string
      final responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = jsonDecode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Get the URL (Try secure_url first, then url)
        String? uploadedUrl = jsonResponse['secure_url'] ?? jsonResponse['url'];

        if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
          profileImageUrl.value = uploadedUrl;
          debugPrint("SUCCESS! REAL CLOUDINARY URL: ${profileImageUrl.value}");
          AppValidators.showMessage("Image uploaded!", isError: false);
        } else {
          debugPrint("Cloudinary success but URL was empty. Response: $jsonResponse");
        }
      } else {
        debugPrint("Cloudinary Error Response: $jsonResponse");
        AppValidators.showMessage("Upload failed: ${jsonResponse['error']?['message']}");
      }
    } catch (e) {
      debugPrint("CRITICAL UPLOAD ERROR: $e");
      AppValidators.showMessage("Connection error during upload.");
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<void> saveFullProfile() async {
    // 1. Check if we are still waiting on Cloudinary
    if (isUploadingImage.value) {
      AppValidators.showMessage("Please wait for the image to finish uploading.");
      return;
    }

    if (nameController.text.isEmpty) {
      AppValidators.showMessage("Name cannot be empty");
      return;
    }

    isSaving.value = true;
    try {
      String uid = _authRepo.currentUser!.uid;

      // 2. Call the Repo
      await _authRepo.updateUserProfile(
        uid: uid,
        newName: nameController.text,
        // If upload failed, this might be empty, which Firestore might reject
        imageUrl: profileImageUrl.value,
        accountNumber: accountController.text,
        ifscCode: ifscController.text,
      );

      // ... password logic ...

      AppValidators.showMessage("Profile updated successfully!", isError: false);
    } catch (e) {
      // If updateUserProfile fails, it 'rethrows' and ends up here.
      // We don't need a separate message here if the Repo already showed one.
      debugPrint("Firestore Save Error: $e");
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
