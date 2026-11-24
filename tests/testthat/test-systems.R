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

test_that("failed utility probes do not print conditions", {
  probe <- has_util
  probe_env <- new.env(parent = environment(probe))
  probe_env$Sys.which <- function(...) "/usr/bin/xclip"
  environment(probe) <- probe_env
  command <- c("xclip", "-o", "-selection", "clipboard")

  probe_env$system2 <- function(...) warning("xclip exited with status 1")
  expect_silent(expect_error(probe(command), msg_no_display(), fixed = TRUE))

  probe_env$system2 <- function(...) stop("Failed to execute xclip")
  expect_silent(expect_error(probe(command), msg_no_display(), fixed = TRUE))
})
