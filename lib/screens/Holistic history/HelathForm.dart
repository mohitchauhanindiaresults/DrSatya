import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/Constant.dart';
import '../../utils/Utils.dart';
import 'AddHealthScore.dart';

class HealthForm extends StatefulWidget {
  final int employeeId;

  HealthForm({required this.employeeId});

  @override
  _HealthFormState createState() => _HealthFormState();
}

class _HealthFormState extends State<HealthForm> {
  late Future<Map<String, dynamic>> employeeDetails;

  TextEditingController centerController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController holistic_counsler = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController blood_group = TextEditingController();
  TextEditingController maritial_status = TextEditingController();
  TextEditingController ani_date = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController current_weight = TextEditingController();
  TextEditingController ideal_weight = TextEditingController();
  TextEditingController bmi = TextEditingController();
  TextEditingController weight_status = TextEditingController();
  TextEditingController childhood_weight_status = TextEditingController();
  TextEditingController father_weight_status = TextEditingController();
  TextEditingController mother_weight_status = TextEditingController();
  TextEditingController bro_sis_weight_status = TextEditingController();
  TextEditingController inch_tummy = TextEditingController();
  TextEditingController inch_rib = TextEditingController();
  TextEditingController inch_chest = TextEditingController();
  TextEditingController inch_waist = TextEditingController();
  TextEditingController inch_hips = TextEditingController();
  TextEditingController inch_thigs = TextEditingController();
  TextEditingController inch_arm = TextEditingController();
  TextEditingController inch_chest_expend = TextEditingController();
  TextEditingController hemoglobin = TextEditingController();
  TextEditingController blood_pressure = TextEditingController();
  TextEditingController fasting_sugar_level = TextEditingController();
  TextEditingController calcium_level = TextEditingController();
  TextEditingController vit_d_level = TextEditingController();
  TextEditingController vit_b12_level = TextEditingController();
  TextEditingController thyroid_level = TextEditingController();
  TextEditingController blood_iron_level = TextEditingController();
  TextEditingController heart_rate = TextEditingController();
  TextEditingController other_cronical_disease = TextEditingController();
  TextEditingController detailed_discription = TextEditingController();
  TextEditingController fatal_detailed_discription = TextEditingController();

  TextEditingController others = TextEditingController();
  TextEditingController other_cronic_pains = TextEditingController();
  TextEditingController other_cronic_detailed_discription =
      TextEditingController();
  TextEditingController other_digestive = TextEditingController();
  TextEditingController other_digestive_discription = TextEditingController();
  TextEditingController other_mental = TextEditingController();
  TextEditingController other_mental_discription = TextEditingController();
  TextEditingController other_relationship = TextEditingController();
  TextEditingController relationship_discription = TextEditingController();
  TextEditingController other_female_issue = TextEditingController();
  TextEditingController female_issue_discription = TextEditingController();
  TextEditingController other_physicalissue = TextEditingController();
  TextEditingController other_physical_issue_discription =
      TextEditingController();
  TextEditingController other_addication = TextEditingController();
  TextEditingController other_addication_discription = TextEditingController();
  TextEditingController total_sleep_hours = TextEditingController();
  TextEditingController sleep_disorder = TextEditingController();
  TextEditingController day_time_sleep = TextEditingController();
  TextEditingController Wake_up_time = TextEditingController();
  TextEditingController sleep_time = TextEditingController();
  TextEditingController religion = TextEditingController();
  TextEditingController any_sergery = TextEditingController();
  TextEditingController gal_bludder = TextEditingController();
  TextEditingController eyes = TextEditingController();
  TextEditingController teeth = TextEditingController();
  TextEditingController past_illness = TextEditingController();
  TextEditingController disease_history_father = TextEditingController();
  TextEditingController disease_history_mother = TextEditingController();
  TextEditingController disease_history_brother = TextEditingController();
  TextEditingController disease_history_sister = TextEditingController();
  TextEditingController disease_history_spouse = TextEditingController();
  TextEditingController disease_history_kids = TextEditingController();
  TextEditingController sexual_problem_female = TextEditingController();
  TextEditingController other_sexual_problem_female = TextEditingController();
  TextEditingController deatil_discription_sexual_problem_female =
      TextEditingController();
  TextEditingController sexual_problem_male = TextEditingController();
  TextEditingController other_sexual_problem_male = TextEditingController();
  TextEditingController deatil_discription_sexual_problem_male =
      TextEditingController();
  TextEditingController skin_hair = TextEditingController();
  TextEditingController other_skin_hair = TextEditingController();
  TextEditingController deatil_discription_skin_hair = TextEditingController();
  TextEditingController food_type = TextEditingController();
  TextEditingController milk_product = TextEditingController();
  TextEditingController unhealthy = TextEditingController();
  TextEditingController Biscutes = TextEditingController();
  TextEditingController namkeen = TextEditingController();
  TextEditingController achar = TextEditingController();
  TextEditingController coldrink = TextEditingController();
  TextEditingController ghee = TextEditingController();
  TextEditingController salad = TextEditingController();
  TextEditingController fruit = TextEditingController();
  TextEditingController nuts = TextEditingController();
  TextEditingController dry_fruit = TextEditingController();
  TextEditingController sprouts = TextEditingController();
  TextEditingController coconut_water = TextEditingController();
  TextEditingController fruite_juice = TextEditingController();
  TextEditingController vergitable_juice = TextEditingController();
  TextEditingController water_intake = TextEditingController();
  TextEditingController daily_planned_diet = TextEditingController();
  TextEditingController salt_intake = TextEditingController();
  TextEditingController sugar_intake = TextEditingController();
  TextEditingController other_herb = TextEditingController();
  TextEditingController other_immunity = TextEditingController();
  TextEditingController lung_capicity = TextEditingController();
  TextEditingController spinal = TextEditingController();
  TextEditingController muscular_strenght = TextEditingController();
  TextEditingController balance_coordination = TextEditingController();
  TextEditingController abdominal_strength = TextEditingController();
  TextEditingController lower_back_strength = TextEditingController();
  TextEditingController cervical_flexiblity = TextEditingController();
  TextEditingController shoulder_flexiblity = TextEditingController();
  TextEditingController hips = TextEditingController();
  TextEditingController lungs_vitallity = TextEditingController();
  TextEditingController f1 = TextEditingController();
  TextEditingController f2 = TextEditingController();
  TextEditingController f3 = TextEditingController();
  TextEditingController f4 = TextEditingController();
  TextEditingController f5 = TextEditingController();
  TextEditingController f6 = TextEditingController();
  TextEditingController f7 = TextEditingController();
  TextEditingController f8 = TextEditingController();
  TextEditingController f9 = TextEditingController();
  TextEditingController f10 = TextEditingController();
  TextEditingController f11 = TextEditingController();
  TextEditingController strength = TextEditingController();
  TextEditingController weekness = TextEditingController();
  TextEditingController speed_remark = TextEditingController();

  List<String> diseases = [
    'Diabetes',
    'Heart problem',
    'Kidney problem',
    'Liver problem',
    'Thyroid problem',
    'Respiratory problem',
    'Arthritis problem',
    'TB',
    'Sinusitis'
  ];
  List<String> selectedDiseases = [];
  List<String> fatel_diseases = [
    'Cancer',
    'Liver cirrhosis',
    'HIV/AIDS',
  ];
  List<String> fatel_selectedDiseases = [];
  List<String> cronic_pains = [
    'Migraine',
    'Headache',
    'Cervical pain',
    'Frozen shoulder',
    'Slip disc',
    'Knee pain',
    'Heel pain',
    'Flat foot',
    'Body pain',
    'Back pain',
    'Calf pain',
    'Sciatica pain'
  ];
  List<String> cronic_pains_selected = [];
  List<String> digestive_diseases = [
    'Acidity',
    'Gas',
    'Constipation',
    'Indigestion',
    'IBS',
    'Ulcerative colitis',
  ];
  List<String> digestive_diseases_details = [];
  List<String> mental_emotional_problem = [
    'Anxiety',
    'Stress',
    'Tension',
    'Worry',
    'Overthinking',
    'Negative thinking',
    'Depression',
    'Suicidal thoughts',
    'Panic attack',
    'Obsessive-compulsive disorder (OCD)',
    'Bipolar disorder',
    'Mood swings',
    'Dementia',
    'Split personality',
    'Personality disorder',
    'Histrionic personality disorder (HPD)',
    'Memory weakness',
    'Insecurity',
    'Fear',
    'Phobia',
    'Feeling of lackness',
    'Ego problems',
    'Lack of concentration and focus',
    'Lack of self-confidence',
    'Lack of willpower',
    'Anger',
    'Frustration',
    'Introvert',
    'Sadness',
    'Guilt',
    'Blaming',
    'Criticism'
  ];
  List<String> mental_emotional_problem_selected = [];
  List<String> relationship = [
    'Lack of responsibility',
    'Parenting disagreement',
    'Unrealistic expectations',
    'Over-tolerance',
    'Financial conflicts',
    'Sexual issues',
    'Communication gap',
    'Trust issues',
    'Physical abuse',
    'Behavioral factors',
    'Respect issues'
  ];
  List<String> relationship_selected = [];
  List<String> female_issue = [
    'Menopausal',
    'PCOD/PCOS',
    'Period Problems',
    'Hormonal imbalances',
  ];
  List<String> female_issue_selected = [];
  List<String> physicalissue = [
    'Cerebral Palsy',
    'Muscular Dystrophy',
    'Blindness',
    'Amputations and loss of limbs',
  ];
  List<String> physicalissue_selected = [];
  List<String> addications = [
    'Alcohol consumption',
    'Drug abuse',
    'Smoking',
    'Gutka chewing',
    'Pan chewing',
    'Gum chewing',
    'Tobacco use',
    'Coffee addiction',
    'Nail biting',
    'Shaking knees while sitting',
    'Excessive social media usage',
    'Masturbation addiction',
    'Computer game addiction'
  ];
  List<String> addications_selected = [];
  List<String> regular_practice = [
    'Yoga',
    'Pranayama',
    'Meditation',
    'Puja Paath',
    'Walking',
    'Running',
    'Gym / Workout',
    'Dance',
    'Surya Namaskar'
  ];
  List<String> regular_practice_selected = [];
  List<String> herb_intake = [
    'Aloe vera juice',
    'Wheatgrass powder',
    'Dr. Satya herbal tea',
    'Holistic health powder',
    'Badam mixture',
    'General Honey',
    'Special Honey',
    'Triphla Powder'
  ];
  List<String> herb_intake_practice_selected = [];
  List<String> immunity = [
    'Frequent cold and cough',
    'Coronavirus infection (COVID-19)',
    'Dengue fever',
    'Frequent fever',
    'Malaria',
    'Frequent infections'
  ];
  List<String> immunity_selected = [];

  @override
  void initState() {
    super.initState();

    initaite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Health Form',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddHealthScore(employeeId: widget.employeeId)),
              );
              // Add your settings button functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14B3B4), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: centerController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Center',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: firstNameController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: lastNameController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: mobileController,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: alternativeMobileController,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Alternative Mobile',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: gender,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: profession,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Alternative Mobile',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: qualification,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Qualification',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: holistic_counsler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Holistic Counselor',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: dob,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Date Of Birth',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: blood_group.text.isNotEmpty ? blood_group.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      blood_group.text = value!;
                    });
                  },
                  items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Blood Group',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: maritial_status.text.isNotEmpty
                      ? maritial_status.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      maritial_status.text = value!;
                    });
                  },
                  items:
                      ['Married', 'Unmarried', 'Divorced'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Marital Status',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: ani_date,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Anniversary Date',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: height,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height In Inches',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Weight History :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: current_weight.text.isNotEmpty
                      ? current_weight.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      current_weight.text = value!;
                    });
                  },
                  items: [
                    '<40',
                        '40-45',
                        '46-50',
                        '51-55',
                        '56-60',
                        '61-65',
                        '66-70',
                        '71-75',
                        '76-80',
                        '81-85',
                        '86-90',
                        '91-95',
                        '96-100',
                        '101-105',
                        '106-110',
                        '111-115',
                        '116-120',
                        '121-125',
                        '126-130',
                        '131-135',
                        '136-140',
                        '141-145',
                        '146-150',
                        '151-155',
                        '156-160',
                        '161-165',
                        '166-170',
                        '171-175',
                        '176-180',
                        '181-185',
                        '186-190',
                        '191-195',
                        '196-200',
                        '201-205',
                        '206-210',
                        '211-215',
                        '216-220',
                        '221-225',
                        '226-230',
                        '231-235',
                        '236-240',
                        '241-245',
                        '246-250'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Current Weight',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      ideal_weight.text.isNotEmpty ? ideal_weight.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      ideal_weight.text = value!;
                    });
                  },
                  items: [
                    '<40',
                    '40-45',
                    '46-50',
                    '51-55',
                    '56-60',
                    '61-65',
                    '66-70',
                    '71-75',
                    '76-80',
                    '81-85',
                    '86-90',
                    '91-95',
                    '96-100',
                    '101-105',
                    '106-110',
                    '111-115',
                    '116-120',
                    '121-125',
                    '126-130',
                    '131-135',
                    '136-140',
                    '141-145',
                    '146-150',
                    '151-155',
                    '156-160',
                    '161-165',
                    '166-170',
                    '171-175',
                    '176-180',
                    '181-185',
                    '186-190',
                    '191-195',
                    '196-200',
                    '201-205',
                    '206-210',
                    '211-215',
                    '216-220',
                    '221-225',
                    '226-230',
                    '231-235',
                    '236-240',
                    '241-245',
                    '246-250'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Ideal Weight',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: bmi.text.isNotEmpty ? bmi.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      bmi.text = value!;
                    });
                  },
                  items: [
                    'below 18.5',
                    '18.6-24.9',
                    '25-29.9',
                    '25-29.9',
                    '30 & above',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'BMI',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      weight_status.text.isNotEmpty ? weight_status.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      weight_status.text = value!;
                    });
                  },
                  items: [
                    'obese',
                    'overweight',
                    'underweight',
                    'ideal weight',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: ' Weight status',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: childhood_weight_status.text.isNotEmpty
                      ? childhood_weight_status.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      childhood_weight_status.text = value!;
                    });
                  },
                  items: [
                    'obese',
                    'overweight',
                    'underweight',
                    'ideal weight',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Childhood Weight',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: father_weight_status.text.isNotEmpty
                      ? father_weight_status.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      father_weight_status.text = value!;
                    });
                  },
                  items: [
                    'obese',
                    'overweight',
                    'underweight',
                    'ideal weight',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Father Weight',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: mother_weight_status.text.isNotEmpty
                      ? mother_weight_status.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      mother_weight_status.text = value!;
                    });
                  },
                  items: [
                    'obese',
                    'overweight',
                    'underweight',
                    'ideal weight',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Mother weight status',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: bro_sis_weight_status.text.isNotEmpty
                      ? bro_sis_weight_status.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      bro_sis_weight_status.text = value!;
                    });
                  },
                  items: [
                    'obese',
                    'overweight',
                    'underweight',
                    'ideal weight',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sibling weight status',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Inch Record :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_tummy,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tummy',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_rib,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '12th rib',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_chest,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Chest - Flat',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_chest_expend,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Chest - Expanded',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_waist,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Waist',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_hips,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Hips',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_thigs,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Thighs',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: inch_arm,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Arms',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Basic Medical Parameters :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: hemoglobin.text.isNotEmpty ? hemoglobin.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      hemoglobin.text = value!;
                    });
                  },
                  items: [
                    '<5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20','>20',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Haemoglobin',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: blood_pressure.text.isNotEmpty
                      ? blood_pressure.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      blood_pressure.text = value!;
                    });
                  },
                  items: [
                    'Normal',
                    'Hypertension',
                    'Stage -I HyperTension',
                    'Stage -2 HyperTension',
                    'Hypotension',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Blood pressure',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: fasting_sugar_level,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fasting Sugar Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: calcium_level,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Calcium Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: vit_d_level,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Vitamin-D Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: vit_b12_level,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Vitamin-B12 Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      thyroid_level.text.isNotEmpty ? thyroid_level.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      thyroid_level.text = value!;
                    });
                  },
                  items: [
                    'Hypo',
                    'Hyper',
                    'ideal/normal',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Thyroid level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: blood_iron_level,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Blood Iron Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: heart_rate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Heart rate',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Chronic Diseases :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diseases
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: selectedDiseases.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedDiseases.add(disease);
                                } else {
                                  selectedDiseases.remove(disease);
                                }
                                print(selectedDiseases);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_cronical_disease,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Chronic Diseases',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: detailed_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Fatal Diseases :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: fatel_diseases
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: fatel_selectedDiseases.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  fatel_selectedDiseases.add(disease);
                                } else {
                                  fatel_selectedDiseases.remove(disease);
                                }
                                print(fatel_selectedDiseases);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: others,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: fatal_detailed_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Chronic Pains :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cronic_pains
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: cronic_pains_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  cronic_pains_selected.add(disease);
                                } else {
                                  cronic_pains_selected.remove(disease);
                                }
                                print(cronic_pains_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_cronic_pains,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Chronic Pains',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_cronic_detailed_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Chronic Pain Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Digestive Problems :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: digestive_diseases
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: digestive_diseases_details.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  digestive_diseases_details.add(disease);
                                } else {
                                  digestive_diseases_details.remove(disease);
                                }
                                print(digestive_diseases_details);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_digestive,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Digestive Problems',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_digestive_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Mental/Emotional Problems :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: mental_emotional_problem
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: mental_emotional_problem_selected
                              .contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  mental_emotional_problem_selected
                                      .add(disease);
                                } else {
                                  mental_emotional_problem_selected
                                      .remove(disease);
                                }
                                print(mental_emotional_problem_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_mental,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Mental/emotional Problems',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_mental_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Relationship Issue :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: relationship
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: relationship_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  relationship_selected.add(disease);
                                } else {
                                  relationship_selected.remove(disease);
                                }
                                print(relationship_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_relationship,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Relationship Issue',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: relationship_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Female Issues :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: female_issue
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: female_issue_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  female_issue_selected.add(disease);
                                } else {
                                  female_issue_selected.remove(disease);
                                }
                                print(female_issue_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_female_issue,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Female Issues',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: female_issue_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Physical disabilities :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: physicalissue
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: physicalissue_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  physicalissue_selected.add(disease);
                                } else {
                                  physicalissue_selected.remove(disease);
                                }
                                print(physicalissue_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_physicalissue,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Physical disabilities',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_physical_issue_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Bad Habits & Addictions :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: addications
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: addications_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  addications_selected.add(disease);
                                } else {
                                  addications_selected.remove(disease);
                                }
                                print(addications_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_addication,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Addictions & Bad habits',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_addication_discription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Sleep :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: total_sleep_hours.text.isNotEmpty
                      ? total_sleep_hours.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      total_sleep_hours.text = value!;
                    });
                  },
                  items: ['<4', '5','6', '7', '8', '9', '10', '11', '12','>12']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Total Sleep Hours',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: sleep_disorder.text.isNotEmpty
                      ? sleep_disorder.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      sleep_disorder.text = value!;
                    });
                  },
                  items: [
                    'Insomnia',
                    'Narcolepsy',
                    'Restless leg syndrome',
                    'Sleep apnea',
                    'Rapid eye movement behavior disorder',
                    'Parasomnias',
                    'Hypersomnia'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sleep Disorders',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: day_time_sleep.text.isNotEmpty
                      ? day_time_sleep.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      day_time_sleep.text = value!;
                    });
                  },
                  items:
                  ['<1','1-2', '3-4', '5-6', '7-8', '9-10','>10'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Day Time Sleep',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      Wake_up_time.text.isNotEmpty ? Wake_up_time.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      Wake_up_time.text = value!;
                    });
                  },
                  items: [
                    '2-3 AM',
                    '3-4 AM',
                    '4-5 AM',
                    '5-6 AM',
                    '6-7 AM',
                    '7-8 AM',
                    '8-9 AM',
                    '9-10 AM',
                    '10-11 AM',
                    'After 11 AM',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Wake-up Time',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: sleep_time.text.isNotEmpty ? sleep_time.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      sleep_time.text = value!;
                    });
                  },
                  items: [
                    'Before 6 PM',
                    '6-7 PM',
                    '7-8 PM',
                    '8-9 PM',
                    '9-10 PM',
                    '10-11 PM',
                    '11-12 PM',
                    '12-1 AM',
                    '1-2 AM',
                    '2-3 AM',
                    'After 3 AM',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sleep Time',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: religion.text.isNotEmpty ? religion.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      religion.text = value!;
                    });
                  },
                  items: [
                    'Hindu',
                    'Muslim',
                    'Christian',
                    'Buddhist',
                    'Jewish',
                    'Sikh',
                    'Jain',
                    'Atheists',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Religion',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: any_sergery,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Any surgery',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: gal_bludder.text.isNotEmpty ? gal_bludder.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      gal_bludder.text = value!;
                    });
                  },
                  items: [
                    'Stones/Sludges',
                    'Removed',
                    'Healthy',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Gall Bladder',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: eyes.text.isNotEmpty ? eyes.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      eyes.text = value!;
                    });
                  },
                  items: [
                    'Perfect eyes',
                    'Using glasses',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Eyes',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: teeth.text.isNotEmpty ? teeth.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      teeth.text = value!;
                    });
                  },
                  items: [
                    'All removed',
                    'Perfect',
                    'Cavities',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Teeth',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: past_illness,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Past Illness',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Family Disease History :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_father,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Father',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_mother,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Mother',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_brother,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Brother',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_sister,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Sister',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_spouse,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Spouse',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: disease_history_kids,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kids',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Sexual Problem (Female) :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: sexual_problem_female.text.isNotEmpty
                      ? sexual_problem_female.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      sexual_problem_female.text = value!;
                    });
                  },
                  items: [
                    'Pain during sex',
                    'Lack of desire',
                    'Orgasmic disorder',
                    'Sexual arousal disorder',
                    'Infertility',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sexual Problem (Female)',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_sexual_problem_female,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: deatil_discription_sexual_problem_female,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed discription',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Sexual Problem (Male) :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: sexual_problem_male.text.isNotEmpty
                      ? sexual_problem_male.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      sexual_problem_male.text = value!;
                    });
                  },
                  items: [
                    'Premature ejaculation',
                    'Erectile dysfunction',
                    'Loss of libido',
                    'Prolonged erection',
                    'Dry orgasm',
                    'Infertility'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sexual Problem (Male)',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_sexual_problem_male,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: deatil_discription_sexual_problem_male,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Skin & Hairs Problems :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: skin_hair.text.isNotEmpty ? skin_hair.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      skin_hair.text = value!;
                    });
                  },
                  items: [
                    'Skin allergy',
                    'Acne',
                    'Pimples',
                    'Dark circles',
                    'Hair fall',
                    'Grey hair',
                    'Baldness',
                    'Alopecia',
                    'Atopic dermatitis',
                    'Eczema',
                    'Psoriasis',
                    'Vitiligo'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Skin & Hairs Problems',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_skin_hair,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: deatil_discription_skin_hair,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Detailed description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Food Habits :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: food_type.text.isNotEmpty ? food_type.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      food_type.text = value!;
                    });
                  },
                  items: [
                    'Vegetarian',
                    'Non-vegetarian',
                    'Eggetarian',
                    'Vegan',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Food Type',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      milk_product.text.isNotEmpty ? milk_product.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      milk_product.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Milk & Milk product',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: unhealthy.text.isNotEmpty ? unhealthy.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      unhealthy.text = value!;
                    });
                  },
                  items: [
                    'Once a week',
                    'Twice a week',
                    'Thrice a week',
                    'Regular',
                    'Occasional',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Unhealthy diet',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: Biscutes.text.isNotEmpty ? Biscutes.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      Biscutes.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Biscuits',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: namkeen.text.isNotEmpty ? namkeen.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      namkeen.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Namkeen',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: coldrink.text.isNotEmpty ? coldrink.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      coldrink.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Cold drink / lemonade etc',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: ghee.text.isNotEmpty ? ghee.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      ghee.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Ghee',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: salad.text.isNotEmpty ? salad.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      salad.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Salad (Raw vegetable)',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: achar.text.isNotEmpty ? achar.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      achar.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Achar/ Murabba/ Candy etc',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: fruit.text.isNotEmpty ? fruit.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      fruit.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Fruits',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: nuts.text.isNotEmpty ? nuts.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      nuts.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Nuts',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: dry_fruit.text.isNotEmpty ? dry_fruit.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      dry_fruit.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Dry Fruits',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: sprouts.text.isNotEmpty ? sprouts.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      sprouts.text = value!;
                    });
                  },
                  items:[
                    'Regular',
                    'Occasional',
                    'Strictly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sprouts',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      coconut_water.text.isNotEmpty ? coconut_water.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      coconut_water.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Coconut Water',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      fruite_juice.text.isNotEmpty ? fruite_juice.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      fruite_juice.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Fruit Juice',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: vergitable_juice.text.isNotEmpty
                      ? vergitable_juice.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      vergitable_juice.text = value!;
                    });
                  },
                  items: [
                    'Regular',
                    'Occasional',
                    'Stricly no',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Vegetable juice',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      water_intake.text.isNotEmpty ? water_intake.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      water_intake.text = value!;
                    });
                  },
                  items: [
                    'Very Less  ',
                    '6-8 Glasses',
                    '9-12 Glasses',
                    'more than 12 Glasses',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Daily Water Intake',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: daily_planned_diet.text.isNotEmpty
                      ? daily_planned_diet.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      daily_planned_diet.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Daily Planned Diet',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: salt_intake.text.isNotEmpty ? salt_intake.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      salt_intake.text = value!;
                    });
                  },
                  items: [
                    'Heavy',
                    'Low',
                    'Average',
                    'Strictly No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Table Salt Intake',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      sugar_intake.text.isNotEmpty ? sugar_intake.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      sugar_intake.text = value!;
                    });
                  },
                  items: [
                    'Heavy',
                    'Low',
                    'Average',
                    'Strictly No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Sugar Intake',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Regular practice (atleast 5-days a week) :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: regular_practice
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: regular_practice_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  regular_practice_selected.add(disease);
                                } else {
                                  regular_practice_selected.remove(disease);
                                }
                                print(regular_practice_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Herbs intake (atleast 5-days a week) :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: herb_intake
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value:
                              herb_intake_practice_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  herb_intake_practice_selected.add(disease);
                                } else {
                                  herb_intake_practice_selected.remove(disease);
                                }
                                print(herb_intake_practice_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_herb,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Other Herbs',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Fitness Level :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value:
                      lung_capicity.text.isNotEmpty ? lung_capicity.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      lung_capicity.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Lung Capacity',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: spinal.text.isNotEmpty ? spinal.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      spinal.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Spinal Flexibility',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: muscular_strenght.text.isNotEmpty
                      ? muscular_strenght.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      muscular_strenght.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Muscular Strength',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: balance_coordination.text.isNotEmpty
                      ? balance_coordination.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      balance_coordination.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Balance Coordination',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: abdominal_strength.text.isNotEmpty
                      ? abdominal_strength.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      abdominal_strength.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Abdominal Strength',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: lower_back_strength.text.isNotEmpty
                      ? lower_back_strength.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      lower_back_strength.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Lower Back Strength',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: cervical_flexiblity.text.isNotEmpty
                      ? cervical_flexiblity.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      cervical_flexiblity.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Cervical Flexibility',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: shoulder_flexiblity.text.isNotEmpty
                      ? shoulder_flexiblity.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      shoulder_flexiblity.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Shoulder Flexibility',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: hips.text.isNotEmpty ? hips.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      hips.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Hips, Knee & Ankle Mobility',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: lungs_vitallity.text.isNotEmpty
                      ? lungs_vitallity.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      lungs_vitallity.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Good',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Lungs Vitallity',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Immunity :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: immunity
                      .map(
                        (disease) => CheckboxListTile(
                          title: Text(disease),
                          value: immunity_selected.contains(disease),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  immunity_selected.add(disease);
                                } else {
                                  immunity_selected.remove(disease);
                                }
                                print(immunity_selected);
                              }
                            });
                          },
                          activeColor: Color(0xFF14B3B4),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: other_immunity,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.topLeft,
                  // Align the container's contents to the top left
                  child: Text(
                    'Financial Health :-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f1.text.isNotEmpty ? f1.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f1.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Saving habit',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f2.text.isNotEmpty ? f2.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f2.text = value!;
                    });
                  },
                  items: [
                    'Very High',
                    'Average',
                    'Debt free',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Debt Level',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f3.text.isNotEmpty ? f3.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f3.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Emergency fund for 1-year',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f4.text.isNotEmpty ? f4.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f4.text = value!;
                    });
                  },
                  items: [
                    'Poor',
                    'Average',
                    'Excellent',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Credit Score',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f5.text.isNotEmpty ? f5.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f5.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Financial Budget & goals',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f6.text.isNotEmpty ? f6.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f6.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Have A Financial Advicer?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f7.text.isNotEmpty ? f7.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f7.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Have A Pension Plan?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f8.text.isNotEmpty ? f8.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f8.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Have A Term Plan Policy?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f9.text.isNotEmpty ? f9.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f9.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Have A Medi-Claim?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f10.text.isNotEmpty ? f10.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f10.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Can Handle Unexpected Expenses?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: f11.text.isNotEmpty ? f11.text : null,
                  onChanged: (String? value) {
                    setState(() {
                      f11.text = value!;
                    });
                  },
                  items: [
                    'Yes',
                    'No',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Are You Investing?',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: strength,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Strengths',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: weekness,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Weaknesses',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: speed_remark,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Special Remarks',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // Submit form functionality

                    Fluttertoast.showToast(msg: "Health Form Saved!!");
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14B3B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addForm(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "reports": "0",
      "": holistic_counsler,
      "": dob,
    };
    print(data);
    try {
      final response =
          await dio.post(Constant.BASE_URL + "api/addesales", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        if (status == "success") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);
        } else {
          pd.close(delay: 0);
          Utils.showAlertDialog(context, "SOMETHING WENT WRONG !!");

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        }
      } else {
        pd.close(delay: 0);
        Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        throw Exception('Enquiry failed');
      }
    } catch (e) {
      pd.close(delay: 0);
      Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!');
      throw Exception('An error occurred during enquiry');
    }
  }

  Future<void> initaite() async {
    int employeeId = widget.employeeId;
    String? response = await Utils.getStringFromPrefs(Constant.MEMBER_API);

    Utils.printLongString(response! + "1234567890");
    print(employeeId);

    Map<dynamic, dynamic> details = getDetailsById(employeeId, response!);
    centerController.text = details['center'].toString();
    firstNameController.text = details['first_name'].toString();
    lastNameController.text = details['last_name'].toString();
    mobileController.text = details['mobile'].toString();
    alternativeMobileController.text = details['alternative'].toString();
    gender.text = details['gender'].toString();
    profession.text = details['profession'].toString();
    qualification.text = details['qualification'].toString();

    setState(() {});
  }

  String getSelectedDiseasesAsString() {
    return selectedDiseases.join(', ');
  }

  Map<String, dynamic> getDetailsById(int id, String jsonResponseString) {
    try {
      // Print the JSON string before decoding
      Utils.printLongString('JSON Response String: $jsonResponseString');
      String trimmedJson = jsonResponseString.trim();
      Map<String, dynamic> jsonResponse = json.decode(trimmedJson);

      Utils.printLongString(jsonResponse.toString() + "3ew23");

      // Check if 'enquiry' key exists in the response and is a List
      if (jsonResponse.containsKey('enquiry') &&
          jsonResponse['enquiry'] is List) {
        // Find the entry in the 'enquiry' list with the matching 'id'
        var enquiryList = jsonResponse['enquiry'] as List;

        var enquiry = enquiryList.firstWhere(
          (element) => element['id'] == id,
          orElse: () => null,
        );

        // Check if the enquiry with the given id is found
        if (enquiry != null) {
          return {
            'id': enquiry['id'],
            'center': enquiry['center'],
            'first_name': enquiry['first_name'],
            'last_name': enquiry['last_name'],
            'mobile': enquiry['mobile'],
            'alternative': enquiry['alternative'],
            'email': enquiry['email'],
            'country': enquiry['country'],
            'state': enquiry['state'],
            'city': enquiry['city'],
            'address': enquiry['address'],
            'profession': enquiry['profession'],
            'qualification': enquiry['qualification'],
            'age_group': enquiry['age_group'],
            'gender': enquiry['gender'],
            'cordinator': enquiry['cordinator'],
            'source': enquiry['source'],
            'created_by': enquiry['created_by'],
            'created_at': enquiry['created_at'],
            'updated_at': enquiry['updated_at'],
          };
        } else {
          print('Enquiry with id $id not found.');
        }
      } else {
        print('Key "enquiry" is missing or not a List in the JSON response.');
      }
    } catch (e) {
      print('Error decoding JSON: $e');
    }

    // Return an empty map if there was an error or if the id is not found
    return {};
  }
}
