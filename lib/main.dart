import 'package:flutter/material.dart';

void main() {
  runApp(BloodDonorFormApp());
}

class BloodDonorFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donor Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BloodDonorForm(),
    );
  }
}

class BloodDonorForm extends StatefulWidget {
  @override
  _BloodDonorFormState createState() => _BloodDonorFormState();
}

class _BloodDonorFormState extends State<BloodDonorForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String usn = '';
  int? age;
  String? gender;
  String? bloodGroup;
  String mobileNumber = '';
  String additionalMobileNumber = '';
  String addressPinCode = '';
  bool? donatedPlatelets;
  int numberOfDonations = 0;
  DateTime? lastDateOfDonation;
  bool? medicalCondition;
  bool? drinkingAndSmoking;
  bool? willDonateIfCloseToNeedy;
  String donationExperience = '';
  // File upload logic will go here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donor Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email ID *'),
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name of the donor *'),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'USN *'),
                onSaved: (value) => usn = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Donor Age *'),
                keyboardType: TextInputType.number,
                onSaved: (value) => age = int.tryParse(value!),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Donor Gender *'),
                items: ['Male', 'Female', 'Non binary']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) => setState(() => gender = value),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Donor Blood Group *'),
                items: [
                  'A RhD positive (A+)',
                  'A RhD negative (A-)',
                  'B RhD positive (B+)',
                  'B RhD negative (B-)',
                  'O RhD positive (O+)',
                  'O RhD negative (O-)',
                  'AB RhD positive (AB+)',
                  'AB RhD negative (AB-)'
                ]
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) => setState(() => bloodGroup = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Donor mobile number *'),
                onSaved: (value) => mobileNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Donor Additional mobile number *'),
                onSaved: (value) => additionalMobileNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address Pin code *'),
                onSaved: (value) => addressPinCode = value!,
              ),
              SwitchListTile(
                title: Text('Have you donated platelets? *'),
                value: donatedPlatelets ?? false,
                onChanged: (value) => setState(() => donatedPlatelets = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of donations *'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    numberOfDonations = int.tryParse(value!) ?? 0,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Last date of donation *'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != lastDateOfDonation)
                    setState(() {
                      lastDateOfDonation = picked;
                    });
                },
                readOnly: true,
                controller: TextEditingController(
                    text: lastDateOfDonation != null
                        ? "${lastDateOfDonation!.toLocal()}".split(' ')[0]
                        : ''),
              ),
              SwitchListTile(
                title: Text('Are you under any medical condition? *'),
                value: medicalCondition ?? false,
                onChanged: (value) => setState(() => medicalCondition = value),
              ),
              SwitchListTile(
                title: Text('Drinking and smoking? *'),
                value: drinkingAndSmoking ?? false,
                onChanged: (value) =>
                    setState(() => drinkingAndSmoking = value),
              ),
              SwitchListTile(
                title:
                    Text('Will you donate blood if you stay close to needy? *'),
                value: willDonateIfCloseToNeedy ?? false,
                onChanged: (value) =>
                    setState(() => willDonateIfCloseToNeedy = value),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        'Write a few lines about your blood donation experience *'),
                onSaved: (value) => donationExperience = value!,
              ),
              // File upload logic will go here
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form submission
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
