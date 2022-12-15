import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/screens/detail_page.dart';
import 'package:pets/screens/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../model/pet_model.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String search="";
  TextEditingController searchController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Row(
          children: [
            Text("Hi John"),
            Spacer(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                    fit: BoxFit.fill
                ),
              ),
            ),
          //  NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
          ],
        ),
        

      ),
      drawer: Drawer(

        backgroundColor: Colors.black,
        child: SafeArea(
          child: Column(
            children: [
             Container(
               height: 150,
               color: Colors.grey[800],
               child: Padding(
                 padding: const EdgeInsets.only(top: 20,left: 10,right: 20),
                 child:Row(
                   children: [
                     Container(
                       width: 80,
                       height: 80,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             image: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                             fit: BoxFit.fill
                         ),
                       ),
                     ),
                     SizedBox(width: 10,),
                     Text("John",style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold
                     ),),

                   ],
                 )
               ),
             ),

              ListTile(
                onTap: ()=>  Navigator.push(
                 context, MaterialPageRoute(builder: (_) => HomePage())),
                leading: Icon(Icons.home,color: Colors.grey,),
                title: Text("Home",style: TextStyle(color: Colors.grey,fontSize: 16),) ,
              ), ListTile(
                onTap: ()=>  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => History())),
                leading: Icon(Icons.shopping_cart,color: Colors.grey,),
                title: Text("History",style: TextStyle(color: Colors.grey,fontSize: 16),) ,
              ),




            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only( top: 7),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color:Color(0xff202020) ),
                    color: Color(0xff202020),
                  ),
                  height: 50,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (String? value){
                      print("name${value}");
                      setState(() {
                        search=value.toString();
                      });
                    },

                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,fontFamily: "Nonitu"),
                    autofocus: false,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          top: 13, left: 20, bottom: 1, right: 4),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color:Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                height: MediaQuery.of(context).size.height/1.2,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: petmodellist.length,
                  itemBuilder: (BuildContext context, int index) {
                    PetModel petlist=petmodellist[index];

                    if(searchController.text.isEmpty){
                      return  petmodellist[index].isAdopted==false?
                        GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>DetailPage(petlist)),
                          );
                        },
                        child:
                        Card(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          color: Color(0xff101010),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                      width:120,
                                      height: 120,
                                      child: Image.network(petlist.image.toString(),fit: BoxFit.cover,)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          width:MediaQuery.of(context).size.width/1.9,
                                          child: Text(petlist.name.toString(),style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold
                                          ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(petlist.age.toString(),style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text("\$ ${petlist.price.toString()}",style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),



                        )


                      ):
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>DetailPage(petlist)),
                          // );
                        },
                        child:
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              color: Color(0xff101010),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Container(
                                          width:120,
                                          height: 120,
                                          child: Image.network(petlist.image.toString(),fit: BoxFit.cover,)
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Container(
                                              margin:EdgeInsets.only(top: 10),
                                              width:MediaQuery.of(context).size.width/1.9,
                                              child: Text(petlist.name.toString(),style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold
                                              ),
                                                maxLines: 2,
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                Text(petlist.age.toString(),style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.normal
                                                ),
                                                ),
                                                SizedBox(width: 40,),
                                                petmodellist[index].isAdopted==true?
                                                Container(
                                                  height:20,
                                                  width:100,

                                                  decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.purple
                                                  ),
                                                  child: Center(child: Text("Addopted",style: TextStyle(
                                                    fontSize: 16,fontWeight: FontWeight.bold,
                                                  ),)),
                                                ):Container()
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Text("\$ ${petlist.price.toString()}",style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal
                                            ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),


                            ),

                      );
                    }else if(petlist.name!.toLowerCase().contains(searchController.text.toLowerCase())){
                      return petmodellist[index].isAdopted==false?
                        GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>DetailPage(petlist)),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          color: Color(0xff101010),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                      width:120,
                                      height: 120,
                                      child: Image.network(petlist.image.toString(),fit: BoxFit.cover,)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          width:MediaQuery.of(context).size.width/1.9,
                                          child: Text(petlist.name.toString(),style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold
                                          ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(petlist.age.toString(),style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text("\$ ${petlist.price.toString()}",style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),


                        ),
                      ):
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>DetailPage(petlist)),
                          // );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          color: Color(0xff101010),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                      width:120,
                                      height: 120,
                                      child: Image.network(petlist.image.toString(),fit: BoxFit.cover,)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin:EdgeInsets.only(top: 10),
                                          width:MediaQuery.of(context).size.width/1.9,
                                          child: Text(petlist.name.toString(),style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold
                                          ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text(petlist.age.toString(),style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal
                                            ),
                                            ),
                                            SizedBox(width: 40,),
                                            petmodellist[index].isAdopted==true?
                                            Container(
                                              height:20,
                                              width:100,

                                              decoration:BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.purple
                                              ),
                                              child: Center(child: Text("Addopted",style: TextStyle(
                                                fontSize: 16,fontWeight: FontWeight.bold,
                                              ),)),
                                            ):Container()
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Text("\$ ${petlist.price.toString()}",style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),


                        ),
                      );
                    }else{
                     return Container();
                    }




                  },),
              ),



            ],
          ),
        ),
      ),

    );
  }

}
