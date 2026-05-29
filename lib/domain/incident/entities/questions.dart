

class InspectionQuestion {
  final String id;
  final String question;
  final String type;
   String? answer;
   int files=0;
   int images=0;


  InspectionQuestion({
    required this.id,
    required this.question,
    required this.type,
    this.answer,
  });
}

class QuestionCategory {
  final String category;
  final List<InspectionQuestion> questions;

  QuestionCategory({
    required this.category,
    required this.questions,
  });
}

class InspectionForm {
  final String establishment;
  final List<QuestionCategory> inspectionQuestions;
  final Map<String, String> metadata;

  InspectionForm({
    required this.establishment,
    required this.inspectionQuestions,
    required this.metadata,
  });
}

final inspectionForm = InspectionForm(
  establishment: "فندق ميرة السد",
  inspectionQuestions: [
    QuestionCategory(
      category: "النظافة العامة",
      questions: [
        InspectionQuestion(
          id: "CLN-001",
          question: "هل يتم تنظيف الممرات والمداخل بانتظام وبمواد معتمدة؟",
          type: "نعم/لا",
        ),
        InspectionQuestion(
          id: "CLN-002",
          question:
          "هل توجد حاويات نفايات موزعة في المناطق العامة ويتم تفريغها بانتظام؟",
          type: "نعم/لا",
        ),
        InspectionQuestion(
          id: "CLN-003",
          question:
          "هل يتم تنظيف دورات المياه العامة بشكل دوري وفق جدول زمني محدد؟",
          type: "نعم/لا",
        ),
        InspectionQuestion(
          id: "CLN-004",
          question:
          "هل أدوات التنظيف محفوظة بطريقة آمنة وبعيدة عن أماكن النزلاء؟",
          type: "نعم/لا",
        ),
      ],
    ),
    QuestionCategory(
      category: "الغرف",
      questions: [
        InspectionQuestion(
          id: "RM-001",
          question: "هل الغرف نظيفة وخالية من الروائح غير المرغوبة؟",
          type: "نعم/لا",
        ),
        InspectionQuestion(
          id: "RM-002",
          question:
          "هل المفارش والمناشف مغسولة ونظيفة وتُبدّل بانتظام؟",
          type: "نعم/لا",
          answer: "عال",
        ),
        InspectionQuestion(
          id: "RM-003",
          question:
          "هل أجهزة التكييف تعمل بشكل جيد وخالية من الأتربة؟",
          type: "نعم/لا",
        ),
        InspectionQuestion(
          id: "RM-004",
          question:
          "هل الأثاث في الغرف بحالة جيدة ولا توجد تلفيات أو بقع واضحة؟",
          type: "نعم/لا",
          answer: "متوسط",
        ),
        InspectionQuestion(
          id: "RM-005",
          question: "هل يتم تنظيف الحمامات داخل الغرف بشكل يومي؟",
          type: "نعم/لا",
        ),
      ],
    ),
  ],
  metadata: {
    "created_for": "المفتش الميداني",
    "inspection_department": "مرافق الإيواء السياحي",
    "region": "منطقة مكة المكرمة",
    "city": "مكة المكرمة",
    "creation_date": "2025-10-20",
  },
);




final inspectionFormEn = InspectionForm(
  establishment: "Mira Al-Sadd Hotel",
  inspectionQuestions: [
    QuestionCategory(
      category: "General Cleanliness",
      questions: [
        InspectionQuestion(
          id: "CLN-001",
          question:
          "Are corridors and entrances cleaned regularly using approved materials?",
          type: "Yes/No",
        ),
        InspectionQuestion(
          id: "CLN-002",
          question:
          "Are waste bins distributed in public areas and emptied regularly?",
          type: "Yes/No",
        ),
        InspectionQuestion(
          id: "CLN-003",
          question:
          "Are public restrooms cleaned periodically according to a fixed schedule?",
          type: "Yes/No",
          answer: "High",
        ),
        InspectionQuestion(
          id: "CLN-004",
          question:
          "Are cleaning tools stored safely and away from guest areas?",
          type: "Yes/No",
          answer: "Medium",
        ),
      ],
    ),
    QuestionCategory(
      category: "Guest Rooms",
      questions: [
        InspectionQuestion(
          id: "RM-001",
          question: "Are the rooms clean and free from unpleasant odors?",
          type: "Yes/No",
          answer: "High",
        ),
        InspectionQuestion(
          id: "RM-002",
          question:
          "Are bed linens and towels clean, washed, and replaced regularly?",
          type: "Yes/No",
          answer: "High",
        ),
        InspectionQuestion(
          id: "RM-003",
          question: "Are air conditioning units functioning well and dust-free?",
          type: "Yes/No",
          answer: "Medium",
        ),
        InspectionQuestion(
          id: "RM-004",
          question:
          "Is the room furniture in good condition with no visible damage or stains?",
          type: "Yes/No",
          answer: "Medium",
        ),
        InspectionQuestion(
          id: "RM-005",
          question: "Are the bathrooms inside rooms cleaned daily?",
          type: "Yes/No",
          answer: "High",
        ),
      ],
    ),
  ],
  metadata: {
    "created_for": "Field Inspector",
    "inspection_department": "Hospitality Facilities Department",
    "region": "Makkah Region",
    "city": "Makkah",
    "creation_date": "2025-10-20",
  },
);
