# clipr: Read and Write from the System Clipboard

Simple utility functions to read from and write to the Windows, OS X,
and X11 clipboards.

## Details

The basic functions
[`read_clip()`](http://matthewlincoln.net/clipr/reference/read_clip.md)
and
[`write_clip()`](http://matthewlincoln.net/clipr/reference/write_clip.md)
wrap platform-specific functions for writing values from R to the system
clipboard.
[`read_clip_tbl()`](http://matthewlincoln.net/clipr/reference/read_clip_tbl.md)
will attempt to process the clipboard content like a table copied from a
spreadsheet program.

[`clipr_available()`](http://matthewlincoln.net/clipr/reference/clipr_available.md)
is useful when building packages that depend on clipr functionality.
