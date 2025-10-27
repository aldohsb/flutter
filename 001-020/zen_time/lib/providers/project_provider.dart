import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zentime/models/project_model.dart';
import 'package:zentime/models/session_model.dart';
import 'package:zentime/services/hive_service.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectModel> _projects = [];
  
  List<ProjectModel> get projects => _projects;
  
  ProjectProvider() {
    loadProjects();
  }
  
  void loadProjects() {
    _projects = HiveService.getAllProjects();
    notifyListeners();
  }
  
  Future<void> addProject({
    required String name,
    String? description,
    required Color color,
    required double dailyTargetHours,
    required double weeklyTargetHours,
  }) async {
    final project = ProjectModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      colorValue: color.value,
      dailyTargetHours: dailyTargetHours,
      weeklyTargetHours: weeklyTargetHours,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    await HiveService.addProject(project);
    loadProjects();
  }
  
  Future<void> updateProject({
    required String projectId,
    required String name,
    String? description,
    required Color color,
    required double dailyTargetHours,
    required double weeklyTargetHours,
  }) async {
    final project = HiveService.getProject(projectId);
    if (project != null) {
      final updatedProject = project.copyWith(
        name: name,
        description: description,
        colorValue: color.value,
        dailyTargetHours: dailyTargetHours,
        weeklyTargetHours: weeklyTargetHours,
        updatedAt: DateTime.now(),
      );
      
      await HiveService.updateProject(updatedProject);
      loadProjects();
    }
  }
  
  Future<void> deleteProject(String projectId) async {
    await HiveService.deleteProject(projectId);
    loadProjects();
  }
  
  ProjectModel? getProject(String projectId) {
    return HiveService.getProject(projectId);
  }
  
  // Statistics
  int getTodayDuration(String projectId) {
    final sessions = HiveService.getProjectSessions(projectId);
    final today = DateTime.now();
    
    return sessions
        .where((session) =>
            session.startTime.year == today.year &&
            session.startTime.month == today.month &&
            session.startTime.day == today.day)
        .fold<int>(0, (sum, session) => sum + session.durationSeconds);
  }
  
  int getWeekDuration(String projectId) {
    final sessions = HiveService.getProjectSessions(projectId);
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDate = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    
    return sessions
        .where((session) => session.startTime.isAfter(startOfWeekDate))
        .fold<int>(0, (sum, session) => sum + session.durationSeconds);
  }
  
  double getTodayProgress(String projectId) {
    final project = getProject(projectId);
    if (project == null || project.dailyTargetHours == 0) return 0;
    
    final todaySeconds = getTodayDuration(projectId);
    final targetSeconds = (project.dailyTargetHours * 3600).round();
    
    return (todaySeconds / targetSeconds).clamp(0.0, 1.0);
  }
  
  double getWeekProgress(String projectId) {
    final project = getProject(projectId);
    if (project == null || project.weeklyTargetHours == 0) return 0;
    
    final weekSeconds = getWeekDuration(projectId);
    final targetSeconds = (project.weeklyTargetHours * 3600).round();
    
    return (weekSeconds / targetSeconds).clamp(0.0, 1.0);
  }
  
  List<SessionModel> getProjectSessions(String projectId) {
    return HiveService.getProjectSessions(projectId);
  }
}