export default function Card({ title, children }) {
  return (
    <div className="bg-[#12121b] border border-neon/10 rounded-xl p-6 shadow-md hover:border-neon/40 transition-all">
      <h2 className="text-neon font-bold mb-3">{title}</h2>
      {children}
    </div>
  );
}
