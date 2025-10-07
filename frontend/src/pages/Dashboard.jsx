import React, { useEffect, useState } from "react";
import Card from "../components/Card";
import { Line } from "react-chartjs-2";
import "chart.js/auto";

export default function Dashboard() {
  const [metrics, setMetrics] = useState([]);
  
  useEffect(() => {
    const fetchData = async () => {
      const res = await fetch("http://localhost:8000/analytics/metrics");
      const data = await res.json();
      setMetrics(prev => [...prev.slice(-10), data]);
    };
    fetchData();
    const interval = setInterval(fetchData, 3000);
    return () => clearInterval(interval);
  }, []);

  const chartData = {
    labels: metrics.map((m) => new Date(m.timestamp * 1000).toLocaleTimeString()),
    datasets: [
      {
        label: "Model Accuracy (%)",
        data: metrics.map((m) => m.model_accuracy),
        borderColor: "#3DF5FF",
        fill: false,
        tension: 0.3,
      },
    ],
  };

  return (
    // src/pages/Dashboard.jsx
<div className="p-8 grid md:grid-cols-3 gap-6">
  <div className="bg-[#12121b] p-6 rounded-xl border border-neon/10 shadow-lg">
    <h2 className="text-neon font-bold text-xl mb-2">AI Pipelines</h2>
    <p className="text-gray-400 text-sm">Manage and launch connected systems.</p>
  </div>
  <div className="bg-[#12121b] p-6 rounded-xl border border-neon/10 shadow-lg">
    <h2 className="text-neon font-bold text-xl mb-2">Data Streams</h2>
    <p className="text-gray-400 text-sm">Monitor live datasets and models.</p>
  </div>
  <div className="bg-[#12121b] p-6 rounded-xl border border-neon/10 shadow-lg">
    <h2 className="text-neon font-bold text-xl mb-2">Analytics</h2>
    <p className="text-gray-400 text-sm">Real-time performance visualizations.</p>
  </div>
  <div className="p-10 grid md:grid-cols-2 gap-6">
      <Card title="Live Model Performance">
        <Line data={chartData} />
      </Card>
      <Card title="Active System Stats">
        {metrics.length > 0 && (
          <ul className="text-gray-300 space-y-1 mt-3">
            <li>⚡ Processing Speed: {metrics.at(-1).processing_speed} ops/s</li>
            <li>👥 Active Users: {metrics.at(-1).active_users}</li>
            <li>🎯 Accuracy: {metrics.at(-1).model_accuracy}%</li>
          </ul>
        )}
      </Card>
    </div>
  );
}
