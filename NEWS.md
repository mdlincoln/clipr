## clipr 0.2.0

- Several changes to `write_clip`
    - The separator to be used when writing a character vector can now be
    explicitly declared using `breaks`. `breaks=NULL` will default to
    system-specific line breaks for both vectors and tables.
    - `write_clip` will default to formatting data.frames and matricies with 
  `write.table`, allowing easy pasting of tabular objects into programs like 
  Excel. Option `object_type="auto"` will check the object type to decide on the
  correct formatting, or the user may explicitly state `object_type="table"` or
  `object_type="character"`.
    - clipr will default to sane system-specific options for `write.table()`,
  however you may pass any custom desired options via `write_clip`
    - `return_new=TRUE` (the default behavior) will return the formatted 
  character string that was passed to the system clipboard, while 
  `write_clip(return_new=FALSE)` will return the original object.

- Introduces `clear_clip`, a wrapper function for `write_clip("")` for easy
clearing of the system clipboard.

## clipr 0.1.1

- Bug fix that removes the explicit test for "Linux" in favor of a check for
"xclip" or "xsel"
