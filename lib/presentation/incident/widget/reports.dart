

class Report {
  final String id;
  final int reportNumber;
  final String title;
  final String facilityName;
  final String description;
  final String status;
  final String lastUpdate;
  final String severity;
  final String location;

  Report({
    required this.id,
    required this.reportNumber,
    required this.title,
    required this.facilityName,
    required this.description,
    required this.status,
    required this.lastUpdate,
    required this.severity,
    required this.location,
  });
}

final List<Report> reports = [
  Report(
    id: '1',
    reportNumber: 20001,
    title: 'نقص نظافة الحمامات',
    facilityName: 'فندق ميرة السد',
    description:
    'الحمامات كانت قذرة جداً والرائحة كريهة، الماء لا يخرج من الحوض بشكل صحيح. طلبت من الإدارة تنظيفها لكن لم يحدث شيء',
    status: 'pending',
    lastUpdate: '2024-01-15',
    severity: 'high',
    location: 'منطقة الرياض، الرياض',
  ),
  Report(
    id: '2',
    reportNumber: 20002,
    title: 'مخالفة شهادات السلامة',
    facilityName: 'فندق هيلتون جدة',
    description:
    'لاحظت أن شهادات السلامة منتهية الصلاحية منذ 6 أشهر، هذا خطر على الضيوف. يجب تجديدها فوراً',
    status: 'active',
    lastUpdate: '2024-01-18',
    severity: 'critical',
    location: 'منطقة مكة المكرمة، جدة',
  ),
  Report(
    id: '3',
    reportNumber: 20003,
    title: 'عدم توفر مرشدين سياحيين',
    facilityName: 'نزل الباحة السياحي',
    description:
    'وعدونا بمرشد سياحي للجولات لكن لم يجدوا أحد متاح، اضطررنا للذهاب بمفردنا وفقدنا الكثير من المعلومات المهمة',
    status: 'active',
    lastUpdate: '2024-01-21',
    severity: 'medium',
    location: 'منطقة الباحة، الباحة',
  ),
  Report(
    id: '4',
    reportNumber: 20004,
    title: 'مشاكل في التكييف',
    facilityName: 'فندق الشيراتون الدمام',
    description:
    'التكييف لا يعمل في غرفتنا، الجو حار جداً ولا نستطيع النوم. اشتكينا 3 مرات ولم يأتوا لإصلاحه',
    status: 'active',
    lastUpdate: '2024-01-24',
    severity: 'high',
    location: 'منطقة الشرقية، الدمام',
  ),
  Report(
    id: '5',
    reportNumber: 20005,
    title: 'عدم نظافة المطعم',
    facilityName: 'فندق نوفوتيل الطائف',
    description:
    'المطعم غير نظيف، الأطباق عليها بقايا طعام، والطاولات لزجة. لم نستطع تناول الطعام هناك',
    status: 'active',
    lastUpdate: '2024-01-27',
    severity: 'high',
    location: 'منطقة مكة المكرمة، الطائف',
  ),
  Report(
    id: '6',
    reportNumber: 20006,
    title: 'مخالفة في إدارة النفايات',
    facilityName: 'فندق راديسون بلو أبها',
    description:
    'أكياس النفايات ملقاة في الممرات والرائحة كريهة، هذا غير مقبول في فندق بهذا المستوى',
    status: 'active',
    lastUpdate: '2024-01-30',
    severity: 'medium',
    location: 'منطقة عسير، أبها',
  ),
  Report(
    id: '7',
    reportNumber: 20007,
    title: 'عدم توفر طفايات الحريق',
    facilityName: 'فندق إنتركونتيننتال الرياض',
    description:
    'بحثت عن طفاية حريق في الطابق ولم أجد أي واحدة، هذا خطر جداً في حالة حدوث حريق',
    status: 'active',
    lastUpdate: '2024-02-02',
    severity: 'critical',
    location: 'منطقة الرياض، الرياض',
  ),
  Report(
    id: '8',
    reportNumber: 20008,
    title: 'مشاكل في الإنترنت',
    facilityName: 'فندق جراند حياة مكة',
    description:
    'الواي فاي ضعيف جداً ولا يعمل في معظم الأوقات، احتجت للعمل ولم أستطع الاتصال بالإنترنت',
    status: 'active',
    lastUpdate: '2024-02-05',
    severity: 'low',
    location: 'منطقة مكة المكرمة، مكة المكرمة',
  ),
  Report(
    id: '9',
    reportNumber: 20009,
    title: 'عدم نظافة الغرف',
    facilityName: 'فندق موفنبيك المدينة',
    description:
    'الغرفة لم تكن نظيفة عند وصولنا، المفروشات متسخة والشعر في الحمام. غير مقبول أبداً',
    status: 'pending',
    lastUpdate: '2024-02-08',
    severity: 'high',
    location: 'منطقة المدينة المنورة، المدينة المنورة',
  ),
  Report(
    id: '10',
    reportNumber: 20010,
    title: 'مخالفة في نظام الحجز',
    facilityName: 'فندق فورسيزونز الرياض',
    description:
    'حجزت غرفة مزدوجة لكن وجدت سرير واحد فقط، النظام لا يعمل بشكل صحيح والموظفون لا يعرفون كيف يحلون المشكلة',
    status: 'active',
    lastUpdate: '2024-02-10',
    severity: 'medium',
    location: 'منطقة الرياض، الرياض',
  ),

];

final List<Report> reportsEn = [
  Report(
    id: '1',
    reportNumber: 20001,
    title: 'Lack of Bathroom Cleanliness',
    facilityName: 'Mira Al-Saad Hotel',
    description:
    'The bathrooms were very dirty and smelled bad. The water was not draining properly from the sink. I asked the management to clean them, but nothing happened.',
    status: 'pending',
    lastUpdate: '2024-01-15',
    severity: 'high',
    location: 'Riyadh Region, Riyadh',
  ),
  Report(
    id: '2',
    reportNumber: 20002,
    title: 'Safety Certificate Violation',
    facilityName: 'Hilton Jeddah Hotel',
    description:
    'I noticed that the safety certificates have expired for 6 months. This is dangerous for guests and should be renewed immediately.',
    status: 'active',
    lastUpdate: '2024-01-18',
    severity: 'critical',
    location: 'Makkah Region, Jeddah',
  ),
  Report(
    id: '3',
    reportNumber: 20003,
    title: 'No Tourist Guides Available',
    facilityName: 'Al-Baha Tourist Inn',
    description:
    'We were promised a tour guide for our trips, but no one was available. We had to go alone and missed a lot of important information.',
    status: 'active',
    lastUpdate: '2024-01-21',
    severity: 'medium',
    location: 'Al-Baha Region, Al-Baha',
  ),
  Report(
    id: '4',
    reportNumber: 20004,
    title: 'Air Conditioning Problems',
    facilityName: 'Sheraton Dammam Hotel',
    description:
    'The air conditioning in our room is not working. The weather is very hot, and we can’t sleep. We complained three times, but no one came to fix it.',
    status: 'active',
    lastUpdate: '2024-01-24',
    severity: 'high',
    location: 'Eastern Region, Dammam',
  ),
  Report(
    id: '5',
    reportNumber: 20005,
    title: 'Unclean Restaurant',
    facilityName: 'Novotel Taif Hotel',
    description:
    'The restaurant is not clean, dishes still had food residue, and the tables were sticky. We couldn’t eat there.',
    status: 'active',
    lastUpdate: '2024-01-27',
    severity: 'high',
    location: 'Makkah Region, Taif',
  ),
  Report(
    id: '6',
    reportNumber: 20006,
    title: 'Waste Management Violation',
    facilityName: 'Radisson Blu Abha Hotel',
    description:
    'Garbage bags were thrown in the hallways, and there was a bad smell. This is unacceptable for a hotel of this level.',
    status: 'active',
    lastUpdate: '2024-01-30',
    severity: 'medium',
    location: 'Asir Region, Abha',
  ),
  Report(
    id: '7',
    reportNumber: 20007,
    title: 'Lack of Fire Extinguishers',
    facilityName: 'InterContinental Riyadh Hotel',
    description:
    'I looked for a fire extinguisher on the floor and couldn’t find any. This is very dangerous in case of a fire.',
    status: 'active',
    lastUpdate: '2024-02-02',
    severity: 'critical',
    location: 'Riyadh Region, Riyadh',
  ),
  Report(
    id: '8',
    reportNumber: 20008,
    title: 'Internet Problems',
    facilityName: 'Grand Hyatt Makkah Hotel',
    description:
    'The Wi-Fi is very weak and doesn’t work most of the time. I needed it for work but couldn’t connect to the internet.',
    status: 'active',
    lastUpdate: '2024-02-05',
    severity: 'low',
    location: 'Makkah Region, Makkah',
  ),
  Report(
    id: '9',
    reportNumber: 20009,
    title: 'Unclean Rooms',
    facilityName: 'Mövenpick Madinah Hotel',
    description:
    'The room was not clean when we arrived. The furniture was dirty, and there was hair in the bathroom. Completely unacceptable.',
    status: 'pending',
    lastUpdate: '2024-02-08',
    severity: 'high',
    location: 'Madinah Region, Madinah',
  ),
  Report(
    id: '10',
    reportNumber: 20010,
    title: 'Booking System Violation',
    facilityName: 'Four Seasons Riyadh Hotel',
    description:
    'I booked a double room but found only one bed. The system is not working properly, and the staff didn’t know how to solve the issue.',
    status: 'active',
    lastUpdate: '2024-02-10',
    severity: 'medium',
    location: 'Riyadh Region, Riyadh',
  ),
];
