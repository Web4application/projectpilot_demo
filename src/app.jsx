import React from 'react';
import heroGif from './assets/projectpilot-demo.gif'; // replace with your gif path

export default function App() {
  return (
    <div className="min-h-screen flex flex-col items-center text-center">
      <header className="py-16 space-y-6">
        <h1 className="text-6xl font-extrabold bg-gradient-to-r from-neon to-accent text-transparent bg-clip-text drop-shadow-[0_0_15px_#3DF5FF]">
          Project Pilot AI
        </h1>
        <p className="text-gray-400 text-lg max-w-2xl">
          The all-in-one AI platform for launching, testing, and visualizing intelligent systems.  
          Powered by Web4 & Quantum-Driven Intelligence 🚀
        </p>
        <div className="mt-10">
          <a href="#demo" className="bg-neon text-black px-6 py-3 rounded-lg font-bold hover:bg-accent hover:text-white transition-all duration-300">
            Launch Demo
          </a>
        </div>
      </header>

      <section id="demo" className="flex justify-center py-10">
        <img src={heroGif} alt="Project Pilot Demo" className="rounded-xl shadow-2xl animate-float w-4/5 md:w-2/3 border border-neon/30" />
      </section>

      <section className="py-20 px-6 max-w-4xl text-gray-300">
        <h2 className="text-3xl mb-4 font-semibold text-neon">Capabilities</h2>
        <ul className="space-y-3 text-lg">
          <li>🧩 Modular AI Pipelines – connect, test, and deploy with ease.</li>
          <li>🌍 Real-Time Simulation for data, AI, and environment models.</li>
          <li>📈 Smart Analytics dashboards that feel alive.</li>
          <li>🎨 Beautiful visual storytelling for research and innovation.</li>
        </ul>
      </section>

      <footer className="py-10 text-gray-600 text-sm">
        © 2025 Project Pilot AI — Built by Web4Application 💡
      </footer>
    </div>
  );
}
