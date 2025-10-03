// lib/main.dart
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html; // used for file picker on web
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProjectPilotDemoApp());
}

class ProjectPilotDemoApp extends StatelessWidget {
  const ProjectPilotDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C5CE7)),
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(),
    );

    return MaterialApp(
      title: 'ProjectPilotAI — Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(scaffoldBackgroundColor: Colors.white),
      home: const LandingAndDashboard(),
    );
  }
}

class LandingAndDashboard extends StatefulWidget {
  const LandingAndDashboard({super.key});

  @override
  State<LandingAndDashboard> createState() => _LandingAndDashboardState();
}

class _LandingAndDashboardState extends State<LandingAndDashboard> {
  int _pageIndex = 0; // 0 = landing, 1 = dashboard
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProjectPilotAI (Demo)', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: () => setState(() => _pageIndex = 0),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => setState(() => _pageIndex = 1),
            child: const Text('Dashboard'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: _pageIndex == 0 ? const LandingPage() : const DashboardPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 900;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                children: [
                  // Logo
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF00BFA6)]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)],
                    ),
                    child: const Icon(Icons.memory, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 12),
                  const Text('ProjectPilotAI', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 36),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'An AI developer assistant that understands and improves your codebase.',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.grey[900]),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Summarize repos, suggest refactors, run security checks, auto-document, and more — powered by LLMs and integrated with GitHub.',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 20),
                        Wrap(spacing: 12, children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to dashboard
                              final state = context.findAncestorStateOfType<_LandingAndDashboardState>();
                              state?.setState(() => state._pageIndex = 1);
                            },
                            icon: const Icon(Icons.rocket_launch),
                            label: const Text('Try Demo'),
                          ),
                          OutlinedButton(
                            onPressed: () => _showOpenSourceLink(context),
                            child: const Text('Open Source'),
                          )
                        ]),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center, children: [
                          const Icon(Icons.verified, color: Colors.green),
                          const SizedBox(width: 8),
                          Text('Open source • MIT • Web4application', style: TextStyle(color: Colors.grey[600])),
                        ]),
                      ],
                    ),
                  ),
                  if (isWide)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF00BFA6)]),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(28.0),
                                child: Text(
                                  'AI\nCodebase\nAssistant',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),
              const FeaturesGrid(),
              const SizedBox(height: 28),
              const ArchitectureCard(),
              const SizedBox(height: 40),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  void _showOpenSourceLink(BuildContext ctx) {
    html.window.open('https://web4application.github.io/project_pilot_ai', '_blank');
  }
}

class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key});

  static const items = [
    {'title': 'AI Codebase Analysis', 'desc': 'Summarize repos and modules quickly.', 'icon': Icons.code},
    {'title': 'Refactoring', 'desc': 'Suggest and apply refactors.', 'icon': Icons.auto_fix_high},
    {'title': 'Dev Watchdog', 'desc': 'Monitor changes and suggest fixes.', 'icon': Icons.watch},
    {'title': 'PR Review Bot', 'desc': 'Auto review PRs with AI.', 'icon': Icons.merge_type},
    {'title': 'Auto-Docs', 'desc': 'Generate README and docs.', 'icon': Icons.menu_book},
    {'title': 'Security Scanner', 'desc': 'Detect common security issues.', 'icon': Icons.security},
    {'title': 'Voice Commands', 'desc': 'Speak commands to the assistant.', 'icon': Icons.mic},
    {'title': 'Figma→Code', 'desc': 'Convert design to components.', 'icon': Icons.design_services},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cross = width >= 1000 ? 4 : width >= 700 ? 2 : 1;
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cross,
        mainAxisExtent: 120,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final it = items[i];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                child: Icon(it['icon'] as IconData, color: const Color(0xFF6C5CE7)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(it['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(it['desc'] as String, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                ]),
              )
            ]),
          ),
        );
      },
    );
  }
}

class ArchitectureCard extends StatelessWidget {
  const ArchitectureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Architecture', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('project_pilot_ai/'),
                  SizedBox(height: 6),
                  Text('├── ai_core/'),
                  Text('├── cli/'),
                  Text('├── gui/'),
                  Text('├── integrations/'),
                  Text('├── pilot_sdk/'),
                  Text('├── voice/'),
                  Text('├── .github/'),
                  Text('└── vscode-plugin/'),
                ]),
              ),
              const SizedBox(width: 12),
              Container(
                width: 260,
                height: 140,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey[100]),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(child: Text('Streamlit GUI\n(Deployable)')),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 18),
      const Divider(),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('© ${2025} Web4application', style: TextStyle(color: Colors.grey[600])),
        Row(children: [
          TextButton(onPressed: () => html.window.open('https://github.com/web4application/project_pilot_ai', '_blank'), child: const Text('Source')),
          TextButton(onPressed: () {}, child: const Text('License')),
        ])
      ])
    ]);
  }
}

/// ---------------- Dashboard (upload + mock analysis) ----------------

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _uploadedFileName;
  bool _analyzing = false;
  double _progress = 0.0;
  String? _analysisResult;

  // Use browser input element to pick file for web
  void _pickZipAndUpload() {
    final uploadInput = html.FileUploadInputElement()..accept = '.zip';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;
      final file = files.first;
      setState(() {
        _uploadedFileName = file.name;
        _analysisResult = null;
      });
      // Optionally read file bytes for sending to backend:
      // final reader = html.FileReader();
      // reader.readAsArrayBuffer(file);
      // reader.onLoadEnd.listen((e) => ...);
    });
  }

  // Simulated analysis run — replace with real API call
  Future<void> _startAnalysis() async {
    if (_uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload a repo ZIP first')));
      return;
    }
    setState(() {
      _analyzing = true;
      _progress = 0.02;
      _analysisResult = null;
    });

    // simulated progress
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _progress += 0.08 + (i * 0.003));
    }

    // Simulated "AI" result — replace this block with a real LLM POST call
    final simulated = _mockAnalysisReport(_uploadedFileName!);
    setState(() {
      _analyzing = false;
      _progress = 1.0;
      _analysisResult = simulated;
    });
  }

  String _mockAnalysisReport(String name) {
    final report = {
      'repo': name,
      'summary': 'This repository contains a modular AI assistant with CLI, GUI, and integrations. Key modules: ai_core, cli, gui, pilot_sdk, voice.',
      'issues_found': [
        {'file': 'ai_core/agent.py', 'issue': 'Suspicious use of eval() without sanitization', 'severity': 'high'},
        {'file': 'gui/auth.py', 'issue': 'Missing CSRF protection in form submission', 'severity': 'medium'},
        {'file': 'pilot_sdk/__init__.py', 'issue': 'No type hints for public API', 'severity': 'low'},
      ],
      'suggested_refactors': [
        'Replace dynamic eval usage with AST-safe transform.',
        'Add CSRF tokens and server-side validation for GUI endpoints.',
        'Add type annotations and unit tests to pilot_sdk.'
      ],
      'next_steps': [
        'Run security scanner on CI with --strict flag.',
        'Configure GitHub Actions PR reviewer (see .github/workflows/pr-review.yml).',
        'Connect to an LLM provider and enable automatic refactor commits (careful with auto-push).'
      ]
    };
    return const JsonEncoder.withIndent('  ').convert(report);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('1) Upload a repo ZIP (or connect GitHub)'),
                  const SizedBox(height: 8),
                  Row(children: [
                    ElevatedButton.icon(
                      onPressed: _pickZipAndUpload,
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Upload repo ZIP'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        // placeholder for GitHub OAuth connector
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('GitHub connect not implemented in demo')));
                      },
                      icon: const Icon(Icons.link),
                      label: const Text('Connect GitHub (stub)'),
                    ),
                    const SizedBox(width: 12),
                    if (_uploadedFileName != null) Text('Uploaded: $_uploadedFileName'),
                  ]),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('2) Run analysis'),
                  const SizedBox(height: 8),
                  Row(children: [
                    ElevatedButton.icon(
                      onPressed: _analyzing ? null : _startAnalysis,
                      icon: const Icon(Icons.analytics),
                      label: Text(_analyzing ? 'Analyzing...' : 'Analyze'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: _analyzing
                          ? null
                          : () {
                              // Simulate enabling refactor bot
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Refactor bot enabled (demo)')));
                            },
                      child: const Text('Enable Refactor Bot (stub)'),
                    )
                  ]),
                  const SizedBox(height: 12),
                  if (_analyzing)
                    LinearProgressIndicator(value: _progress)
                  else if (_progress > 0 && _analysisResult != null)
                    const SizedBox.shrink()
                  else
                    const SizedBox.shrink(),
                ]),
              ),
            ),
            const SizedBox(height: 18),
            if (_analysisResult != null) ...[
              const Text('Analysis Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SelectableText(_analysisResult!, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Placeholder: in a real app, create issue, PR, or suggestion
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create PR / issue (stub)')));
                },
                icon: const Icon(Icons.merge_type),
                label: const Text('Open PR with fixes (stub)'),
              ),
            ],
            const SizedBox(height: 20),
            const Text('Integration notes', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'This demo simulates analysis results locally. To connect a real AI backend:\n'
              '• Provide a backend endpoint that accepts the repo archive and returns JSON analysis.\n'
              '• Or call an LLM provider from the backend (OpenAI/Anthropic) and perform safe transformations.\n'
              '• Use GitHub Apps/OAuth for repository access and to open PRs from a service account.',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
