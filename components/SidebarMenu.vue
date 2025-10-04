<template>
  <aside class="sidebar">
    <ul>
      <li @click="$emit('selectModule', 'DashboardHome')">Home</li>
      <li @click="$emit('selectModule', 'ProjectLogs')">Logs</li>
      <li @click="$emit('selectModule', 'AIAnalytics')">AI Analytics</li>
      <li @click="$emit('selectModule', 'QuantumSim')">Quantum Sim</li>
    </ul>
  </aside>
</template>

<script>
export default { name: 'SidebarMenu' };
</script>

<style scoped>
.sidebar {
  width: 200px;
  background: #f3f4f6;
  padding: 20px;
}
.sidebar ul {
  list-style: none;
  padding: 0;
}
.sidebar li {
  padding: 10px 0;
  cursor: pointer;
}
.sidebar li:hover {
  background: #e5e7eb;
}
</style>
