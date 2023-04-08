import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  final String amount;
  final String title;
  final IconData icon;
  final Color color;
  const HomeCardWidget(
      {super.key,
      required this.amount,
      required this.title,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    double mwidth = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
            Icon(
                icon,
                size: 20,
              ),
            const  SizedBox(width: 15,),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "₹$amount",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
               Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey,
                ),
              )
               
            ],
          ),
        
         
        ],
      ),
    );
  }
}
