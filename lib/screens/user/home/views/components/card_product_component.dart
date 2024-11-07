
import 'package:ecommerce_sem4/models/user/cart/request/add_cart_request.dart';
import 'package:ecommerce_sem4/models/user/product/response/product_model.dart';
import 'package:ecommerce_sem4/screens/user/product/views/product_detail_screen.dart';
import 'package:ecommerce_sem4/services/user/cart/cart_service.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProduct extends StatelessWidget{
  final String image;
  final String name;
  final String price;
  final Product? product;

  const CardProduct({super.key, required this.image, required this.name, required this.price, this.product});

  Future<void> _addToCart(BuildContext context) async {
    // Get userId and accessToken from SharedPreferences
    final pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("id");
    String? accessToken = pref.getString("accessToken");

    // Set up headers with authorization
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    };

    // Create request payload
    Map<String, Object?> request = CartRequest(
      userId: userId!,
      productId: product!.id.toString(),
      quantity: "1",
      price: product!.price.toString(),
    ).toMap();

    final data = await CartService().addToCart(cartAddUri, headers, request);

    if (data != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item has been added to the cart successfully!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   return Card(
     elevation: 5,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),
     ),
     child: Column(
       children: <Widget>[
         ClipRRect(
           borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
           // child: Image.asset(
           //   image, // Your image asset
           //   height: 100,
           //   fit: BoxFit.cover,
           // ),
           child: Image.network(
             image, // Replace with your network image URL
             height: 100,
             fit: BoxFit.cover,
             errorBuilder: (context, error, stackTrace) => Image.asset("assets/user/images/slide1.jpg"), // Optional error handling
           )
           ,
         ),
         Padding(
           padding: const EdgeInsets.all(9.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:  [
              GestureDetector(
                child:  Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
                },
              ),

              const SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     price,
                     style: const TextStyle(
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         fontSize: 12,
                         overflow: TextOverflow.ellipsis
                     ),
                   ),
                   Center(
                     child: ElevatedButton(
                       onPressed: ()=>_addToCart(context),
                       style: ElevatedButton.styleFrom(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20), // Set the border radius
                         ),
                         padding: const EdgeInsets.all(16), // Padding inside the button
                         backgroundColor: Colors.green, // Background color
                       ),
                       child:const Icon(Icons.add, color: Colors.white), // Use Icon as child
                     ),
                   ),
                 ],
               )
             ],
           ),
         ),
       ],
     ),
   );
  }
}