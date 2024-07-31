import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  void _submitForm() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    if (name.isNotEmpty && email.isNotEmpty) {
      print('Name: $name, Email: $email');
    }
  }

  Widget _buildForm(bool isWideScreen) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Flex(
       
          direction: isWideScreen?Axis.horizontal:Axis.vertical,
          children: [
            Container(
              width: isWideScreen ? 200 : double.infinity,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: isWideScreen ? 200 : double.infinity,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              width: isWideScreen ? 200 : double.infinity,
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usernam',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              width: isWideScreen ? 200 : double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Form Example'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 500;
          double containerHeight = constraints.maxHeight * 0.75;

          return SingleChildScrollView(
            child: Column(
              children: [
                
                Container(
                  height: containerHeight,
                  color: Colors.red,
                ),
            
                   SingleChildScrollView(
                     scrollDirection: isWideScreen?Axis.horizontal:Axis.vertical,
                    child: _buildForm(isWideScreen),
                  ),
            
              ],
            ),
          );
        },
      ),
    );
  }
}
