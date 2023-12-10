import 'package:Abshr/screens/imports.dart';

class TestimonialList extends StatelessWidget {
  final List<Testimonial> testimonials;

  const TestimonialList({super.key, required this.testimonials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 100),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: testimonials.length,
          itemBuilder: (context, index) {
            return Container(
              width: 400,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppVariables.themeColor, // You need to define themeColor
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(testimonials[index].imagePath),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testimonials[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppVariables
                                  .textcolor, // You need to define textcolor
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[800]),
                              const SizedBox(width: 5),
                              Text(
                                testimonials[index].rating.toString(),
                                style: const TextStyle(
                                  color: AppVariables
                                      .textcolor, // You need to define textcolor
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    testimonials[index].message,
                    style: const TextStyle(
                      color: AppVariables
                          .textcolor, // You need to define textcolor
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String message;
  final String imagePath;
  final double rating;

  Testimonial(this.name, this.message, this.imagePath, this.rating);
}

List<Testimonial> _testimonials = [
  Testimonial(
      'سارة',
      'خدمة رائعة وفعّالة! تم تقديم الخدمة في الوقت المحدد، والفني كان محترفًا للغاية',
      'assets/1.jpg',
      4.5),
  Testimonial(
      'نورة',
      'تجربتي كانت جيدة بشكل عام. كان الفني مهذبًا وماهرًا، ولكن كان هناك بعض التأخير في الوصول إلى الموعد المحدد',
      'assets/1.jpg',
      5),
  Testimonial(
      'علي',
      'تجربتي كانت مقبولة. الخدمة تمت بشكل جيد، ولكن الفني لم يكن متساهلاً في التوضيحات حول الصيانة التي تمت.',
      'assets/1.jpg',
      5.0),
  Testimonial(
      'فاطمة',
      'لفني كان متفهمًا وقام بعمل رائع. فقط هناك بعض التحسينات البسيطة في عملية الحجز يمكن النظر فيها.',
      'assets/1.jpg',
      3.0),
  Testimonial(
      'محمد',
      'Tتم تقديم الخدمة بشكل جيد وكان الفني محترفًا. فقط هناك تأخير طفيف في الوصول',
      'assets/1.jpg',
      5.0),
  Testimonial(
      'يوسف',
      'الخدمة كانت مقبولة جدًا، ولكن يمكن تحسين التنسيق والتواصل مع العملاء لتحديد المواعيد.',
      'assets/1.jpg',
      5.0),

  // Add more testimonials as needed
];
List<Testimonial> getTestimonials() {
  return _testimonials;
}
