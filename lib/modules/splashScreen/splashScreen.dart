import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image(image: AssetImage('assests/images/social.png'))),
            SizedBox(height: 10,),
            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Social',style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color, fontSize: 30,fontWeight: FontWeight.bold)),
                    TextSpan(text: ' App',style: TextStyle(color:Theme.of(context).textTheme.bodyText1!.color,fontSize: 30,fontWeight: FontWeight.bold)),
                  ]
                )
            ),
            Text('EXPECT THE UNEXPECTED',style: TextStyle(fontSize: 10),),

          ],
        )

      ),

    );
  }
}
