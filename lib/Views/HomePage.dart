import 'package:assessment_project/Views/DetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;


class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> universitiesData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=United%20Arab%20Emirates'));
      if (response.statusCode == 200) {
        setState(() {
          universitiesData = json.decode(response.body);
          isLoading = false;
        });
        await cacheDataLocally(universitiesData);
      } else {
        setState(() {
          isLoading = false;
        });
        universitiesData = await fetchDataFromLocalDB();
        if (universitiesData.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch data from API')),
          );
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  Future<void> cacheDataLocally(List<dynamic> data) async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      path.join(databasePath, 'universities.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE universities(id INTEGER PRIMARY KEY, name TEXT, state TEXT)',
        );
      },
      version: 1,
    );
    for (final item in data) {
      await database.insert(
        'universities',
        {'name': item['name'], 'state': item['state']},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<dynamic>> fetchDataFromLocalDB() async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      path.join(databasePath, 'universities.db'),
    );
    final List<Map<String, dynamic>> universities = await database.query('universities');
    return universities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University List'),
        
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: universitiesData.length,
              itemBuilder: (context, index) {
                final university = universitiesData[index];
                return ListTile(
                  title: Text(university['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Row(children: [const Text("State: "),Text(university['state-province'] ?? 'Null')]),
                  trailing: GestureDetector(
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(university: university),
                      ),
                    );
                  },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade900.withOpacity(0.5), 
                            spreadRadius: 2, 
                            blurRadius: 1, 
                            offset: const Offset(0, 2), 
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_forward_ios_rounded, ),),
                  ),
                  
                );
              },
            ),
    );
  }
}