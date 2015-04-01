# separate-files

This shell script finds all 'companion' files (i.e. the files that differ from the base files with just extension) and moves them to a different directory while preserving the directory structure.

You might find it useful for separating NEFs or DNGs (or any other RAW format digital image files) from JPGs if your camera generates both of them and you want to, for example, delete the latter.

```bash
separate-files ~/photos ~/photo-dupes NEF JPG 
```
-- moves all jpegs that have corresponding NEFs from photos to photo-dupes for, supposedly, further processing or deleting.

Note: This script is non-destructive. I.e. it WILL NOT delete anything -- it'll just MOVE it. The user is responsible to performing any destructive actions by himself.
