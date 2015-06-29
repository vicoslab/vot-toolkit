Utilities module
================

This module contains general utility functions that are used all over the toolkit.

Module functions
----------------

### Files

-   [readfile](readfile.m) - Parse a file to a cell array
-   [readstruct](readstruct.m) - Read a key-value file to a structure
-   [writestruct](writestruct.m) - Store a structure to file
-   [file_newer_than](file_newer_than.m) - Test if the first file is newer than the second file
-   [generate_from_template](generate_from_template.m) - Generate a new file from a template file
-   [rmpath](rmpah.m) - Deletes the file or directory recursively
-   [mkpath](mkpath.m) - Creates a directory path
-   [relativepath](relativepath.m) - Returns the relative path from an root path to the target path

### Figures

-   [plotc](is_octave.m) - Plot closed polygon
-   [sfigure](is_octave.m) - Silently creates a figure window
-   [export_figure](export_figure.m) - Export a figure to various formats

### General

-   [is_octave](is_octave.m) - Test if in GNU/Octave or Matlab
-   [iterate](iterate.m) - Iterates over experiment, tracker and sequence triplets
-   [iff](iff.m) - A simulation of inline conditional statement
-   [md5hash](md5hash.m) - Calculate 128 bit MD5 checksum
-   [struct_merge](struct_merge.m) - Merges a from structure to another in a recursive manner
-   [strjoin](strjoin.m) - Joins multiple strings
-   [format_interval](format_interval.m) - Format a time interval
-   [patch_operation](patch_operation.m) - Performs a point-wise operation with two unequal matrices
-   [compile_all_native](compile_all_native.m) - Compile all native components
-   [compile_mex](compile_mex.m) - Compile given source files to a MEX function

