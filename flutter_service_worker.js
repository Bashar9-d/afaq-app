'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "73ae363dffbd38da1a9162bda54aea0a",
"assets/AssetManifest.bin.json": "a89cfd2a7e5b3c5e2b76db2088775a75",
"assets/AssetManifest.json": "7d80d8eb67544efaf59dfeb4bb132c63",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "08a31ef0bcf2a4985204fdf3172ba582",
"assets/images/afaq-Logo%255B1%255D.png": "1a3e58266639bd9a5f621ed2b0303f7b",
"assets/images/afaq-Logo.png": "bc0b6ffd8a2e53345521bb9f6aa9958f",
"assets/images/afaq_event/photo_5796200955027507363_y.jpg": "dfed91f7ac715a33d4edc023fb16fc2f",
"assets/images/afaq_event/photo_5796200955027507366_y.jpg": "e26eadbe95a04d08451be9e2521e440d",
"assets/images/afaq_event/photo_5796200955027507368_y.jpg": "f9fa666d0c71adcd18fb240a021e996a",
"assets/images/afaq_event/photo_5796200955027507372_y.jpg": "722df138ae56c17a07914432ca6ff6a2",
"assets/images/afaq_event/photo_5796200955027507393_y.jpg": "909a0287d9c5f7dbb25679811ddb1836",
"assets/images/afaq_event/photo_5803315718677184857_y.jpg": "ba2732078d16b4924143990e8f92bcdf",
"assets/images/afaq_event/photo_5812398775644307803_y.jpg": "6e47f4c92908044609d76d182b04c661",
"assets/images/afaq_event/photo_5812398775644307805_y.jpg": "e07895730a092035a3483d2e8a8f3887",
"assets/images/afaq_event/photo_5812398775644307806_y.jpg": "c2c5085a6facac3a362808cb2903712c",
"assets/images/afaq_event/photo_5839078910623597153_y.jpg": "abf21f2f46b1dcba678dfdabaf36d706",
"assets/images/afaq_event/photo_5839078910623597162_y.jpg": "b66b5713d4fa52164df2dc73c998df40",
"assets/images/afaq_event/photo_5870462163641024962_y.jpg": "8d791c046c33c3c8b54be8e0a3019ed3",
"assets/images/afaq_event/photo_5904325073077125561_y.jpg": "f29607e048a5c925092cd6b124207cce",
"assets/images/afaq_event/photo_5904325073077125573_y.jpg": "732e262d7383732796bcdc43f9fb275e",
"assets/images/afaq_event/photo_5904325073077125576_y.jpg": "57a5726802bcd83be37c586b00687818",
"assets/images/afaq_event/photo_5904385507561948189_y.jpg": "ae20b4c9c4a1b518a620debf76107354",
"assets/images/afaq_event/photo_5913734139536852350_y.jpg": "dd176f54c1aad085e02a1de59ec2ece4",
"assets/images/afaq_event/photo_5915842405838473835_y.jpg": "62353a73f215857c01f6d29624b5dbeb",
"assets/images/afaq_event/photo_5971819285837890575_y.jpg": "5f446fa82a9293d38812fcda7a98c2fd",
"assets/images/book.PNG": "82b7512e879a657823bdefdaac121e0f",
"assets/images/Calculate_the_average.png": "9110554703c13a766724c73eb1019397",
"assets/images/college/college_map/photo_5823287505582147389_y.jpg": "4cb1bf2e3394e44079db91302ecc9a33",
"assets/images/college/college_map/photo_5823287505582147390_y.jpg": "226093d3f43a8ba55ecf00a2efe4c909",
"assets/images/college/college_map/photo_5823287505582147391_y.jpg": "14bdd7e06105d03cf992a4b5c4cd2887",
"assets/images/college/photo_5825796432202942126_y.jpg": "fe4e2dc341b9997f1c62f66127873b90",
"assets/images/college/photo_5825796432202942127_y.jpg": "efdfa136323e2570f2887fa62fd10e77",
"assets/images/college/photo_5825796432202942132_y.jpg": "0957881ab7fa2d42829bc4fd6d749a58",
"assets/images/college/photo_5825796432202942134_y.jpg": "7374d5620e78cc2215c51a6fe9c593cc",
"assets/images/college/photo_5825796432202942135_y.jpg": "03f5f7dcd6e9ccf4a81269bb99ec4b8e",
"assets/images/college/photo_5825796432202942137_y.jpg": "1e677ce7b6c8ab2c4ee959a2273964da",
"assets/images/college/photo_5825796432202942140_y.jpg": "3cef0d241fdc0f62ca503790fec9012b",
"assets/images/college/photo_5825796432202942145_y.jpg": "1632859212979ae398fd22cb6bdb4ecc",
"assets/images/college/photo_5825796432202942147_y.jpg": "ee3b3eb3fe0ec7b916a5ad895f2ec190",
"assets/images/college/photo_5825796432202942148_y.jpg": "c1879a356c7053138d016f1d06593244",
"assets/images/college/photo_5825796432202942150_y.jpg": "4b7e7cd3ee8b0f890bde485265368de1",
"assets/images/college/photo_5825796432202942151_y.jpg": "ce89a5557179477f1838d242aee310aa",
"assets/images/college.png": "898661666d8739563b9d02cf0f63174d",
"assets/images/Email.png": "456b5b1c02e307d3ee0eaaab35f1a0e4",
"assets/images/eye_slash.png": "db5ab2e340b3f597c96b20f095b4b4d4",
"assets/images/facebook.png": "8c89ef8ab45d47ae9a954822532889f7",
"assets/images/icon_app.jpeg": "84bc3d3e61ed7ada9b35131d98fd9550",
"assets/images/icon_app.png": "2f201fb5a08dc13c52e7da354b244867",
"assets/images/Instagram.png": "5c570427ee23f69853d28aec805eee79",
"assets/images/linkein_logo.png": "cda9eebfa551b8252a0c01e9696b8c4c",
"assets/images/major.png": "5faecee99c5430d550124a193ac1a918",
"assets/images/photo_college_rel.jpg": "d15e33c4e997809f5779b3b1502a7ef0",
"assets/images/remove_red_eye.png": "b95af9ff5af2eed8aeac9abe91a45bb7",
"assets/images/whatsapp.png": "ba4abe2ff4561d005e46b4cee3d4d62a",
"assets/NOTICES": "6305417c4f249e441733a9229544411b",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "767606eae14b34c662b2227a1afde02d",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "a17c3dbefcfda355934cd60609e826d0",
"icons/Icon-192.png": "0c2b3c6ed401663720afd16653f7170f",
"icons/Icon-512.png": "501a0035406b21037901ff6bf0640709",
"icons/Icon-maskable-192.png": "0c2b3c6ed401663720afd16653f7170f",
"icons/Icon-maskable-512.png": "501a0035406b21037901ff6bf0640709",
"index.html": "b7b9f395c10bcfb4267d5c7be0b6448c",
"/": "b7b9f395c10bcfb4267d5c7be0b6448c",
"main.dart.js": "d12ae71254ac6638d3fb98a4aad4c807",
"manifest.json": "0f021758f581d9600c41de1ab8315ee4",
"version.json": "132168629b4f5aeca8ff3c7bf28c6daa"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
