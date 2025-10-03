#!/usr/bin/env bash
# create_full_project.sh
# Generates a full demo project: Flutter frontend + Node backend + README + zip helper
# Usage:
#   chmod +x create_full_project.sh
#   ./create_full_project.sh
set -e

ROOT="projectpilot_full"
FRONTEND="$ROOT/frontend"
BACKEND="$ROOT/backend"

echo "Creating project folders..."
rm -rf "$ROOT"
mkdir -p "$FRONTEND/lib/src"
mkdir -p "$BACKEND"
mkdir -p "$ROOT/.github/workflows"

echo "Writing frontend pubspec.yaml..."
cat > "$FRONTEND/pubspec.yaml" <<'YAML'
name: projectpilot_demo
description: ProjectPilotAI demo scaffold (Flutter Web)
publish_to: "none"
version: 0.0.1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^5.0.0
  http: ^0.13.6
  js: ^0.6.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
YAML

echo "Writing frontend main.dart..."
cat > "$FRONTEND/lib/main.dart" <<'DART'
// Main entry - Flutter Web demo for ProjectPilotAI
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html; // file picker & interop
import 'dart:js' as js; // for simple speech integration fallback
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/api_service.dart';

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
                              final state = context.findAncestorStateOfType<_LandingAndDashboardState>();
                              state?.setState(() => state._pageIndex = 1);
                            },
                            icon: const Icon(Icons.rocket_launch),
                            label: const Text('Try Demo'),
                          ),
                          OutlinedButton(
                            onPressed: () => html.window.open('https://web4application.github.io/project_pilot_ai', '_blank'),
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
  final ApiService api = ApiService(baseUrl: 'http://localhost:4000');

  // Use browser input element to pick file for web
  void _pickZipAndUpload() {
    final uploadInput = html.FileUploadInputElement()..accept = '.zip';
    uploadInput.click();
    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) return;
      final file = files.first;
      setState(() {
        _uploadedFileName = file.name;
        _analysisResult = null;
      });

      // Read bytes and upload to backend API
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) async {
        final data = reader.result;
        if (data == null) return;
        final bytes = data as List<int>;
        try {
          // send to backend
          final res = await api.uploadRepoZip(bytes, file.name);
          // backend returns JSON result
          setState(() {
            _analysisResult = const JsonEncoder.withIndent('  ').convert(res);
          });
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload error: $err')));
        }
      });
    });
  }

  // Frontend simulated progress & connect to backend analyze route to poll status
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

    // Polling simulation (the backend returns result directly in this demo)
    for (int i = 0; i < 8; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _progress += 0.1);
    }

    // In this demo the upload already triggered analysis and returned result, if not, call analyze
    try {
      final res = await api.getLastAnalysis(); // demo endpoint
      setState(() {
        _analysisResult = const JsonEncoder.withIndent('  ').convert(res);
      });
    } catch (e) {
      setState(() {
        _analysisResult = 'Error fetching analysis: $e';
      });
    } finally {
      setState(() {
        _analyzing = false;
        _progress = 1.0;
      });
    }
  }

  // Voice command demo (uses injected JS web speech wrapper if available)
  void _startVoiceCommand() async {
    // Try to call the JS speech helper if present
    try {
      final txt = js.context.callMethod('startSpeechCapture', []);
      // If startSpeechCapture returns immediately with value (not typical) show it:
      if (txt != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recognized: $txt')));
      } else {
        // listen to window events for the result (the injected script dispatches 'projectpilot_speech' event)
        html.window.addEventListener('projectpilot_speech', (event) {
          // event detail might be a JS event, extract via JS
          final e = event as dynamic;
          final detail = e['detail'] ?? e;
          final speech = detail is String ? detail : (detail?['transcript'] ?? 'unknown');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recognized: $speech')));
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listening... (speak)')));
      }
    } catch (e) {
      // fallback: prompt
      final fallback = html.window.prompt('Speech not available — type a command instead', '') ?? '';
      if (fallback.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Command: $fallback')));
      }
    }
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
                        // open the backend GitHub connect url
                        html.window.open('http://localhost:4000/auth/github', '_blank');
                      },
                      icon: const Icon(Icons.link),
                      label: const Text('Connect GitHub (stub)'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _startVoiceCommand,
                      icon: const Icon(Icons.mic),
                      label: const Text('Voice command'),
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
DART

echo "Writing frontend API service..."
cat > "$FRONTEND/lib/src/api_service.dart" <<'DART'
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// Simple API client for demo backend
class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  // Upload repo zip bytes as multipart/form-data
  Future<Map<String, dynamic>> uploadRepoZip(List<int> bytes, String filename) async {
    final uri = Uri.parse('$baseUrl/analyze');
    final req = http.MultipartRequest('POST', uri);
    req.files.add(http.MultipartFile.fromBytes('repo', bytes, filename: filename));
    final streamed = await req.send();
    final res = await http.Response.fromStream(streamed);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Upload failed: ${res.statusCode} ${res.body}');
    }
  }

  // Demo endpoint to fetch last analysis (the demo backend stores last result in memory)
  Future<Map<String, dynamic>> getLastAnalysis() async {
    final uri = Uri.parse('$baseUrl/last');
    final res = await http.get(uri);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Fetch failed: ${res.statusCode} ${res.body}');
    }
  }
}
DART

echo "Writing frontend index.html helper for speech JS injection..."
mkdir -p "$FRONTEND/web"
cat > "$FRONTEND/web/index.html" <<'HTML'
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>ProjectPilotAI Demo</title>
    <meta name="description" content="ProjectPilotAI demo">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script>
      // Inject a tiny wrapper for Web Speech API. Exposes startSpeechCapture() callable from Dart via JS interop.
      window.startSpeechCapture = function() {
        // Try to get a speech recognition implementation
        const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        if (!SpeechRecognition) {
          console.warn('SpeechRecognition not available in this browser.');
          return null;
        }
        const recognition = new SpeechRecognition();
        recognition.lang = 'en-US';
        recognition.interimResults = false;
        recognition.maxAlternatives = 1;
        recognition.onresult = function(event) {
          const transcript = event.results[0][0].transcript;
          // dispatch a custom event that Dart can catch
          window.dispatchEvent(new CustomEvent('projectpilot_speech', { detail: { transcript: transcript } }));
        };
        recognition.onerror = function(err) {
          console.error('Speech error', err);
          window.dispatchEvent(new CustomEvent('projectpilot_speech', { detail: { error: err.message || 'error' } }));
        };
        recognition.start();
        return true;
      };
    </script>
  </head>
  <body>
    <script src="main.dart.js" type="application/javascript"></script>
  </body>
</html>
HTML

echo "Writing backend package.json..."
cat > "$BACKEND/package.json" <<'JSON'
{
  "name": "projectpilot_backend",
  "version": "1.0.0",
  "description": "Demo backend for ProjectPilotAI - mock analysis",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "multer": "^1.4.5-lts.1",
    "cors": "^2.8.5",
    "node-fetch": "^3.4.1"
  }
}
JSON

echo "Writing backend server.js..."
cat > "$BACKEND/server.js" <<'NODE'
/*
  Demo Express server for ProjectPilotAI:
  - POST /analyze : accepts multipart/form-data 'repo' file (ZIP) and returns a mocked analysis JSON
  - GET  /last    : returns the last analysis generated (in-memory)
  - GET  /auth/github : redirect to GitHub OAuth (demo)
  - GET  /auth/github/callback : exchange code (stub) and show success page (developer must set client id/secret)
*/
const express = require('express');
const multer = require('multer');
const cors = require('cors');
const path = require('path');

const upload = multer({ storage: multer.memoryStorage() });
const app = express();
app.use(cors());
app.use(express.json());

let lastAnalysis = null;

// Homepage
app.get('/', (req, res) => res.send('ProjectPilotAI demo backend running'));

// Analyze endpoint
app.post('/analyze', upload.single('repo'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'repo file missing' });
  }
  // In a real backend you'd:
  //  - save the archive
  //  - spawn a job to unpack and analyze (linters, security scanners)
  //  - call an LLM to summarize and suggest refactors
  // Here we return a mocked analysis
  const filename = req.file.originalname || 'uploaded_repo.zip';
  const analysis = {
    repo: filename,
    summary: `Mock summary for ${filename}: this repository appears to be a modular AI-assistant with CLI, GUI, and integrations.`,
    issues_found: [
      { file: 'ai_core/agent.py', issue: 'Suspicious use of eval()', severity: 'high' },
      { file: 'gui/auth.py', issue: 'Missing CSRF tokens', severity: 'medium' },
      { file: 'pilot_sdk/__init__.py', issue: 'Missing type annotations', severity: 'low' }
    ],
    suggested_refactors: [
      'Avoid dynamic eval; use AST transforms.',
      'Add CSRF protection and server-side validation.',
      'Add type hints and unit tests for pilot_sdk.'
    ],
    next_steps: [
      'Run CI static analyzers with strict rules.',
      'Set up GitHub Actions for PR auto-review.',
      'Connect to an LLM backend and enable staged auto-commits.'
    ],
    generated_at: new Date().toISOString()
  };
  lastAnalysis = analysis;
  // simulate some processing delay
  setTimeout(() => {
    res.json(analysis);
  }, 700);
});

// Return last analysis
app.get('/last', (req, res) => {
  if (!lastAnalysis) return res.status(404).json({ error: 'no analysis available yet' });
  res.json(lastAnalysis);
});

/*
  GitHub OAuth stub:
  To make this work, create a GitHub OAuth App and set:
  - GITHUB_CLIENT_ID
  - GITHUB_CLIENT_SECRET
  - GITHUB_CALLBACK_URL (e.g. http://localhost:4000/auth/github/callback)
*/
const GITHUB_CLIENT_ID = process.env.GITHUB_CLIENT_ID || 'REPLACE_WITH_CLIENT_ID';
const GITHUB_CLIENT_SECRET = process.env.GITHUB_CLIENT_SECRET || 'REPLACE_WITH_CLIENT_SECRET';
const GITHUB_CALLBACK = process.env.GITHUB_CALLBACK || 'http://localhost:4000/auth/github/callback';

app.get('/auth/github', (req, res) => {
  const redirect = `https://github.com/login/oauth/authorize?client_id=${GITHUB_CLIENT_ID}&scope=repo%20read:user`;
  res.redirect(redirect);
});

app.get('/auth/github/callback', async (req, res) => {
  // In a real app you'd exchange code for token and create/redirect to account
  const code = req.query.code;
  if (!code) {
    return res.status(400).send('Missing code. Make sure GitHub OAuth app is configured.');
  }
  // For security, do the exchange server-side using your client secret.
  res.send(`<h3>GitHub OAuth callback received (demo)</h3><p>Code: ${code}</p><p>Replace this handler with a token exchange routine.</p>`);
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Demo backend listening on http://localhost:${PORT}`);
});
NODE

echo "Writing README..."
cat > "$ROOT/README.md" <<'MD'
# ProjectPilotAI — Full Demo (Frontend + Backend)

This repository is generated by the `create_full_project.sh` script. It contains:

- `frontend/` — Flutter Web demo app (landing + dashboard + upload + voice + GitHub stub).
- `backend/`  — Node.js Express demo backend (mock analysis, GitHub OAuth stub).
- `create_zip.sh` — zips the whole project.

## Quick start

### Backend
```bash
cd backend
npm install
node server.js
# backend runs on http://localhost:4000
