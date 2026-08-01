# BTBT Track Assets

Public backing-track visual assets used by the Backing Tracks By Tim workflow.

## Structure

```text
tracks/
  track-slug/
    chord-chart.png
    scale-diagram.png
```

Raw asset URLs use this pattern:

```text
https://raw.githubusercontent.com/TimLemke/btbt-track-assets/main/tracks/track-slug/chord-chart.png
https://raw.githubusercontent.com/TimLemke/btbt-track-assets/main/tracks/track-slug/scale-diagram.png
```

## Publish Assets

Use `scripts/publish-track-assets.sh` to copy a rendered chord chart and scale diagram into the repo, commit them, push them, and print the raw GitHub URLs.

```bash
scripts/publish-track-assets.sh \
  "glass-skyline-fsharp-minor-90" \
  "/path/to/chord-chart.png" \
  "/path/to/scale-diagram.png"
```
