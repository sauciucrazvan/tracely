'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c2cc5c769c39ee1c523a47ffb9217cbd",
"assets/AssetManifest.json": "ef2a6d0d5484f66738fcf1f99284e03f",
"assets/assets/animations/check.json": "048766d5e819817dbaffab0a2d375888",
"assets/assets/animations/empty.json": "a7e824c76d169bbd565896613d436b35",
"assets/assets/animations/error.json": "9d8ef85386af65f5600deecfdf76dc7c",
"assets/assets/animations/expense.json": "730847b7e08c81c72bab3bbd1e1c8ca7",
"assets/assets/animations/goals.json": "56d34fa199b9dc4e59a6c75d725cf3b6",
"assets/assets/animations/loading.json": "c281b312568241387c11af203bbfb2be",
"assets/assets/animations/login.json": "42fec4e728863cb9b6226b8b9ecaf1cf",
"assets/assets/animations/magic.json": "32c6a6ea3147f464f68c52b05032766a",
"assets/assets/animations/note.json": "7efa1df083e9008c94d16b6fff76e95f",
"assets/assets/animations/note_taking.json": "c7e7d0278d0ede3c2441eed7e92cacc5",
"assets/assets/animations/todo.json": "4eda18851f097c3003a2aae226f222b8",
"assets/assets/images/facebook_logo.png": "92e68411b22da5b1da4f27728a28f296",
"assets/assets/images/google_logo.png": "3e26049d9396f49912688a986b4027b8",
"assets/assets/logo.png": "7d53f34b9ecaa47312b2595f624c5b6d",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "6c3122cde4fdc4ee668e3daf8eb30f17",
"assets/NOTICES": "2f4e44f1e27cb18cdb343e6ad6da7f82",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.ico": "12a20f4906bf2db163d8df59ac5e285c",
"favicon.png": "77b1ee9148db4427b2778435e89b086c",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "8d9eca77916a790b39d674d82c375dfb",
"icons/Icon-512.png": "7fce2e8604a40962d09ca462b0cdd106",
"icons/Icon-maskable-192.png": "8d9eca77916a790b39d674d82c375dfb",
"icons/Icon-maskable-512.png": "7fce2e8604a40962d09ca462b0cdd106",
"index.html": "ac0606238afd5cc5d22fab7dae012fb4",
"/": "ac0606238afd5cc5d22fab7dae012fb4",
"main.dart.js": "a2fab3bb43b5cc759a22c85d8ac89f58",
"manifest.json": "d2eabbc96f9686a832bfaad091bc30e3",
"splash/img/dark-1x.png": "98ea472ae604fa5001834752518d80ef",
"splash/img/dark-2x.png": "efc0a8349bb7af6c45808c2aeeb7c349",
"splash/img/dark-3x.png": "372530a38e435b9fcb84fc0598c9203f",
"splash/img/dark-4x.png": "986f6305c302071ba42ca1b9dfeb2496",
"splash/img/light-1x.png": "98ea472ae604fa5001834752518d80ef",
"splash/img/light-2x.png": "efc0a8349bb7af6c45808c2aeeb7c349",
"splash/img/light-3x.png": "372530a38e435b9fcb84fc0598c9203f",
"splash/img/light-4x.png": "986f6305c302071ba42ca1b9dfeb2496",
"version.json": "8fec68adfc7700a16d1a584b7b7520e6"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
