'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "3ed5a342b5e4a3f21fe29e92abfb7ee4",
"index.html": "2292a8c5d6fb26a1ecb05e9351fa1e17",
"/": "2292a8c5d6fb26a1ecb05e9351fa1e17",
"main.dart.js": "6fc6521a85fa59da25b62517fc9f0d09",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "696fd0cadbc6aa5dc1a1efb667d23602",
"assets/AssetManifest.json": "ec2003a95b7c6a796c90dc92dd251cbd",
"assets/NOTICES": "7769db183170ce776d1db64b2d7560dc",
"assets/FontManifest.json": "8d03bf0076e389be2835f7be5a73f727",
"assets/AssetManifest.bin.json": "883f5c5e970a75572a3181b6022178ae",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "29fe112ff9a383327f8621f166bb1060",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/music/free_run.mp3": "c700cf7861e33436a916cdf7e5da4e5b",
"assets/assets/music/gomi_groove-alt.mp3": "804a6c78989ae75ec388147c6c74b8dc",
"assets/assets/music/CREDITS.TXT": "664b159f17146e56808c4e23d7603f6e",
"assets/assets/music/theme.mp3": "39f1517dd4e0f1bedc06eb37c9169346",
"assets/assets/music/victory.mp3": "4ff0123341d5e05f819a46ebe1732fb7",
"assets/assets/music/bit_forrest.mp3": "f330991a5bd6973c5d1167619319abd0",
"assets/assets/music/gomi_groove.mp3": "ca45c4280b54071679c7de1f388ad6ea",
"assets/assets/music/tropical_fantasy.mp3": "44bdafbd3982d2ba451f225294f56dff",
"assets/assets/images/tilemap.png": "20df8432f00ae281f77ea48636917bcd",
"assets/assets/images/collectibles/seed/grow.png": "f4f1dcbdfa563949d882bf9247bf4f05",
"assets/assets/images/collectibles/seed/idle.png": "3bc9b1a12e5d1b641197d878016a899c",
"assets/assets/images/collectibles/coin.png": "2839d191a95beb5f8429b762464b7a18",
"assets/assets/images/tree.gif": "3688fc5a05e23a486e0c648a2def25e9",
"assets/assets/images/scenery/trees_1.png": "217c2d3d32e5acc65694760d2c572ce7",
"assets/assets/images/scenery/trees_2.png": "b72a803a7af25a78528ee259f156c945",
"assets/assets/images/scenery/sun_with_shades.png": "73cb10b025d77a40a67a87db2c340d82",
"assets/assets/images/scenery/background.png": "745ff571353fe7c6bb79ddc9b1bdb0d7",
"assets/assets/images/scenery/mountains.png": "aa141a2bc9d0a922c070a870f6f5b28c",
"assets/assets/images/scenery/water.png": "927ca9b9c81d221a62597b422d6dbeec",
"assets/assets/images/scenery/clouds_2.png": "d378a6b61600be322b91d2defc22f28c",
"assets/assets/images/scenery/clouds_1.png": "873ba42234f542d91ecfc2ddff1423fb",
"assets/assets/images/scenery/sun.png": "80f0a9160e7893caf95b85d1ca98188e",
"assets/assets/images/scenery/background_1a.png": "7a48459cc5313c1235f381648ea94408",
"assets/assets/images/gomi_splash.png": "f0f6ba9c3db8bb7da0a2b4bd5fbc0c2a",
"assets/assets/images/level_button.png": "b8026c32f31ec2317c2f82366679e4fb",
"assets/assets/images/empty_level_button.png": "d7241f0143457e32804c5978fe6d0824",
"assets/assets/images/splash.png": "0d47cd0fa08cc1180074ff67acf21e5d",
"assets/assets/images/tutorials/tutorial_1.png": "d39483a87af693a8fafa7f9e251d2b57",
"assets/assets/images/tutorials/tutorial_3.png": "45164801421af7e7f27db196e83a4e39",
"assets/assets/images/tutorials/tutorial_2.png": "6adea64ff96bb04722543d92a5824f66",
"assets/assets/images/tutorials/tutorial_6.png": "380110b8cb2b9e570a24a14ee25186de",
"assets/assets/images/tutorials/tutorial_7.png": "613027204479f134c36b89f3384ac6bc",
"assets/assets/images/tutorials/tutorial_5.png": "cd2fdeaa94aa4444ca442c2b67b88e4d",
"assets/assets/images/tutorials/tutorial_4.png": "8ca4a2db5a8e9a5963c4eed15288c7a8",
"assets/assets/images/level_map_tileset.png": "58ecb3e6190d09945007e1d99f52ae5e",
"assets/assets/images/tilemap_packed.png": "2941034f02badee194a334c238c879ff",
"assets/assets/images/gomi/appear.png": "dbf5fa28222733caeb72b5e2a08ba626",
"assets/assets/images/gomi/black_gomi/jump.png": "2f1991d78a59357a7e3f2d50d2670f3f",
"assets/assets/images/gomi/black_gomi/idle.png": "8c81f0b25b64b03a075037b734d9195a",
"assets/assets/images/gomi/black_gomi/fall.png": "101e395d61d817a1fceafc91d2ef7b63",
"assets/assets/images/gomi/black_gomi/hit.png": "8d33c24ff036fdae29f3920705121981",
"assets/assets/images/gomi/black_gomi/walk.png": "77a256453153acd0874cb49dabe80b2f",
"assets/assets/images/gomi/gomi.png": "a2e0d00fb442a8c915e6e6eea7775eae",
"assets/assets/images/gomi/red_gomi/jump.png": "85abdb217b49f785a3334d9b9fe52745",
"assets/assets/images/gomi/red_gomi/idle.png": "ce9c9a741546e59d5679ab24fb55730a",
"assets/assets/images/gomi/red_gomi/fall.png": "cdcd337758e81b55d1fbaf34c6b2bd84",
"assets/assets/images/gomi/red_gomi/hit.png": "3033d1e7be8e185f6fce72e2900516bc",
"assets/assets/images/gomi/red_gomi/walk.png": "38877738feed5aa783a5f5242f989087",
"assets/assets/images/gomi/blue_gomi/jump.png": "03172a2ccd8689ef19234b05592a613b",
"assets/assets/images/gomi/blue_gomi/idle.png": "553dd148f0615efcbc83ac8adac0db9f",
"assets/assets/images/gomi/blue_gomi/fall.png": "67ef4bd7b2773b8aa533d44baa948d40",
"assets/assets/images/gomi/blue_gomi/hit.png": "3876a7d5ec91c98fa983fd5a15687a8b",
"assets/assets/images/gomi/blue_gomi/walk.png": "7fa27ae0959c8c500f91f05ce48a4204",
"assets/assets/images/gomi/green_gomi/jump.png": "61f0bfe85ba11671dfeb87e187efa095",
"assets/assets/images/gomi/green_gomi/idle.png": "3caee9df2a20cb17ab60aa044a229d14",
"assets/assets/images/gomi/green_gomi/fall.png": "25f5e239f0ed23a39b9163a438d960d1",
"assets/assets/images/gomi/green_gomi/hit.png": "981f6539abf74cca0ebd4c19cb73fe46",
"assets/assets/images/gomi/green_gomi/walk.png": "012d8d4519d921ac7900a48c59bf2c87",
"assets/assets/images/gomi/disappear.png": "cf7ff1e3e1180e9b27f34780fb5c24c3",
"assets/assets/images/enemies/water_bottle/idle.png": "1f67c39bcc5db435624da9a63f02e192",
"assets/assets/images/enemies/water_bottle/attack.png": "8f5701ece56b0c5caccd2d6c9aa57796",
"assets/assets/images/enemies/light_bulb/sparks.png": "00fe664a02257306deb001b6d66e0997",
"assets/assets/images/enemies/light_bulb/idle.png": "c16503cdfefb42ee306318108d641edc",
"assets/assets/images/enemies/light_bulb/zap.png": "17fcfcac88ce3fca6a3f5ddd1bf87304",
"assets/assets/images/enemies/light_bulb/attack.png": "2aac76bf1c9835b69de82aaa85c82ec0",
"assets/assets/images/enemies/syringe/idle.png": "52fb24a41b9a88edb29b154cdaf1acb9",
"assets/assets/images/enemies/syringe/attack.png": "de578cd72f8d5cc04338e2bda3ff6811",
"assets/assets/images/enemies/tomato/idle.png": "3b84260140afbe56f311d7c3732af70c",
"assets/assets/images/enemies/tomato/attack.png": "29f1dc49d0ccebc5c207c29f02931517",
"assets/assets/images/Terrain%2520(16x16).png": "df891f02449c0565d51e2bf7823a0e38",
"assets/assets/images/hud/menu_button.png": "16b5d854e31c25c6447606169d694bd9",
"assets/assets/images/hud/panel.png": "2c44ff41493776b220eafd0638717e49",
"assets/assets/images/hud/sound_button.png": "f36051fe2419c9672f66aadf1e8a0b98",
"assets/assets/images/hud/menu_panel.png": "2c44ff41493776b220eafd0638717e49",
"assets/assets/images/hud/pause_button.png": "a987e6376393d0b4748a80e059900636",
"assets/assets/sfx/shatter.mp3": "e139bc75888edd895ceb74efe8d714b3",
"assets/assets/sfx/level_complete.mp3": "4b4adccffa9c052b03b2ad3991b05a5d",
"assets/assets/sfx/coin.mp3": "78dccfdb37e2486661a3126b424a40c5",
"assets/assets/sfx/death.mp3": "2f2ec80eab06b94fbb144b7f0b46ef18",
"assets/assets/sfx/score.mp3": "78dccfdb37e2486661a3126b424a40c5",
"assets/assets/sfx/hit.mp3": "2ad0596329e52705eee878a3daa616d1",
"assets/assets/sfx/click.mp3": "86e3b8a75b9c567a00d2d298f8801a6c",
"assets/assets/sfx/damage1.mp3": "e73bde6e93a3754205a6960f994acf91",
"assets/assets/sfx/twang.mp3": "1e94e2d240b9f690536e1e98e9da7936",
"assets/assets/sfx/damage2.mp3": "3ae6d56c2fdff524875df5c956f62012",
"assets/assets/sfx/bottle_bang.mp3": "2435e55f2f943e89da6b5dad73c6e265",
"assets/assets/sfx/plastic.mov": "cef0f7e03058affcf981621ba3017f99",
"assets/assets/sfx/splat.mp3": "b2a46ff210713fad888745ca7ac249b6",
"assets/assets/sfx/jump.mp3": "77c58db6921be7b0c7a61903d38bbf30",
"assets/assets/sfx/equip.mp3": "4703c134afdf560228e73553f132fcf5",
"assets/assets/sfx/plastic.mp3": "a9322f602ea364bee65e41a34e803d44",
"assets/assets/tiles/level-3.tiled-session": "45a82275a9ab624db65556ea18f3cf57",
"assets/assets/tiles/gomi.tsx": "ceda1d01c2613d1d156ba8e599766af0",
"assets/assets/tiles/level_map.tmx": "03674844fc4dfba49c6dd7c3ae85a119",
"assets/assets/tiles/level-4.tiled-session": "1cfa9f085703286ffcd518885afa987f",
"assets/assets/tiles/tomato.tsx": "987e6e310189b82bd68a0d0581b7d742",
"assets/assets/tiles/light%2520bulb.tsx": "0de3dfd34ead77962b1bd1cf685e83d4",
"assets/assets/tiles/level-3.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/level-2.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/gomi_2.tsx": "bd85a65a3442c1d155e33a48a24b7081",
"assets/assets/tiles/water%2520bottle.tsx": "67150ed91dacd282e420bf47b82e81b5",
"assets/assets/tiles/level-1.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/kitchen-sink.tmx": "a9eeccf8b50c1d0c515e748c61585495",
"assets/assets/tiles/level_map.tsx": "af1d4bc9b1453466520e3bdc81ac6ec3",
"assets/assets/tiles/level-1.tmx": "3ef76ba24468e779cff85bd5ab12250e",
"assets/assets/tiles/level-2.tmx": "017995c70d5ac44ad9ee6ce345e61286",
"assets/assets/tiles/level-1.tiled-session": "2c24cac54822ddf820febcea91e48f3d",
"assets/assets/tiles/level-3.tmx": "a693ed0b7b9a1262f84354aa75cea6c2",
"assets/assets/tiles/level-2.tiled-session": "473fecae1d5732d9207fc9efc29811dd",
"assets/assets/tiles/level-6.tmx": "f2f19ae812402d587e01bc601c51d30a",
"assets/assets/tiles/level-4.tmx": "6e39ca9e0484f557250b73af1b5b9c54",
"assets/assets/tiles/level-5.tmx": "d6da6935bc778e80da5722c3aa26b43f",
"assets/assets/fonts/PressStart2P-Regular.ttf": "f98cd910425bf727bd54ce767a9b6884",
"assets/assets/fonts/Pixel.ttf": "80520f263d966b867eaf5f8ac5feac0a",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
