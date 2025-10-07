// src/pages/Lab.jsx
<div className="grid md:grid-cols-2 h-[80vh] border-t border-neon/10">
  <div className="p-6 overflow-y-auto">
    <h2 className="text-2xl text-neon mb-4">AI Sandbox</h2>
    <textarea className="w-full h-48 bg-black/40 text-white border border-neon/10 rounded-lg p-4" placeholder="Type or upload your AI script..." />
    <button className="mt-4 bg-neon text-black font-semibold px-6 py-2 rounded-md hover:bg-accent transition-all">Run</button>
  </div>
  <div className="p-6 bg-[#0e0e15] border-l border-neon/10">
    <h3 className="text-accent font-bold mb-4">Output</h3>
    <div className="h-full bg-black/40 rounded-lg p-4 text-gray-300">⚙️ Results will appear here</div>
  </div>
</div>
