import 'package:store_app/Providers/customerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInfo extends ConsumerStatefulWidget {
  const ProfileInfo({super.key});

  @override
  ConsumerState<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends ConsumerState<ProfileInfo> {
  String capitalizeWords(String input) {
    return input
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                  : word,
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProviderr);

    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                capitalizeWords(customer.fullName),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.badge, 'ID', customer.ID.toString()),
              _buildInfoRow(Icons.email, 'Email', customer.email),
              _buildInfoRow(
                Icons.school,
                'Level',
                customer.level != null
                    ? customer.level.toString()
                    : 'Undetermined',
              ),
              _buildInfoRow(
                Icons.person,
                'Gender',
                customer.gender != null
                    ? capitalizeWords(customer.gender!)
                    : 'Undetermined',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
