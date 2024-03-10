'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "3ed5a342b5e4a3f21fe29e92abfb7ee4",
"index.html": "3d5d037f53e8860c772b25dfb2c80c72",
"/": "3d5d037f53e8860c772b25dfb2c80c72",
"main.dart.js": "e27954561ebad3f4328abe335e995611",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "b2fd583728e75411a17a7c1eb3ae624c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "696fd0cadbc6aa5dc1a1efb667d23602",
"assets/AssetManifest.json": "a9f472e53032575b26b9d7b69c8e93f0",
"assets/NOTICES": "fe662ee91cbe5d21444e60a6d7098461",
"assets/FontManifest.json": "8d03bf0076e389be2835f7be5a73f727",
"assets/AssetManifest.bin.json": "a892e0b02b230ec72653b80e107bf8bd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/add_to_google_wallet/assets/svg/buttons/br_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/es419_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/se_add_to_google_wallet_wallet-button.svg": "4f87e7ee56c9aeddf475f1a4c6abd375",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pt_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lt_add_to_google_wallet_wallet-button.svg": "cb8ba3e609a1b57f225f05eaddcb8e19",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sq_add_to_google_wallet_wallet-button.svg": "e568f2f0545c2993b412f7f5b42320ec",
"assets/packages/add_to_google_wallet/assets/svg/buttons/vi_add_to_google_wallet_wallet-button.svg": "35162663f63d206ae1e2cc30be7cfffc",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ar_add_to_google_wallet_wallet-button.svg": "8ed2b5dc8ea42390bc1f22f9814954b0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sr_add_to_google_wallet_wallet-button.svg": "fda80812ddb5b99cf767ed19a6ceefea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fl_add_to_google_wallet_wallet-button.svg": "d5141c1d2fa7c71f6d3f8024e60980a4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/it_add_to_google_wallet_wallet-button.svg": "fbdc320908b10990db14acc6f433ac7c",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frFR_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/de_add_to_google_wallet_wallet-button.svg": "bfb158c4b084482543e8ef901df02d21",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pl_add_to_google_wallet_wallet-button.svg": "72e75b2a37a77648f882878b4512952b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhTW_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ro_add_to_google_wallet_wallet-button.svg": "406323ed5b974f0f67fa516f7653bde0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/no_add_to_google_wallet_wallet-button.svg": "87eac0605cbb7056f2e32e270da14d07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sl_add_to_google_wallet_wallet-button.svg": "f89a88aa0b6dfb367c74c621bda15ffd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hr_add_to_google_wallet_wallet-button.svg": "b6d10a9fbd63b345fc2825b1e4a3abf0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/tr_add_to_google_wallet_wallet-button.svg": "f1b61f991a8ab72fe7833d054aab7e97",
"assets/packages/add_to_google_wallet/assets/svg/buttons/gr_add_to_google_wallet_wallet-button.svg": "64c855f01d129b8d71ceeea8ed2a3d71",
"assets/packages/add_to_google_wallet/assets/svg/buttons/he_add_to_google_wallet_wallet-button.svg": "a9a052a290a19f712a6685bbcd190ca0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/nl_add_to_google_wallet_wallet-button.svg": "efaee620d9c06b1fd5181f2b2395a3d1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/et_add_to_google_wallet_wallet-button.svg": "c0b6fbcba5ea9e222d49da62d55c1f07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/az_add_to_google_wallet_wallet-button.svg": "1c545af772b2f9b1e50b23b63c9f98da",
"assets/packages/add_to_google_wallet/assets/svg/buttons/is_add_to_google_wallet_wallet-button.svg": "cb03001a5ab3d58ebbfa3d6472aa4a23",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ka_add_to_google_wallet_wallet-button.svg": "be97561ee61811a8ac3dc8128b5301e8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esUS_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fp_add_to_google_wallet_wallet-button.svg": "23b16942ca07f225da0d4ff044825213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/id_add_to_google_wallet_wallet-button.svg": "7139c1614230fce1ea41c7f9cadda52f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enCA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/mk_add_to_google_wallet_wallet-button.svg": "ec59cda1b4b0569349d5b04b5fecb177",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enSG_add_to_google_wallet_wallet-button.svg": "568708442552f3b3caaf6161f4868d72",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enIN_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enAU_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/my_add_to_google_wallet_wallet-button.svg": "04157e592054aabc39fd2215792baaea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sk_add_to_google_wallet_wallet-button.svg": "b16f6ed9494595a14ade427d4db1b0b1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hu_add_to_google_wallet_wallet-button.svg": "e534db0e513768092bc4c2b6b4e3beea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/by_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/jp_add_to_google_wallet_wallet-button.svg": "d139a2176756c1b0ccf9c033450d4473",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esES_add_to_google_wallet_wallet-button.svg": "5946c137c2cb5015d3bb2d2b89bbfa2f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/cz_add_to_google_wallet_wallet-button.svg": "f3f2178af2bc4cdf103826cd98c9369b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/dk_add_to_google_wallet_wallet-button.svg": "60d5092f469e20135016aaf3cc5d213b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hy_add_to_google_wallet_wallet-button.svg": "86474c2f3e14d467e45a8b9c2b81402b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uz_add_to_google_wallet_wallet-button.svg": "9426afa0cd9540106ef93fd46a1fd217",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ca_add_to_google_wallet_wallet-button.svg": "0a4925620a47363661cb7a51b4ab5a58",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lv_add_to_google_wallet_wallet-button.svg": "943d879ec5f1533769d3bc60e849d213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enUS_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/kk_add_to_google_wallet_wallet-button.svg": "cecbc3f3d7973d388b088294b1ea265a",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uk_add_to_google_wallet_wallet-button.svg": "6835dbf7541d926e3d9367fd67c703d4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ky_add_to_google_wallet_wallet-button.svg": "157b7963b74a17c4bfd5de0db482b399",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bs_add_to_google_wallet_wallet-button.svg": "6aa017fb69dfc3cf76058285e1d630d8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/th_add_to_google_wallet_wallet-button.svg": "ab9c343ba68db03201e572a234cb5412",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhHK_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bg_add_to_google_wallet_wallet-button.svg": "fb36a9dd4688eabe5e9e50b029564227",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frCA_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ru_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enGB_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enZA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "fa4a78fee9ef5655be2349fb0ecb7641",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/music/free_run.mp3": "c700cf7861e33436a916cdf7e5da4e5b",
"assets/assets/music/gomi_groove-alt.mp3": "804a6c78989ae75ec388147c6c74b8dc",
"assets/assets/music/CREDITS.TXT": "664b159f17146e56808c4e23d7603f6e",
"assets/assets/music/theme.mp3": "39f1517dd4e0f1bedc06eb37c9169346",
"assets/assets/music/victory.mp3": "4ff0123341d5e05f819a46ebe1732fb7",
"assets/assets/music/bit_forrest.mp3": "f330991a5bd6973c5d1167619319abd0",
"assets/assets/music/gomi_groove.mp3": "ca45c4280b54071679c7de1f388ad6ea",
"assets/assets/music/tropical_fantasy.mp3": "44bdafbd3982d2ba451f225294f56dff",
"assets/assets/images/instructions/instruction_3.png": "73a92300ca43374d422622bed3f94df2",
"assets/assets/images/instructions/instruction_2.png": "bf3d2d201399a26e4f0cd213189d0ac1",
"assets/assets/images/instructions/instruction_1.png": "73a92300ca43374d422622bed3f94df2",
"assets/assets/images/instructions/instruction_5.png": "76af6d6ec975107dbce611fa14d25b6b",
"assets/assets/images/instructions/instruction_4.png": "73a92300ca43374d422622bed3f94df2",
"assets/assets/images/instructions/instruction_6.png": "76af6d6ec975107dbce611fa14d25b6b",
"assets/assets/images/instructions/instruction_7.png": "76af6d6ec975107dbce611fa14d25b6b",
"assets/assets/images/collectibles/seed/grow.png": "f4f1dcbdfa563949d882bf9247bf4f05",
"assets/assets/images/collectibles/seed/idle.png": "3bc9b1a12e5d1b641197d878016a899c",
"assets/assets/images/collectibles/coin.png": "2839d191a95beb5f8429b762464b7a18",
"assets/assets/images/bonus_level_button.png": "c28164b2023f4201b5f46c2be38ffc8c",
"assets/assets/images/title.png": "11464e556895dd37fcfe0cbc318dd932",
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
"assets/assets/images/main_menu_bg.png": "650fc881c878d5d397ddf4da285cb262",
"assets/assets/images/level_button.png": "b8026c32f31ec2317c2f82366679e4fb",
"assets/assets/images/world_map.png": "58ecb3e6190d09945007e1d99f52ae5e",
"assets/assets/images/empty_level_button.png": "d7241f0143457e32804c5978fe6d0824",
"assets/assets/images/gomi-logo.png": "b2fd583728e75411a17a7c1eb3ae624c",
"assets/assets/images/splash.png": "c594f77cadc1061d8d3bf4f50e06fae7",
"assets/assets/images/powerups/spike.png": "ba17bf58c184cc1682625426d3d7d398",
"assets/assets/images/powerups/grabber.png": "b9be2c04e5d218f0f1dfa0f50fa45c41",
"assets/assets/images/icons/right_chevron.png": "524227ca11a9dc98cd1794ef220117a6",
"assets/assets/images/icons/left_chevron.png": "7b8b02655de4538068c4496650c15ffe",
"assets/assets/images/icons/close.png": "543f5b3997ea5af9c8699cc7c5522aff",
"assets/assets/images/tutorials/tutorial_1.png": "d39483a87af693a8fafa7f9e251d2b57",
"assets/assets/images/tutorials/tutorial_3.png": "45164801421af7e7f27db196e83a4e39",
"assets/assets/images/tutorials/tutorial_2.png": "6adea64ff96bb04722543d92a5824f66",
"assets/assets/images/tutorials/tutorial_6.png": "380110b8cb2b9e570a24a14ee25186de",
"assets/assets/images/tutorials/tutorial_7.png": "613027204479f134c36b89f3384ac6bc",
"assets/assets/images/tutorials/tutorial_5.png": "cd2fdeaa94aa4444ca442c2b67b88e4d",
"assets/assets/images/tutorials/tutorial_4.png": "8ca4a2db5a8e9a5963c4eed15288c7a8",
"assets/assets/images/hero-banner.png": "6e058ad65992832fa0963dc64ab45088",
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
"assets/assets/images/enemies/syringe/idle.png": "d685ca74bdf500e12746175253225bff",
"assets/assets/images/enemies/syringe/attack.png": "7b1a603898c4897871cecc3454968a04",
"assets/assets/images/enemies/tomato/rising.png": "3ad410bd67c25e9b4abef16e8247bb4c",
"assets/assets/images/enemies/tomato/idle.png": "3b84260140afbe56f311d7c3732af70c",
"assets/assets/images/enemies/tomato/ground.png": "fee9a803acf1c5398b22b44f955b8e63",
"assets/assets/images/enemies/tomato/attack.png": "29f1dc49d0ccebc5c207c29f02931517",
"assets/assets/images/enemies/tomato/falling.png": "8c1071d84440045a4083209800e22eab",
"assets/assets/images/enemies/tomato/apex.png": "25790c0593379d4b3d294116e8087a24",
"assets/assets/images/Terrain%2520(16x16).png": "df891f02449c0565d51e2bf7823a0e38",
"assets/assets/images/hud/menu_button.png": "16b5d854e31c25c6447606169d694bd9",
"assets/assets/images/hud/left_arrow.png": "7c6ddfae6262bbcd98c8a6d6e1d20f61",
"assets/assets/images/hud/right_arrow.png": "29170521378d19b5640ad4761448e421",
"assets/assets/images/hud/panel.png": "2c44ff41493776b220eafd0638717e49",
"assets/assets/images/hud/power_up_button.png": "5c2d4064d75a17f533a380b36ff22ad8",
"assets/assets/images/hud/sound_button.png": "f36051fe2419c9672f66aadf1e8a0b98",
"assets/assets/images/hud/menu_panel.png": "2c44ff41493776b220eafd0638717e49",
"assets/assets/images/hud/up_arrow.png": "104a33558533d0d3ce0b94acd4c3a4a4",
"assets/assets/images/hud/pause_button.png": "a987e6376393d0b4748a80e059900636",
"assets/assets/sfx/shatter.mp3": "e139bc75888edd895ceb74efe8d714b3",
"assets/assets/sfx/level_complete.mp3": "4b4adccffa9c052b03b2ad3991b05a5d",
"assets/assets/sfx/coin.mp3": "78dccfdb37e2486661a3126b424a40c5",
"assets/assets/sfx/death.mp3": "2f2ec80eab06b94fbb144b7f0b46ef18",
"assets/assets/sfx/hit.mp3": "780fcb6ce9360e6f1e59843f38e4790b",
"assets/assets/sfx/click.mp3": "86e3b8a75b9c567a00d2d298f8801a6c",
"assets/assets/sfx/twang.mp3": "1e94e2d240b9f690536e1e98e9da7936",
"assets/assets/sfx/splat.mp3": "b2a46ff210713fad888745ca7ac249b6",
"assets/assets/sfx/jump.mp3": "77c58db6921be7b0c7a61903d38bbf30",
"assets/assets/sfx/equip.mp3": "4703c134afdf560228e73553f132fcf5",
"assets/assets/sfx/plastic.mp3": "a9322f602ea364bee65e41a34e803d44",
"assets/assets/tiles/gomi.tsx": "ceda1d01c2613d1d156ba8e599766af0",
"assets/assets/tiles/world_map.tsx": "1026d5215f93ebe715aa19a911472e7a",
"assets/assets/tiles/level_3.tmx": "a0ec997ccd69b011c5fae935c5061686",
"assets/assets/tiles/level_2.tmx": "d9a1ac74fcaa51a6b39469dc6ae10575",
"assets/assets/tiles/level_1.tmx": "1866058d8c7ab04910c7a48915098f29",
"assets/assets/tiles/gomi_2.tsx": "bd85a65a3442c1d155e33a48a24b7081",
"assets/assets/tiles/level_5.tmx": "5652dfd7ccfcec2036eb514340fb8278",
"assets/assets/tiles/level_4.tmx": "41b91d39d96433915b51dac3f8c281bb",
"assets/assets/tiles/level_6.tmx": "d6a041657da4dc0597bf28733e977c1f",
"assets/assets/tiles/level_7.tmx": "7e4184f720535ac1082c42e0c024611d",
"assets/assets/tiles/world_map.tmx": "61b4061fb0cb536688695e76b41c575f",
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
