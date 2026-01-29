import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // REQUIRED for MediaType on Web
import '../../../../data/repositories/auth_repository.dart';
import '../../../../core/utils/app_validators.dart';
import '../../profile_display_result.dart';

class UserInfoController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();
  final ImagePicker _picker = ImagePicker();

  var isSaving = false.obs;
  var isUploadingImage = false.obs;
  final role = "user".obs; // Default to user

  var profileImageUrl = "".obs;

  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final accountController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();

  final String cloudName = "dezkkfpex";
  final String uploadPreset = "profile_image";

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      if (_authRepo.currentUser == null) return;
      String uid = _authRepo.currentUser!.uid;
      var data = await _authRepo.getUserData(uid);

      if (data != null) {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        accountController.text = data['accountNumber'] ?? '';
        confirmAccountController.text = data['accountNumber'] ?? '';
        ifscController.text = data['ifscCode'] ?? '';
        profileImageUrl.value = data['profileImage'] ?? '';
        role.value = data['role'] ?? 'user';
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        // Use bytes immediately to avoid loss of reference on Web
        Uint8List fileBytes = await image.readAsBytes();
        await uploadToCloudinary(fileBytes, image.name);
      }
    } catch (e) {
      AppValidators.showMessage("Failed to pick image");
    }
  }

  Future<void> uploadToCloudinary(Uint8List fileBytes, String fileName) async {
    if (fileBytes.isEmpty) return;
    FocusManager.instance.primaryFocus?.unfocus();
    isUploadingImage.value = true;

    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
      var request = http.MultipartRequest("POST", url);

      request.fields['upload_preset'] = uploadPreset;

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'), // Corrected: use MediaType from http_parser
      ));

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      final Map<String, dynamic> jsonResponse = jsonDecode(responseData.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String? uploadedUrl = jsonResponse['secure_url'] ?? jsonResponse['url'];
        if (uploadedUrl != null) {
          profileImageUrl.value = uploadedUrl;
          AppValidators.showMessage("Image uploaded!", isError: false);
        }
      } else {
        throw Exception(jsonResponse['error']?['message'] ?? "Upload failed");
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      AppValidators.showMessage("Check your internet or Cloudinary settings.");
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<void> saveFullProfile() async {
    if (isSaving.value) return;

    if (nameController.text.isEmpty) {
      AppValidators.showMessage("Name cannot be empty");
      return;
    }

    if (isUploadingImage.value) {
      AppValidators.showMessage("Still uploading image. Please wait.");
      return;
    }

    isSaving.value = true;
    try {
      String uid = _authRepo.currentUser!.uid;

      // 1. UPDATE FIRESTORE FIRST (Wait for success before moving screen)
      await _authRepo.updateUserProfile(
        uid: uid,
        newName: nameController.text,
        imageUrl: profileImageUrl.value,
        accountNumber: accountController.text,
        ifscCode: ifscController.text,
      );

      // 2. ONLY NAVIGATE AFTER SUCCESSFUL DB SAVE
      Map<String, dynamic> updatedData = {
        'name': nameController.text,
        'email': emailController.text,
        'role': role.value,
        'accountNumber': accountController.text,
        'ifscCode': ifscController.text,
        'profileImage': profileImageUrl.value,
      };

      Get.to(() => const ProfileDisplayScreen(), arguments: updatedData);
      AppValidators.showMessage("Profile saved!", isError: false);

    } catch (e) {
      debugPrint("Save Error: $e");
      AppValidators.showMessage("Error saving data to database.");
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    // Only dispose if they are not being used by an active listener
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