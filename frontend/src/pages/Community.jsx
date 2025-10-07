// src/pages/Community.jsx
<div className="p-10 grid md:grid-cols-3 gap-6">
  {[1,2,3,4,5,6].map(i => (
    <div key={i} className="bg-[#12121b] rounded-xl border border-neon/10 hover:border-neon/40 transition-all cursor-pointer">
      <img src={`/assets/demo${i}.gif`} className="rounded-t-xl" alt="demo" />
      <div className="p-4">
        <h4 className="text-neon font-semibold">AI Experiment #{i}</h4>
        <p className="text-gray-400 text-sm">by Web4 Labs</p>
      </div>
    </div>
  ))}
</div>
