add_executable(appimagelight
    appimagetool.c
    appimagetool_sign.c
    appimagetool_fetch_runtime.cpp
    hexlify.c
    elf.c
    digest.c
    md5.c
)

target_link_libraries(appimagelight
    ${CMAKE_DL_LIBS}
    PkgConfig::libglib
    PkgConfig::libgio
    PkgConfig::libgcrypt
    PkgConfig::libgpgme
    PkgConfig::libcurl
)

target_compile_definitions(appimagelight
    PRIVATE -D_FILE_OFFSET_BITS=64
    PRIVATE -DGIT_VERSION="${GIT_VERSION}"
    PRIVATE -DBUILD_NUMBER="${BUILD_NUMBER}"
    PRIVATE -DBUILD_DATE="${DATE}"
)

target_include_directories(appimagelight
    PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/>
           $<BUILD_INTERFACE:${ARGP_INCLUDE_DIR}>
    INTERFACE $<INSTALL_INTERFACE:include/>
)

install(
    TARGETS appimagelight
    RUNTIME DESTINATION bin
)

# install additional resources
install(
    FILES "${PROJECT_SOURCE_DIR}/resources/appimagetool.desktop"
    DESTINATION share/applications
)
install(
    FILES "${PROJECT_SOURCE_DIR}/resources/appimagetool.png"
    DESTINATION share/icons/hicolor/128x128/apps
)
install(
    FILES "${PROJECT_SOURCE_DIR}/resources/appimagetool.appdata.xml"
    DESTINATION share/metainfo
)
