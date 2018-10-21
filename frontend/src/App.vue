<template>
  <div id="app" class="container-fluid p-0 h-100">
    <nav class="navbar navbar-dark fixed-top bg-dark">
      <a href="/" class="navbar-brand">API-FIRST-SPEC</a>
      <button class="btn btn-success btn-sm">Reset</button>
    </nav>
    <div class="workspace row">
      <div class="col-3 left"></div>
      <div class="col-9 right">
        <router-view/>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
$header-height: 40px;

html, body {
  height: 100%;
}

nav {
  height: $header-height;
}
.workspace {
  margin-top: $header-height;
  height: 100%;
}

.left, .right {
  height: calc(100% - #{$header-height});
  overflow: scroll;
  padding: 0;
}
</style>
