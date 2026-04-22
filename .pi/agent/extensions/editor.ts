import {
  CustomEditor,
  type ExtensionAPI,
} from "@mariozechner/pi-coding-agent";
export default function (pi: ExtensionAPI) {

  pi.on("session_start", (_event, ctx) => {
    ctx.ui.setEditorComponent((tui, theme, keybindings) => {
      const editor = new CustomEditor(tui, theme, keybindings);
      Object.defineProperty(editor, "borderColor", {
        // Use the theme passed to the factory, not ctx.ui.theme, to avoid
        // accessing a stale ExtensionContext during session shutdown.
        get: () => (str: string) => ctx.ui.theme.fg("border", str),
        set: () => {
          // Border ownership stays with the editor, so ignore attempts to set it from outside
        },
      });
      return editor;
    });

  })

  pi.on("session_shutdown", (_event, ctx) => {
    ctx.ui.setEditorComponent(undefined);
  });
}

