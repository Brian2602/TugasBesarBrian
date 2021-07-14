import 'package:flutter/widgets.dart'; //import library widgets
import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/widgets/UI_resep.dart';//import library class UIResep
import 'package:dicoding_project_flutter/widgets/UI_tips.dart';//import library class UITips

class HomePage extends StatelessWidget {//class HomePage
  @override
  Widget build(BuildContext context) { //widget
  var size = MediaQuery.of(context).size;
    return Scaffold( //mengembalikan nilai Scaffold
      appBar: AppBar( //app bar
        title: Text("Catatan Resep App", //judul app bar
            style: TextStyle(fontWeight: FontWeight.bold)), // style judul app bar
        centerTitle: true, // agar judul berada ditengah
      ),
      body: Stack(
        children:<Widget>[
           Container(
              color: Colors.orangeAccent,
          ),
          Container(
            height: size.height*.55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://st2.depositphotos.com/5988232/11224/v/600/depositphotos_112243554-stock-illustration-team-of-chefs-preparing-food.jpg',
                  
                  ),
                  colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                  fit: BoxFit.cover,
                  ),
             ),
          ),
          Text(
            "\n\n\tBuat Resep Barumu \n\tHari Ini.", 
            style: Theme.of(context).textTheme.display2.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.justify,
          ),
            GridView.count(  
                padding: const EdgeInsets.fromLTRB(20.0, 300.0, 20.0, 10.0), 
                crossAxisCount: 2,
                childAspectRatio: .80,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  InkWell(
                    onTap: () { //fungsi klik pada button
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UIResep())); // navigasi ketika diklik akan berpindah ke halaman class UIResep
                      },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Image.network(
                            'https://static7.depositphotos.com/1007989/759/i/600/depositphotos_7599564-stock-photo-recipe-icon.jpg',
                            height: 120,
                            width : 120
                          ),
                          Text("Resep Saya",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.title.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ]
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () { //fungsi klik pada button
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UITips())); // navigasi ketika diklik akan berpindah ke halaman class UITips
                      },
                    child: Container(
                           decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/000/251/695/small_2x/grocery-shopping-bag-vector-illustration.jpg',
                            height: 120,
                            width : 120
                            ),
                          Text("List Belanja",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.title.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ]
                      ),
                    ),
                  )
                ],
                ),
        ] 
      ),
    );
  }
}