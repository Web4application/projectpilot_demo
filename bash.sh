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

## Make sure to have the system dependencies and browsers up to date. By filtering
## on the web module we make sure the version of playwright that gets installed is
## the one specified in package.json
pnpm --filter ./web exec playwright install --with-deps

## Run the tests from the web module.
pnpm run --filter ./web test:e2e

## Or, if port 9000 is already used
HTTP_PORT=9001 pnpm run --filter ./web test:e2e

pnpm lint

pnpm run build
