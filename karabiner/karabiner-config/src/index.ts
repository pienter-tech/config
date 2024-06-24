import { map, modifierLayer, rule, writeToProfile } from "karabiner.ts";

writeToProfile("Default profile", [
  rule("Caps to Ctrl").manipulators([map("caps_lock").to("left_control")]),
  modifierLayer("option", "o", "open-layer")
    .description("Open apps")
    .leaderMode()
    .notification()
    .manipulators([
      map("w").to$(
        "open -g raycast://extensions/warpdotdev/warp/launch-config",
      ),
      map("c").toApp("Google Chrome"),
      map("s").toApp("Safari"),
      map("o").toApp("Microsoft Outlook"),
    ]),
  modifierLayer("option", "w", "window-layer")
    .description("Window management")
    .leaderMode({
      sticky: true,
      escape: ["spacebar", "return_or_enter", "escape", "caps_lock"],
    })
    .notification()
    .manipulators([
      map("h").to$(
        "open -g raycast://extensions/raycast/window-management/left-half",
      ),
      map("l").to$(
        "open -g raycast://extensions/raycast/window-management/right-half",
      ),
      map("k").to$(
        "open -g raycast://extensions/raycast/window-management/top-half",
      ),
      map("j").to$(
        "open -g raycast://extensions/raycast/window-management/bottom-half",
      ),
      map("o").to$(
        "open -g raycast://extensions/raycast/window-management/almost-maximize",
      ),
      map("p").to$(
        "open -g raycast://customWindowManagementCommand?&name=Focus&position=center&relativeWidth=0.95&relativeHeight=0.95",
      ),
      map("f").to$(
        "open -g raycast://extensions/raycast/window-management/maximize",
      ),
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
