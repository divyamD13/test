class Pdf{
  final String department;
  final  int semester;
  final String title;
  final String year;
  final String teacher;
  final String category;
  

  Pdf({required this.department,
   required this.title,
   required this.year, 
   required this.teacher, 
   required this.semester,
   required this.category,
   }) ;
}
// enum Category{
//   Notes,
//   PYQs,
//   Quiz
// }

List pdf=[
  Pdf(department: 'ECE', semester: 5,title: 'IOT and Embedded System', year: '2020',category: "Notes", teacher: 'Mr. Suraj'),
  Pdf(department: 'CSE', semester: 4,title: 'Operating System', year: '2021',category:"Quiz", teacher: 'Ms. Pradeep Biswal'),
  Pdf(department: 'MNC', semester: 3,title: 'Object Oriented Programming', year: '2022',category: "PYQs", teacher: 'Mr. Dilip Choubey'),
  Pdf(department: 'MAE', semester: 2,title: 'Engineering Physics', year: '2023',category:"Notes", teacher: 'Mr. Abhinav Gautam'),
  Pdf(department: 'CSE', semester: 6,title: 'Computer Networks', year: '2023',category: "PYQs", teacher: 'Mrs. Tejhaswini M')
];