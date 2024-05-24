import { map, modifierLayer, rule, writeToProfile } from "karabiner.ts";

writeToProfile("Default profile", [
  rule("Caps to Ctrl").manipulators([map("caps_lock").to("left_control")]),
  modifierLayer("option", "o", "open-layer")
    .description("Open apps")
    .leaderMode()
    .notification()
    .manipulators([map("w").to$("wezterm start"), map("c").toApp("Google Chrome"), map("s").toApp("Safari")]),
  modifierLayer("option", "w", "window-layer")
    .description("Window management")
    .leaderMode({ sticky: true })
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
      map("f").to$(
        "open -g raycast://extensions/raycast/window-management/maximize",
      ),
    ]),
]);

