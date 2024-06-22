import 'dart:ffi';
import 'dart:math';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/features/jadwal_kelas/jadwal_hari_ini.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/providers/jadwals_provider.dart';
import 'package:sijakol/response/jadwal_response.dart';
import 'package:sijakol/models/jadwal_mingguan_bulanan_model.dart';

class JadwalMingguanBulananScreen extends StatefulWidget {
  const JadwalMingguanBulananScreen({super.key});

  @override
  State<JadwalMingguanBulananScreen> createState() => _JadwalMingguanBulananScreenState();
}

class _JadwalMingguanBulananScreenState extends State<JadwalMingguanBulananScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<String> daysOfWeek = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<JadwalProvider>(context, listen: false).getjadwalMingguanBulanan(
        '2024-01'
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Provider.of<JadwalProvider>(context, listen: false).getjadwalHariIni(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwalProvider = Provider.of<JadwalProvider>(context);

    return SafeArea(child: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 16, right: 10, bottom: 16),
              child: Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
                  SizedBox(width: 16),
                  Text(
                      "Jadwal Mingguan & Bulanan",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                      )
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: ColorPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    )
                  ]
              ),
            ),
            Expanded(child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                child: BulananChild(),
              ),
            ))
          ],
        ),
      ),
    ));
  }
}

class BulananChild extends StatefulWidget {
  const BulananChild({super.key});

  @override
  State<BulananChild> createState() => _BulananChildState();
}

class _BulananChildState extends State<BulananChild> {
  int _weekNumber = 1;
  String _weekName = 'Minggu 1';
  int _selectedIndex = 0;
  DateTime? _selectedDate;
  List<List<DateTime>> _weeks = [];
  int _currentWeekIndex = 0;
  String _selectedDay = '';
  String _selectedDayNumber = '';
  int _selectedDayIndex = 0;

  bool isFirstEmpty = false;

  String? _selectedMonth = 'Januari';
  int? _selectedMonthNumber = 1;

  var lengthOfJadwal = 0.0;

  final Map<String, int> _months = {
    'Januari': 1,
    'Februari': 2,
    'Maret': 3,
    'April': 4,
    'Mei': 5,
    'Juni': 6,
    'Juli': 7,
    'Agustus': 8,
    'September': 9,
    'Oktober': 10,
    'November': 11,
    'Desember': 12,
  };

  final Map<String, String> monthsInIndonesia = {
    'January': 'Januari',
    'February': 'Februari',
    'March': 'Maret',
    'April': 'April',
    'May': 'Mei',
    'June': 'Juni',
    'July': 'Juli',
    'August': 'Agustus',
    'September': 'September',
    'October': 'Oktober',
    'November': 'November',
    'December': 'Desember',
  };

  Map<String, String> daysInIndonesian = {
    'Sunday':'Minggu',
    'Monday':'Senin',
    'Tuesday':'Selasa',
    'Wednesday':'Rabu',
    'Thursday':'Kamis',
    'Friday':'Jumat',
    'Saturday':'Sabtu'
  };

  final Map<String, int> _daysInIndonesian = {
    'Senin': DateTime.monday,
    'Selasa': DateTime.tuesday,
    'Rabu': DateTime.wednesday,
    'Kamis': DateTime.thursday,
    'Jumat': DateTime.friday,
    'Sabtu': DateTime.saturday,
    'Minggu': DateTime.sunday,
  };

  final Map<int, String> _daysInIndonesianReverse = {
    DateTime.monday: 'Senin',
    DateTime.tuesday: 'Selasa',
    DateTime.wednesday: 'Rabu',
    DateTime.thursday: 'Kamis',
    DateTime.friday: 'Jumat',
    DateTime.saturday: 'Sabtu',
    DateTime.sunday: 'Minggu',
  };

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Provider.of<JadwalProvider>(context, listen: false).getjadwalHariIni();
    _updateWeekdays();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Provider.of<JadwalProvider>(context, listen: false).getjadwalHariIni(2);
    }
  }

  List<List<DateTime>> _getWeekdaysOfMonth(int year, int month) {
    List<List<DateTime>> weeks = [];
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    DateTime currentWeekStart = firstDayOfMonth;
    while (currentWeekStart.weekday != DateTime.monday) {
      currentWeekStart = currentWeekStart.add(Duration(days: -1));
    }

    while (currentWeekStart.isBefore(lastDayOfMonth) || currentWeekStart.isAtSameMomentAs(lastDayOfMonth)) {
      List<DateTime> week = [];
      DateTime currentDay = currentWeekStart;
      for (int i = 0; i < 5; i++) {
        if (currentDay.month == month && currentDay.weekday != DateTime.saturday && currentDay.weekday != DateTime.sunday) {
          week.add(currentDay);
        }
        currentDay = currentDay.add(Duration(days: 1));
      }
      weeks.add(week);
      currentWeekStart = currentWeekStart.add(Duration(days: 7));
    }

    return weeks;
  }

  void _nextWeek() {
    setState(() {
      if (_weeks.isNotEmpty && _currentWeekIndex <= _weeks.length - 1) {
        if (_currentWeekIndex == _weeks.length - 1) {
          _currentWeekIndex = _weeks.length - 1;
        }else {
          _currentWeekIndex++;
        }
      }
      _weekName = 'Minggu ${_currentWeekIndex + 1}';
      print('index $_currentWeekIndex');
    });
  }

  void _previousWeek() {
    setState(() {
      if (_currentWeekIndex >= 0) {
        if (_currentWeekIndex == 0) {
          _currentWeekIndex = 0;
        }else {
          _currentWeekIndex--;
        }
      }
      _weekName = 'Minggu ${_currentWeekIndex + 1}';
      print('index $_currentWeekIndex');
    });
  }

  void _adjustDayIndex(JadwalProvider jadwalProvider) {
    if (_currentWeekIndex < _weeks.length && _weeks[_currentWeekIndex].isEmpty) {
      _nextWeek();
      _previousWeek();
      _weekName = 'Minggu ${_currentWeekIndex + 1}';
      _weeks.removeAt(_currentWeekIndex);
    }

    if (_selectedDayIndex >= _weeks[_currentWeekIndex].length) {
      _selectedDayIndex = _weeks[_currentWeekIndex].length - 1;
      _selectedDayIndex = _weeks[_currentWeekIndex].length - 1;
      _selectedDay = daysInIndonesian[DateFormat('EEEE').format(_weeks[_currentWeekIndex][_weeks[_currentWeekIndex].length - 1])] ?? '-';
      _setSelectedIndex(_weeks[_currentWeekIndex].length - 1);
    }

    while (_selectedDayIndex > 0 &&
        (jadwalProvider.jadwalMingguanBulananData.length == null ||
            _currentWeekIndex >= jadwalProvider.jadwalMingguanBulananData.length ||
            jadwalProvider.jadwalMingguanBulananData[_currentWeekIndex].jadwalData == null ||
            _selectedDayIndex >= jadwalProvider.jadwalMingguanBulananData[_currentWeekIndex].jadwalData!.length)) {
      _selectedDayIndex--;

      if (_selectedDayIndex < 0) {
        _selectedDayIndex = 0;
        break;
      }
    }
  }

  Future<void> _updateWeekdays() async {
    int month = _months[_selectedMonth]!;
    setState(() {
      _weeks = _getWeekdaysOfMonth(DateTime.now().year, month);
      _currentWeekIndex = 0;
      _weekName = 'Minggu 1';
    });
  }

  Future<dynamic> calculateLength(JadwalProvider jadwalProvider) async {
    lengthOfJadwal = jadwalProvider.jadwalMingguanBulananData[_currentWeekIndex].jadwalData?[_selectedDayIndex].jadwal?.length.toDouble() ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final jadwalProvider = Provider.of<JadwalProvider>(context);
    _adjustDayIndex(jadwalProvider);
    calculateLength(jadwalProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.only(left: 16, right: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: ColorText),
            borderRadius: BorderRadius.circular(10)
          ),
          child: DropdownButton<String>(
            value: _selectedMonth,
            onChanged: (String? newValue) {
              setState(() {
                _selectedMonth = newValue!;
                // Call the provider's method here
                String monthYear = '${DateTime.now().year}-${_months[_selectedMonth]!.toString().padLeft(2, '0')}';
                Provider.of<JadwalProvider>(context, listen: false).getjadwalMingguanBulanan(monthYear);
                _updateWeekdays();
              });
            },
            items: _months.keys.map<DropdownMenuItem<String>>((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(key),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.only(top: 16, left: 10, right: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => {
                  // _weekNumber -= 1,
                  // _changeWeek(),
                  _previousWeek()
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorText
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 25,
                  ),
                ),
              ),
              Container(
                child: Text(
                  _weekName,
                  style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => {
                  // _weekNumber += 1,
                  // _changeWeek(),
                  _nextWeek()
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorText
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
            margin: EdgeInsets.only(top: 16, left: 10, right: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: _weeks[_currentWeekIndex].length >= 4 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: List.generate(_weeks[_currentWeekIndex].length, (index) {
                return GestureDetector(
                  onTap: () {
                    _selectedDayIndex = index;
                    _selectedDay = daysInIndonesian[DateFormat('EEEE').format(_weeks[_currentWeekIndex][index])] ?? '-';
                    _setSelectedIndex(index);
                  },
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 25, left: 8, right: 8, bottom: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
                        color: _selectedIndex != index ? Colors.transparent : ColorMenu
                    ),
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            DateFormat('dd').format(_weeks[_currentWeekIndex][index]),
                            style: GoogleFonts.roboto(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            daysInIndonesian[DateFormat('EEEE').format(_weeks[_currentWeekIndex][index])] ?? '-',
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            )
        ),
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              '${daysInIndonesian[DateFormat('EEEE').format(_weeks[_currentWeekIndex][_selectedDayIndex])]}, ${DateFormat('dd').format(_weeks[_currentWeekIndex][_selectedDayIndex])} ${monthsInIndonesia[DateFormat('MMMM').format(_weeks[_currentWeekIndex][_selectedDayIndex])]} ${DateFormat('yyyy').format(_weeks[_currentWeekIndex][_selectedDayIndex])}',
              style: GoogleFonts.poppins(
                  color: ColorTextDark,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
              textAlign: TextAlign.left,
            )
        ),
        Container(
          width: double.infinity,
          height: (lengthOfJadwal.toInt()) != 0 ? 215 * lengthOfJadwal - ((lengthOfJadwal - 1) * 60) : 300,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container(
                child: (lengthOfJadwal.toInt()) != 0 ? ListView.builder(
                  controller: _scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ChildBulananMingguan(
                        index,
                        jadwalProvider.jadwalMingguanBulananData[_currentWeekIndex].jadwalData?[_selectedDayIndex].jadwal?[index] ?? InnerJadwalData(),
                    );
                  },
                  itemCount: lengthOfJadwal.toInt(),
                ) : Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Center(
                    child: Text(
                      'Belum ada jadwal bulan ini. Silahkan hubungi walikelas',
                      style: GoogleFonts.poppins(
                        color: ColorTextDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeWeek(){
    // setState(() {
    //   if (_weekNumber <= 0){
    //     _weekNumber = 1;
    //   }else if (_weekNumber >=4) {
    //     _weekNumber = 4;
    //   }
    //   _weekName = 'Minggu $_weekNumber';
    // });
  }

}


class ChildBulananMingguan extends StatelessWidget {

  int index = 0;
  InnerJadwalData? jadwalData = InnerJadwalData();

  ChildBulananMingguan(int index, InnerJadwalData jadwalData) {
    this.index = index;
    this.jadwalData = jadwalData;
  }

  var colors = [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  MaterialColor _setColors(String pelajaran) {
    if (pelajaran == 'IPA') {
      return colors[0];
    } else if (pelajaran == 'IPS') {
      return colors[1];
    } else if (pelajaran == 'Matematika') {
      return colors[2];
    } else if (pelajaran == 'B. Indonesia') {
      return colors[3];
    } else if (pelajaran == 'B. Inggris') {
      return colors[4];
    } else if (pelajaran == 'Seni Budaya') {
      return colors[5];
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: _setColors(jadwalData?.mata_pelajaran ?? "-"),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )
                ]
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8,top: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  jadwalData?.mata_pelajaran ?? "Tidak ada",
                                  style: GoogleFonts.poppins(
                                      color: ColorTextDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      '${jadwalData?.waktu_mulai ?? '00:00'} - ${jadwalData?.waktu_selesai ?? '00:00'}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      jadwalData?.guru_pengajar ?? 'Tidak ada',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.hourglass_bottom,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      jadwalData?.durasi ?? '0 Min',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
