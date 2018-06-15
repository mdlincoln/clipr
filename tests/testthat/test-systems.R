context("systems")

test_that("utility checking works on Linux-like", {

  if (identical(Sys.getenv("TRAVIS_CLIP"), "xclip")) {
    expect_true(has_xclip())
    expect_false(has_xsel())
  }

  if (identical(Sys.getenv("TRAVIS_CLIP"), "xsel")) {
    expect_false(has_xclip())
    expect_true(has_xsel())
  }

  if (identical(Sys.getenv("TRAVIS_CLIP"), "none")) {
    expect_false(has_xclip())
    expect_false(has_xsel())
  }

  if (identical(Sys.getenv("TRAVIS_CLIP"), "nodisplay")) {
    expect_error(has_xclip())
    expect_false(has_xsel())
  }
})
