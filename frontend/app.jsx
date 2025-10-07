import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import Dashboard from "./pages/Dashboard";
import Lab from "./pages/Lab";
import Community from "./pages/Community";

export default function App() {
  return (
    <BrowserRouter>
      <nav className="flex justify-between px-8 py-4 border-b border-neon/10 bg-[#0a0a10]/80 backdrop-blur-md">
        <h1 className="text-2xl font-extrabold bg-gradient-to-r from-neon to-accent text-transparent bg-clip-text">Project Pilot AI</h1>
        <div className="flex gap-6 text-gray-400">
          <Link to="/">Dashboard</Link>
          <Link to="/lab">Lab</Link>
          <Link to="/community">Community</Link>
        </div>
      </nav>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/lab" element={<Lab />} />
        <Route path="/community" element={<Community />} />
      </Routes>
      <footer className="text-center text-gray-600 py-6 border-t border-neon/10">
        © 2025 Project Pilot — by Web4Application ⚡
      </footer>
    </BrowserRouter>
  );
}
