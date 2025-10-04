flutter create projectpilot_demo
cd projectpilot_demo
chmod +x create_full_project.sh
./create_full_project.sh
cd projectpilot_full/backend
npm install
node server.js
cd projectpilot_full/frontend
flutter pub get
flutter run -d chrome
npm create vite@latest projectpilot-frontend
cd projectpilot-frontend
# Select: Vue + JavaScript
npm install
