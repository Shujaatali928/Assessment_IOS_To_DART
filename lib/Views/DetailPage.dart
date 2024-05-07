import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> university;
  const DetailPage({super.key, required this.university});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Page"),),
    body:  Padding(
      padding:  const EdgeInsets.all(15),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           const Icon(Icons.refresh,size: 40,),
      
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("University Name: ${widget.university['name']}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
          const SizedBox(height: 10),
          Text("State: ${widget.university['state-province']}", style: const TextStyle(color: Colors.black, fontSize: 15),),
                    const SizedBox(height: 10),
                    Row(
                children: [
                  Expanded(child: Text("Country: ${widget.university['country']}",style: const TextStyle(color: Colors.black,  fontSize: 15))),
                  Expanded(child: Text("Country Code: ${widget.university['alpha_two_code']}", style: const TextStyle(color: Colors.black, fontSize: 15))),
                ],
                    ),
                    const SizedBox(height: 10),
                    Text("Web Page: ${widget.university['domains']}")],
                
                    )
        ],
      ),
    ),);
  }
}