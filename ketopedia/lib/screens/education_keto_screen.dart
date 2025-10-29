import 'package:flutter/material.dart';
import '../data/education_data.dart';
import '../utils/constants.dart';
import 'timeline_screen.dart';
import 'comparison_screen.dart';

class EducationKetoScreen extends StatefulWidget {
  const EducationKetoScreen({super.key});

  @override
  State<EducationKetoScreen> createState() => _EducationKetoScreenState();
}

class _EducationKetoScreenState extends State<EducationKetoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi Keto'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.book), text: 'Pengetahuan'),
            Tab(icon: Icon(Icons.compare), text: 'Perbandingan'),
            Tab(icon: Icon(Icons.timeline), text: 'Timeline'),
            Tab(icon: Icon(Icons.science), text: 'Sains'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _KnowledgeTab(),
          ComparisonScreen(),
          TimelineScreen(),
          _ScienceTab(),
        ],
      ),
    );
  }
}

// Tab 1: Pengetahuan Keto
class _KnowledgeTab extends StatelessWidget {
  const _KnowledgeTab();

  @override
  Widget build(BuildContext context) {
    final knowledgeData = EducationData.ketoKnowledge;

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: knowledgeData.length,
      itemBuilder: (context, index) {
        final item = knowledgeData[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Text(
              item['icon'] as String,
              style: const TextStyle(fontSize: 32),
            ),
            title: Text(
              item['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Text(
                  item['content'] as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Tab 4: Sains Keto
class _ScienceTab extends StatelessWidget {
  const _ScienceTab();

  @override
  Widget build(BuildContext context) {
    final scienceData = EducationData.ketoScience;

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: scienceData.length,
      itemBuilder: (context, index) {
        final item = scienceData[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppConstants.primaryRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Text(
                item['icon'] as String,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            title: Text(
              item['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Text(
                  item['content'] as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}