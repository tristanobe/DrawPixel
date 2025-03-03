outputdir 		= ""
build 			= ""
build_obj 		= ""

external = {}
external.path = "%{wks.location}/External"
external.libs = external.path .. "/Libs"

libs = {}
--libs.sdl3 = {
--    include = external.libs .. "/SDL3/include",
--    lib = {
--        msvc = external.libs .. "/SDL3/msvc/x64",
--        mingw = external.libs .. "/SDL3/mingw/lib",
--        android = external.libs .. "/SDL3/android",
--    }
--}

function OutputDir()
    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
end

function BuildDir()
    build = "%{wks.location}/build/bin/"
end

function BuildIntDir()
    build_obj = "%{wks.location}/build/obj/"
end

function BuildsInfos(projectName)
    targetdir ( build .. outputdir .. "/" .. projectName )
    objdir ( build_obj .. outputdir .. "/" .. projectName )
end

function PostBuilds(libName, projectName)
    if libraryType == "SharedLib" then
        postbuildcommands {
            ("{COPY} " .. build .. outputdir .. "/" .. libName .. "/" .. libName .. ".dll " .. build .. outputdir .. "/" .. projectName),
        }
    end
end

function PostBuilds2(path, libName, projectName)
    postbuildcommands {
        ("{COPY} " .. path .. "/" .. libName .. ".dll " .. build .. outputdir .. "/" .. projectName),
    }
end

--premake5.lua (à la racine)
workspace "DrawPixel"
    configurations { "Debug", "Release" }
    platforms { "x64" }
    
    -- Définit un dossier de sortie basé sur la configuration, le système et l'architecture
    OutputDir()
    BuildDir()
    BuildIntDir()

    -- Détection automatique du compilateur
    filter "system:windows"
        toolset "clang"  -- Utiliser ClangCL sous Windows

    filter "system:linux or system:macosx"
        toolset "clang"  -- Utiliser Clang natif sous Linux/macOS

    -- Configuration globale Debug
    filter "configurations:Debug"
        symbols "On"
        optimize "Off"
        defines { "DEBUG" }

    -- Configuration globale Release
    filter "configurations:Release"
        optimize "On"
        symbols "Off"
        defines { "NDEBUG" }

    include "DrawPixel"
