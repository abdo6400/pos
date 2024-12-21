class EndPoints {
  // Base URL
  static const String baseUrl = 'https://online-shop-yok5.onrender.com/';
  static const String prefixToken = 'Bearer';

  // Base assets URLs
  static const String sourceUrlVideo =
      'https://res.cloudinary.com/duhe9gubt/video/upload/';
  static const String sourceUrlImage =
      'https://res.cloudinary.com/duhe9gubt/image/upload/';

  // API main Endpoints
  static const String category = 'categories';
  static const String course = 'courses';
  static const String section = 'sections';
  static const String lesson = 'lessons';
  static const String coupon = 'coupons';
  static const String video = 'videos';
  static const String document = 'documents';
  static const String level = 'levels';
  static const String payment = 'payments';
  static const String user = 'users';
  static const String quiz = 'quizzes';
  static const String question = 'questions';

  // Auth Endpoints
  static const String register = '${user}/register';
  static const String checkEmail = '${user}/check-email';
  static const String resendCode = '${user}/resend-code';
  static const String forgetPassword = '${user}/forget-password';
  static const String verifyEmail = '${user}/verify-email';
  static const String resetPassword = '${user}/reset-password';
  static const String login = '${user}/login';
  static const String refresh = '${user}/refresh';
  static const String currentUser = '${user}/current-user';
  static const String changePassword = '${user}/change-password';
  static const String logout = '${user}/logout';

  // Coupon Endpoints
  static const String getCouponByCode = '${coupon}/code';

  // Course Endpoints
  static String getCourse(String id) => '${course}/$id';
  static const String updateWatchLessonVideo = '${course}/lessons/watch';

  // Enrollment Endpoints
  static const String getUserEnrollments = '${user}/my-courses';
  static String getEnrollmentCourse(String id) => '${user}/my-courses/$id';

  // Lesson Endpoints
  static String getAllNotes(String id) => '${lesson}/$id/notes';
  static String addNote(String lessonId) => '${lesson}/$lessonId/notes';
  static String deleteNote(String id) => '${lesson}/notes/$id';
  static String updateNote(String noteId) => '${lesson}/notes/$noteId';

  static String getAllQuestions(String id, int page, int limit) =>
      '${lesson}/$id/questions?page=$page&limit=$limit';
  static String addQuestion(String lessonId) =>
      '${lesson}/$lessonId/questions';
  static String updateQuestion(String questionId) =>
      '${lesson}/questions/$questionId';
  static String deleteQuestion(String id) => '${lesson}/questions/$id';
  
  static String getAllAnswers(String questionId, int page, int limit) =>
      '${lesson}/questions/$questionId/answers?page=$page&limit=$limit';
  static String addAnswer(String lessonQuestionId) =>
      '${lesson}/questions/$lessonQuestionId/answers';
  static String updateAnswer(String answerId) => '${lesson}/answers/$answerId';
  static String deleteAnswer(String id) => '${lesson}/answers/$id';

  // Level Endpoints
  static const String getLevels = level;
  static String getLevel(String id) => '${level}/$id';

  // Payment Endpoints
  static const String generateInvoice = '${payment}/generate-invoice';
  static const String generateWalletInvoice =
      '${payment}/generate-wallet-invoice';
  static const String getAllInvoices = payment;
  static const String payWithWallet = '${payment}/pay-with-wallet';
  static const String chargeCode = '${payment}/charge-code';

  // Quiz Endpoints
  static String getQuiz(String id) => '${quiz}/$id';
  static String addQuizResult(String quizId) => '${quiz}/results/$quizId';
  static String getQuizzes(int id) => '${quiz}?id=$id';
} 