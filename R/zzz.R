.onAttach <- function(libname, pkgname) {
  packageStartupMessage("This is version ", packageVersion(pkgname),
                        " of ", pkgname, ".
                        By Gabriel N. Camargo-Toledo (c)
                        This is just a few misc things I have written")
}
