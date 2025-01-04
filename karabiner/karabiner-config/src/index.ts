import { map, modifierLayer, rule, writeToProfile } from "karabiner.ts";

writeToProfile("Default profile", [
  rule("Caps to Ctrl").manipulators([map("caps_lock").to("left_control")]),
  modifierLayer("option", "o", "open-layer")
    .description("Open apps")
    .leaderMode()
    .notification()
    .manipulators([
      map("w").toApp("Wezterm"),
      map("c").toApp("Google Chrome"),
      map("s").toApp("Safari"),
      map("o").toApp("Microsoft Outlook"),
    ]),
  modifierLayer("option", "m", "music-layer")
    .description("Apple Music")
    .leaderMode()
    .notification()
    .manipulators([
        map("a").to$("open -g raycast://extensions/fedevitaledev/music/play-library-album"),
        map("=").to$("open -g raycast://extensions/fedevitaledev/music/volume-up"),
        map("-").to$("open -g raycast://extensions/fedevitaledev/music/volume-down"),
        map("n").to$("open -g raycast://extensions/fedevitaledev/music/next-track"),
        map("p").to$("open -g raycast://extensions/fedevitaledev/music/previous-track"),
        map("spacebar").to$("open -g raycast://extensions/fedevitaledev/music/toggle-play-pause"),
    ]),
]);
