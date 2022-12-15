import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/model/pet_model.dart';
import 'package:pets/screens/history.dart';
import 'package:pets/screens/home_page.dart';
import 'package:photo_view/photo_view.dart';
import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DetailPage extends StatefulWidget {
late final PetModel petlist;
DetailPage(this.petlist);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  bool isPlaying =false;
  final controller=ConfettiController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      setState(() {
        isPlaying=controller.state==ConfettiControllerState.playing;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body:
          Stack(
            children:[
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/1.5,
                      child:PhotoView(
                        imageProvider:NetworkImage(widget.petlist.image.toString()),

                      )

                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.petlist.name.toString(),style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.petlist.age.toString(),style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal
                          ),
                          ),SizedBox(height: 10,),
                          Text("Temperament : ${widget.petlist.description.toString()}",style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal
                          ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Center(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => History()));
                                  },
                                  child: AlertDialog(
                                    backgroundColor:Colors.black ,
                                    title: Text("You’ve now adopted  ${widget.petlist.name}",style: TextStyle(color: Colors.grey),),
                                  ),
                                ),
                              );
                            }
                        );
                        if(isPlaying){
                          controller.stop();
                        }else{
                          controller.play();
                        }
                        Timer(const Duration(milliseconds: 10000), () {
                          if (mounted) {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => History()));
                          }
                        });
                        widget.petlist.isAdopted=true;
                        Map<String,dynamic>data={"field1":widget.petlist.name,"field2":widget.petlist.image};
                        FirebaseFirestore.instance.collection("test").add(data);

                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => History()));

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10,top: 40),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff202020),
                        ),
                        child: Center(
                            child: Text(
                              "Adopt me",
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            )),
                      ),
                    ),


                  ],


                ),
              ),

              Positioned(
                left: 10.0,
                top: 10,
                child:BackButton(
                  color: Colors.grey,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ),
              Positioned(
                  left: 200.0,
                  top: 100,

                  child: ConfettiWidget(
                confettiController: controller,
                shouldLoop: true,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.2,
                    minBlastForce: 5,
                    maxBlastForce: 10,
                    numberOfParticles: 10,

              ))
            ]

          ),
        ),
      ),
    );
  }

}



