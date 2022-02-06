context("systems")

test_that("utility checking works on Linux-like", {

  if (identical(Sys.getenv("CLIP_TYPE"), "xclip")) {
    expect_true(has_xclip())
    expect_false(has_xsel())
    expect_false(has_wl_clipboard())
  }

  if (identical(Sys.getenv("CLIP_TYPE"), "xsel")) {
    expect_false(has_xclip())
    expect_true(has_xsel())
    expect_false(has_wl_clipboard())
  }

  if (identical(Sys.getenv("CLIP_TYPE"), "wayland")) {
    expect_false(has_xclip())
    expect_false(has_xsel())
    expect_true(has_wl_clipboard())
  }

  if (identical(Sys.getenv("CLIP_TYPE"), "none")) {
    expect_false(has_xclip())
    expect_false(has_xsel())
    expect_false(has_wl_clipboard())
  }

  if (identical(Sys.getenv("CLIP_TYPE"), "nodisplay")) {
    expect_error(has_xclip())
    expect_false(has_xsel())
    expect_false(has_wl_clipboard())
  }
})
