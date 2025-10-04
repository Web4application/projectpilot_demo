<template>
  <div id="app" class="flex flex-col h-screen">
    <HeaderBar />

    <div class="flex flex-1 overflow-hidden">
      <SidebarMenu @selectModule="setActiveModule" />
      <main class="flex-1 p-6 overflow-auto bg-gray-100">
        <component :is="activeModuleComponent" />
      </main>
    </div>

    <FooterBar />
  </div>
</template>
