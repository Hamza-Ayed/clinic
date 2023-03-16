import 'dart:ui';

import 'package:doctors/constant/colors.dart';
import 'package:flutter/material.dart';

Scaffold stackWidget(
      BuildContext context, String image, title, Widget child) {
    return Scaffold(
      //  appBar: AppBar(title: const Text('Add'),),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        title,
                        style: tilte1Style,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  child
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
