# MacOS 11+ (Big Sur, Monterey, +) R Toolchain preparation

The R Toolchain installer doesn't seem to work but we have had success with manual installation as follows.

1. Uninstall the toolchain following here: https://thecoatlessprofessor.com/programming/r/uninstalling-the-r-development-toolchain-on-macos/. You may not have the toolchain installed but go through all of these steps anyway to ensure all components are removed.

2. Next, from the Mac terminal: 
   
   ```bash
   sudo pkgutil --forget com.gnu.gfortran
   ```

3. Reinstall X tools. From the Mac terminal:
   
   ```bash
   xcode-select --install
   ```

4. From the Mac terminal, verify installation
   
   ```bash
   gcc --version
   ```

5. If you have an Intel-based Mac, get `gfortran-Intel-11.2-BigSur.dmg` or `gfortran-Intel-11.2-Monterey.dmg` (depending on your version of MacOS; [how to find your version](https://support.apple.com/en-us/HT201260)) from https://github.com/fxcoudert/gfortran-for-macOS/releases and install it. It is possible that more recent versions of gfortran might also work but we haven't confirmed. It is possible that you may need an earlier version of gfortran if you have an older version of MacOS. If you have one of the new M1 (i.e. ARM) Macs, you will need `gfortran-ARM-11.3-Monterey.dmg`.

6. Install required binary components `pcre2` and `xz` following directions here: https://cran.r-project.org/doc/manuals/r-release/R-admin.html#macOS (i.e. enter the `curl ...` and `sudo tar ...` commands as listed under "For example" into the Mac terminal).

7. Restart R and test that packages can be installed from source. This will install the jsonlite package as a test.
   
   ```R
   install.packages("jsonlite", type = "source")
   ```

8. The C toolchain is now installed. Continue with instructions for installing RStan.
