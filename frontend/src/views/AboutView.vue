<script>
  import { Search } from 'sonic-channel';

  let sonicChannelSearch = new Search({
    host : "0.0.0.0",
    port : 1492
  }).connect({
    connected : function() {
      // Connected handler
      console.info("Sonic Channel succeeded to connect to host (search).");
    },

    disconnected : function() {
      // Disconnected handler
      console.error("Sonic Channel is now disconnected (search).");
    },

    timeout : function() {
      // Timeout handler
      console.error("Sonic Channel connection timed out (search).");
    },

    retrying : function() {
      // Retry handler
      console.error("Trying to reconnect to Sonic Channel (search)...");
    },

    error : function(error) {
      // Failure handler
      console.error("Sonic Channel failed to connect to host (search).", error);
    }
  });
</script>

<template>
  <div class="about">
    <h1>This is an about page</h1>
  </div>
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
