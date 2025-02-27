.onAttach <- function(libname, pkgname) {
  packageStartupMessage("              This is version ", packageVersion(pkgname),
                        " of ", pkgname, ".
                        By Gabriel N. Camargo-Toledo (c)
                        This package has access to classes for RRII quant methods
                        and packages needed for that class.
                        You can start class 5 doing open_class_doc(5)")
}
