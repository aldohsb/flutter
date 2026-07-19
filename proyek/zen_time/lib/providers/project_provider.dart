import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zentime/models/project_model.dart';
import 'package:zentime/models/session_model.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectModel> _projects = [];
  
  List<ProjectModel> get projects => _projects;
  
  ProjectProvider() {
    loadProjects();
    _listenToSessionChanges();
  }
  
  void _listenToSessionChanges() {
    // Listen to session box changes to update statistics
    HiveService.sessionsBox.listenable().addListener(() {
      notifyListeners();
    });
  }
  
  void loadProjects() {
    _projects = HiveService.getAllProjects();
    _projects.sort((a, b) => a.order.compareTo(b.order));
    notifyListeners();
  }
  
  Future<void> addProject({
    required String name,
    String? description,
    required Color color,
    required double dailyTargetHours,
    required double weeklyTargetHours,
    required int weekStartDay,
  }) async {
    final maxOrder = _projects.isEmpty 
        ? 0 
        : _projects.map((p) => p.order).reduce((a, b) => a > b ? a : b);
    
    final project = ProjectModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      colorValue: color.toARGB32(),
      dailyTargetHours: dailyTargetHours,
      weeklyTargetHours: weeklyTargetHours,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      order: maxOrder + 1,
      weekStartDay: weekStartDay,
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
    required int weekStartDay,
  }) async {
    final project = HiveService.getProject(projectId);
    if (project != null) {
      final updatedProject = project.copyWith(
        name: name,
        description: description,
        colorValue: color.toARGB32(),
        dailyTargetHours: dailyTargetHours,
        weeklyTargetHours: weeklyTargetHours,
        weekStartDay: weekStartDay,
        updatedAt: DateTime.now(),
      );
      
      await HiveService.updateProject(updatedProject);
      loadProjects();
    }
  }
  
  Future<void> reorderProjects(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    final project = _projects.removeAt(oldIndex);
    _projects.insert(newIndex, project);
    
    // Update order for all projects
    for (int i = 0; i < _projects.length; i++) {
      final updatedProject = _projects[i].copyWith(order: i);
      await HiveService.updateProject(updatedProject);
      _projects[i] = updatedProject;
    }
    
    notifyListeners();
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
    final project = getProject(projectId);
    if (project == null) return 0;
    
    final sessions = HiveService.getProjectSessions(projectId);
    final now = DateTime.now();
    
    // Calculate week start based on project's weekStartDay
    int daysToSubtract = now.weekday - project.weekStartDay;
    if (daysToSubtract < 0) {
      daysToSubtract += 7;
    }
    
    final startOfWeek = now.subtract(Duration(days: daysToSubtract));
    final startOfWeekDate = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    
    return sessions
        .where((session) => session.startTime.isAfter(startOfWeekDate) || 
                           session.startTime.isAtSameMomentAs(startOfWeekDate))
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