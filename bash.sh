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
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

npm create vite@latest project-pilot-ai --template react
cd project-pilot-ai
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
# Replace files with above content
npm run dev
