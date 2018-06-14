context("diagnostics")

test_that("clipr_available fails when DISPLAY is not configured; succeeds when it is", {
  # Only run this test on Travis
  skip_if_not(identical(Sys.getenv("TRAVIS"), "true"))
  if (identical(Sys.getenv("TRAVIS_CLIP"), "none"))
    expect_false(is_clipr_available)
  if (identical(Sys.getenv("TRAVIS_CLIP"), "xclip"))
    expect_true(is_clipr_available)
  if (identical(Sys.getenv("TRAVIS_CLIP"), "xsel"))
    expect_true(is_clipr_available)
})

test_that("dr_clipr provides informative messages", {
  if (identical(Sys.getenv("TRAVIS_CLIP"), "xclip"))
    expect_message(dr_clipr(), msg_clipr_available(), fixed = TRUE)
  if (identical(Sys.getenv("TRAVIS_CLIP"), "xsel"))
    expect_message(dr_clipr(), msg_clipr_available(), fixed = TRUE)
  if (identical(Sys.getenv("TRAVIS_CLIP"), "none"))
    expect_message(dr_clipr(), msg_no_clipboard(), fixed = TRUE)
  if (identical(Sys.getenv("TRAVIS_CLIP"), "nodisplay"))
    expect_message(dr_clipr(), msg_no_display(), fixed = TRUE)

  expect_true(grepl("has read/write access", msg_clipr_available()))
  expect_true(grepl("requires 'xclip'", msg_no_clipboard()))
  expect_true(grepl("requires that the DISPLAY", msg_no_display()))
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
