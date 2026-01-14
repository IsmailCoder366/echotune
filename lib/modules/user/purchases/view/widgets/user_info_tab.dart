import 'package:flutter/material.dart';

class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileUploadSection(),
          const SizedBox(height: 20),
          _buildInputField("Name", "Enter Name"),
          _buildInputField("Email", "Enter Email"),
          const SizedBox(height: 20),
          const Text('Change Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildInputField("Old Password", "Enter Old Password"),
          _buildInputField("New Password", "Enter New Password"),
          _buildInputField("Confirm Password", "Enter Confirm Password"),
          const SizedBox(height: 20),
          const Text('Bank Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildInputField("Account Number", "Enter Account"),
          _buildInputField("Confirm Account Number", "Confirm Enter Account"),
          _buildInputField("IFSC Code", "Enter IFSC Number"),
          SizedBox(height: 30),
          UpdataButton()
        ],
      ),
    );
  }
  Widget _buildProfileUploadSection() {
    return Row(
      children: [
        const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/image.png')),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Profile Picture', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('Recommended memory size is less than 12MB', style: TextStyle(fontSize: 10)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Upload', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}

class UpdataButton extends StatelessWidget {
  const UpdataButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){}, child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)))));
  }
}