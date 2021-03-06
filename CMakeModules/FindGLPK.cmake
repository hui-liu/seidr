# - Find GLPK (includes and library)
# This module defines
#  GLPK_INCLUDE_DIR
#  GLPK_LIBRARIES
#  GLPK_FOUND
# also defined, but not for general use are
#  GLPK_LIBRARY, where to find the library.

if (NOT "$ENV{GLPK_ROOT}" STREQUAL "")
  SET(GLPK_CUSTOM_PATH $ENV{GLPK_ROOT})
endif()

FIND_PATH(GLPK_INCLUDE_DIR glpk.h
/usr/include/
/usr/local/include/
/include
${GLPK_CUSTOM_PATH}/include
)

SET(GLPK_NAMES ${GLPK_NAMES} glpk)
FIND_LIBRARY(GLPK_LIBRARY
  NAMES ${GLPK_NAMES}
  PATHS /usr/lib /usr/local/lib /lib /usr/lib/glpk /usr/local/lib/glpk /lib/glpk ${GLPK_CUSTOM_PATH}/lib
  )

IF (GLPK_LIBRARY AND GLPK_INCLUDE_DIR)
    SET(GLPK_LIBRARIES ${GLPK_LIBRARY})
    SET(GLPK_FOUND "YES")
ELSE (GLPK_LIBRARY AND GLPK_INCLUDE_DIR)
  SET(GLPK_FOUND "NO")
ENDIF (GLPK_LIBRARY AND GLPK_INCLUDE_DIR)


IF (GLPK_FOUND)
   IF (NOT GLPK_FIND_QUIETLY)
      MESSAGE(STATUS "Found a GLPK library: ${GLPK_LIBRARIES}")
   ENDIF (NOT GLPK_FIND_QUIETLY)
ELSE (GLPK_FOUND)
   IF (GLPK_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find a GLPK library")
   ENDIF (GLPK_FIND_REQUIRED)
ENDIF (GLPK_FOUND)

# Deprecated declarations.
SET (NATIVE_GLPK_INCLUDE_PATH ${GLPK_INCLUDE_DIR} )
GET_FILENAME_COMPONENT (NATIVE_GLPK_LIB_PATH ${GLPK_LIBRARY} PATH)

MARK_AS_ADVANCED(
  GLPK_LIBRARY
  GLPK_INCLUDE_DIR
  )
