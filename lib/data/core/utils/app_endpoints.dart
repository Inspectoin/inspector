
class AppEndpoints {
  static const String SIGN_IN = "/api/auth/login";
  static const String SIGN_UP = "/api/auth/register";
  static const String REFRESH_TOKEN = "/api/auth/refresh-token";
  static const String GET_MY_PROFILE = "/api/auth/current";
  static const String VRIFY_OTP = "/api/users/verify";
  static const String RESEND = "/api/auth/resend";
  static const String RESET_PASSWORD_REQUEST = "/api/auth/reset-password";
  static const String CONFIRM_RESET_PASSWORD = "/api/auth/password";
  static const String UPDATE_PROFILE = "/api/users/update-profile";
  static const String UPLOAD_PROFILE_IMAGE = "/api/users/upload-profile-image";

  static const String CHANGE_PASSWORD = "/api/users/me/change-password";

  // Incidents

  static const String CREATE_INCIDENT = "/api/incidents";
  static String  GET_INCIDENT(String id)  => "/api/incidents/$id";
  static  const String  GET_MY_INCIDENTS   = "/api/auth/users/me/incidents";
  static  const String  GET_INCIDENTS_TYPE   = "/api/incidents/types";
  static  const String  UPLOAD_INCIDENT_FILE   = "/api/files/upload";





}
