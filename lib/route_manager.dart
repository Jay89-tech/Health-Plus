import 'package:flutter/material.dart';
import 'package:health_plus/Views/admin_view_appointment.dart';
import 'package:health_plus/Views/appointment_view.dart';
import 'package:health_plus/Views/edit_profile.dart';
import 'package:health_plus/Views/init.dart';
import 'package:health_plus/Views/new_appointment.dart';
import 'package:health_plus/Views/password_reset.dart';
import 'package:health_plus/Views/shell.dart';
import 'package:health_plus/Views/login.dart';
import 'package:health_plus/Views/register.dart';

class RoutesGenerator {
  static const String initialPage = '/';
  static const String loginPage = '/login';
  static const String registerPage = '/registerPage';
  static const String passwordResetPage = '/PasswordReset';
  static const String homePage = '/HomePage';
  static const String myAppointmentsPage = '/MyAppointmentsPage';
  static const String profileEditPage = '/profileEditPage';
  static const String newAppointmentPage = '/newAppointmentPage';
  static const String appointmentViewPage = '/AppointmentViewPage';
  static const String adminAppointmentViewPage = '/adminAppointmentViewPage';

  RoutesGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPage:
        return MaterialPageRoute(
          builder: (context) => const InitPage(),
        );
      // case appointmentBookingPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const AppointmentBookingPage(),
      //   );
      case adminAppointmentViewPage:
        return MaterialPageRoute(
          builder: (context) => const AdminAppointmentView(),
        );
      case appointmentViewPage:
        return MaterialPageRoute(
          builder: (context) => const AppointmentView(),
        );
      case newAppointmentPage:
        return MaterialPageRoute(
          builder: (context) => const NewAppointment(),
        );
      case profileEditPage:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );
      case passwordResetPage:
        return MaterialPageRoute(
          builder: (context) => const PasswordReset(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const Shell(),
        );
      //========================== Patient Screens ===========================================
      // case patientRegistrationPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const PatientRegistrationPage(),
      //   );

      //========================== Admin Screens =============================================

      // case adminAppointmentViewPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const AdminAppointmentViewPage(),
      //   );
      // case adminPanelPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const AdminPanelPage(),
      //   );
      // case adminRegisterPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const AdminRegisterPage(),
      //   );
      default:
        throw const FormatException('Page was not found');
    }
  }
}
