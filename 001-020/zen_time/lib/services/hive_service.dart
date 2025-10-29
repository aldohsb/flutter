import 'package:hive_flutter/hive_flutter.dart';
import 'package:zentime/models/project_model.dart';
import 'package:zentime/models/session_model.dart';
import 'package:zentime/utils/constants.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register Adapters
    Hive.registerAdapter(ProjectModelAdapter());
    Hive.registerAdapter(SessionModelAdapter());
    
    // Open Boxes
    await Hive.openBox<ProjectModel>(AppConstants.projectsBox);
    await Hive.openBox<SessionModel>(AppConstants.sessionsBox);
    await Hive.openBox(AppConstants.settingsBox);
  }
  
  static Box<ProjectModel> get projectsBox => 
      Hive.box<ProjectModel>(AppConstants.projectsBox);
  
  static Box<SessionModel> get sessionsBox => 
      Hive.box<SessionModel>(AppConstants.sessionsBox);
  
  static Box get settingsBox => 
      Hive.box(AppConstants.settingsBox);
  
  // Project CRUD
  static Future<void> addProject(ProjectModel project) async {
    await projectsBox.put(project.id, project);
  }
  
  static Future<void> updateProject(ProjectModel project) async {
    await projectsBox.put(project.id, project);
  }
  
  static Future<void> deleteProject(String projectId) async {
    await projectsBox.delete(projectId);
    // Delete all sessions for this project
    final sessionsToDelete = sessionsBox.values
        .where((session) => session.projectId == projectId)
        .toList();
    for (var session in sessionsToDelete) {
      await session.delete();
    }
  }
  
  static ProjectModel? getProject(String projectId) {
    return projectsBox.get(projectId);
  }
  
  static List<ProjectModel> getAllProjects() {
    return projectsBox.values.toList();
  }
  
  // Session CRUD
  static Future<void> addSession(SessionModel session) async {
    await sessionsBox.put(session.id, session);
  }
  
  static Future<void> updateSession(SessionModel session) async {
    await sessionsBox.put(session.id, session);
  }
  
  static Future<void> deleteSession(String sessionId) async {
    await sessionsBox.delete(sessionId);
  }
  
  static SessionModel? getSession(String sessionId) {
    return sessionsBox.get(sessionId);
  }
  
  static List<SessionModel> getProjectSessions(String projectId) {
    return sessionsBox.values
        .where((session) => session.projectId == projectId)
        .toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }
  
  static List<SessionModel> getAllSessions() {
    return sessionsBox.values.toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }
  
  // Settings
  static Future<void> saveSetting(String key, dynamic value) async {
    await settingsBox.put(key, value);
  }
  
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue);
  }
}