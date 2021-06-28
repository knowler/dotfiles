require('stackline'):init {
  appearance = {
    alpha = 1,
    color = { white = 0.90 },
    dimmer = 2.5,
    fadeDuration = 0.2,
    iconDimmer = 1.1,
    iconPadding = 4,
    offset = { x = 4, y = 2 },
    pillThinness = 6,
    radius = 3,
    shouldFade = true,
    showIcons = false,
    size = 32,
    vertSpacing = 1.2,
  },
  features = {
    clickToFocus = true,
    dynamicLuminosity = true,
    fzyFrameDetect = {
      enabled = true,
      fuzzFactor = 30,
    },
    hsBugWorkaround = true,
    winTitles = 'when_switching',
  },
  advanced = {
    maxRefreshRate = 0.3,
  },
}
