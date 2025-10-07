export default function Button({ label, onClick, type="primary" }) {
  const styles = type === "primary"
    ? "bg-neon text-black hover:bg-accent hover:text-white"
    : "border border-neon text-neon hover:bg-neon hover:text-black";
  return (
    <button onClick={onClick} className={`px-6 py-2 rounded-lg font-semibold transition-all ${styles}`}>
      {label}
    </button>
  );
}
