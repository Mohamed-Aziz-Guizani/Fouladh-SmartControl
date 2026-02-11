import 'package:flutter/material.dart';
import '../models/department.dart';

class DepartmentCard extends StatelessWidget {
  final Department department;
  final VoidCallback onTap;

  const DepartmentCard({
    super.key, 
    required this.department, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4,
        color: department.themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(department.icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              department.name,
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}