<template>
  <div id="app">
    <!-- Header -->
    <HeaderBar />

    <div class="main-container">
      <!-- Sidebar Navigation -->
      <SidebarMenu @selectModule="setActiveModule" />

      <!-- Main Content Area -->
      <main class="content-area">
        <component :is="activeModuleComponent" />
      </main>
    </div>

    <!-- Footer -->
    <FooterBar />
  </div>
</template>

<script>
import HeaderBar from './components/HeaderBar.vue';
import SidebarMenu from './components/SidebarMenu.vue';
import FooterBar from './components/FooterBar.vue';

// Import placeholder dashboard modules
import DashboardHome from './modules/DashboardHome.vue';
import ProjectLogs from './modules/ProjectLogs.vue';
import AIAnalytics from './modules/AIAnalytics.vue';
import QuantumSim from './modules/QuantumSim.vue';

export default {
  name: 'App',
  components: {
    HeaderBar,
    SidebarMenu,
    FooterBar,
    DashboardHome,
    ProjectLogs,
    AIAnalytics,
    QuantumSim,
  },
  data() {
    return {
      activeModule: 'DashboardHome', // default module
    };
  },
  computed: {
    activeModuleComponent() {
      // Dynamically render the selected module
      switch (this.activeModule) {
        case 'ProjectLogs':
          return ProjectLogs;
        case 'AIAnalytics':
          return AIAnalytics;
        case 'QuantumSim':
          return QuantumSim;
        default:
          return DashboardHome;
      }
    },
  },
  methods: {
    setActiveModule(moduleName) {
      this.activeModule = moduleName;
    },
  },
};
</script>

<style scoped>
#app {
  display: flex;
  flex-direction: column;
  height: 100vh;
  font-family: 'Segoe UI', Roboto, sans-serif;
}

.main-container {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.content-area {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  background-color: #f9f9f9;
}
</style>
