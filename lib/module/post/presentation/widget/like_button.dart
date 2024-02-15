import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool? isLiked;
  final int count;
  final Function()? onTap;

  const LikeButton({
    super.key, 
    this.isLiked,
    required this.count,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        if(isLiked != null){
          return Row(
            children: [
              IconButton(
                onPressed: onTap, 
                icon: Icon(
                  isLiked! ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: Colors.black,
                )
              ),
              const SizedBox(width: 5,),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20
                ),
              )
            ],
          );
        } else {
          return Row(
            children: [
              const Icon(
                Icons.thumb_up_outlined,
                color: Colors.black,
              ),
              const SizedBox(width: 5,),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20
                ),
              )
            ],
          );
        }
      }
    );
  }
}