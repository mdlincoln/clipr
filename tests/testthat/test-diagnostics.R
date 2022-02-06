context("diagnostics")

test_that("clipr_available fails when DISPLAY is not configured; succeeds when it is", {
  # Only run this test on Github Actions
  skip_if_not(identical(Sys.getenv("GITHUB_ACTIONS"), "true"))

  # If this envar hasn't been set, confirm that is_clipr_available will be false
  # and write_clip will error
  if (identical(Sys.getenv("CLIPR_ALLOW"), "")) {
    expect_false(is_clipr_available)
    expect_error(write_clip("test"))
  } else {
    if (identical(Sys.getenv("CLIP_TYPE"), "none"))
      expect_false(is_clipr_available)
    if (identical(Sys.getenv("CLIP_TYPE"), "xclip"))
      expect_true(is_clipr_available)
    if (identical(Sys.getenv("CLIP_TYPE"), "xsel"))
      expect_true(is_clipr_available)
    if (identical(Sys.getenv("CLIP_TYPE"), "wayland"))
      expect_true(is_clipr_available)
  }
})

test_that("dr_clipr provides informative messages", {
  if (identical(Sys.getenv("CLIPR_ALLOW"), "")) {
    expect_message(dr_clipr(), "CLIPR_ALLOW", fixed = TRUE)
  } else {
    if (identical(Sys.getenv("CLIP_TYPE"), "xclip"))
      expect_message(dr_clipr(), msg_clipr_available(), fixed = TRUE)
    if (identical(Sys.getenv("CLIP_TYPE"), "xsel"))
      expect_message(dr_clipr(), msg_clipr_available(), fixed = TRUE)
    if (identical(Sys.getenv("CLIP_TYPE"), "wayland"))
      expect_message(dr_clipr(), msg_clipr_available(), fixed = TRUE)
    if (identical(Sys.getenv("CLIP_TYPE"), "none"))
      expect_message(dr_clipr(), msg_no_clipboard(), fixed = TRUE)
    if (identical(Sys.getenv("CLIP_TYPE"), "nodisplay"))
      expect_message(dr_clipr(), msg_no_display(), fixed = TRUE)

    expect_true(grepl("has read/write access", msg_clipr_available()))
    expect_true(grepl("requires 'xclip'", msg_no_clipboard()))
    expect_true(grepl("requires that the DISPLAY", msg_no_display()))
  }
})

test_that("Unavailable clipboard throws warning", {
  if (!is_clipr_available) {
    expect_error(write_clip("a"))
  }
})

test_that("clipr_available() does not overwrite existing contents", {
  skip_if_not(is_clipr_available, skip_msg)
  write_clip("z")
  clipr_available()
  expect_equal(read_clip(), "z")
})
